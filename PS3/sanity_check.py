#!/usr/bin/env python

"""
CS 145 PS1 Submission Template Sanity Checker

Validates XML submission templates for problem set 1, ensuring that 
the submission is well-formed and contains all required answers and fields.

THIS SCRIPT DOES NOT RUN THE STUDENT ANSWERS OR VALIDATE THE SQL.
It simply ensures that the XML can be parsed by the autograder.
"""

from __future__ import print_function
import sys
import os
import re
import xml.etree.cElementTree as ET

# Default file name for student submission.
DEFAULT_PATH = 'submission_template.txt'

# Required problems. (Excludes optional/bonus questions.)
PROBLEMS = frozenset([
    '1a', '1b_i', '1b_ii', '1b_iii', '1c',
    '2a', '2b', '2c',
    '3',
    '4a_i', '4a_ii', '4a_iii', '4b',
    'bonus_problem'
])


def validate(root, required_problems=PROBLEMS):
    is_valid = True

    # Track which problems we've seen.
    seen_problems = set()

    for node in root:
        if node.tag == 'student':
            if len(node) < 2:
                print("ERROR: Incomplete <student> element. " \
                      "<name> and <sunet> tags are required.")
                is_valid = False
                continue

            # Validate student name.
            name, sunet = node[0], node[1]
            if not name.text.strip():
                print("ERROR: Student name is blank.")
                is_valid = False

            # Validate SUNet ID. In particular, ensure that it is at least
            # 8 characters and contains at least one letter (to guard against
            # SUID numbers instead of SUNet IDs).
            sunet_id = sunet.text.strip()
            if (not 0 < len(sunet_id) <= 8 
                    or re.search('[a-zA-Z]', sunet_id) is None):
                print("ERROR: Missing or invalid SUNet ID: '{}'".format(
                    sunet_id))
                is_valid = False

        if node.tag == 'answer':
            # Get the problem number.
            if 'number' not in node.attrib:
                print("Error: <answer> tag does not have number attribute.")
                is_valid = False
                continue
            problem = node.attrib['number']
            
            # Mark that we've seen this problem.
            if problem in seen_problems:
                print("ERROR: Problem {} is defined multiple times.".format(
                    problem))
                is_valid = False
            else:
                seen_problems.add(problem)

            # Get <answer> tag contents, removing leading/trailing whitespace.
            answer = node.text.strip()
            if not answer:
                print("WARNING: Empty answer for problem {}.".format(problem))
                # Do not set is_valid to False since student may be skipping
                # question. This is technically valid.

            if answer.startswith('%sql') or answer.startswith('%%sql'):
                print("ERROR: Answer {} starts with an IPython command " \
                      "('%sql' or '%%sql').".format(problem))

    # Were any required problems not encountered?
    missing = required_problems - seen_problems
    if missing:
        print("WARNING: Answers were not found for the following problems:")
        print(", ".join(missing))
        is_valid = False

    return is_valid


def main(argv):
    submission = argv[1] if len(argv) > 1 else DEFAULT_PATH

    print("Sanity checking file '{}'...".format(submission))

    # Check if path exists and is a file.
    if not os.path.isfile(submission):
        print("ERROR: File '{}' does not exist.".format(submission))
        return 1

    # Attempt to parse file as XML.
    try:
        tree = ET.parse(submission)
    except ET.ParseError as e:
        print("ERROR: Failed to parse file '{}'.".format(submission))
        print("The parser reported the following error:")
        print(e)
        return 1

    # Get root element.
    root = tree.getroot()

    # Validate the contents of the XML.
    if not validate(root):
        print("FAILURE: Sanity check detected errors. Stopping.")
        return 1

    print("SUCCESS! Sanity check returned no errors.")
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))