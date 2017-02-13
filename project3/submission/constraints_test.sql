PRAGMA foreign_keys = ON;
--1. No two users can share the same User ID.
INSERT INTO Users values ("!peanut", "good", "Here", "China"); 
.print "Constraint Test 1";

--2. All sellers and bidders must already exist as users.
INSERT INTO Bids values ("2001-12-03 05:31:36", 1672119838, 5.88, "dawena_zkd2"); 
.print 'Constraint Test 2';

--3. No two items can share the same Item ID.
INSERT INTO Items values (1043374545,"zz", 30.0, NULL , 30.0, 0, "2001-12-03 18:10:40","2001-12-13 18:10:40","rulabula","brand new beau"); 
.print 'Constraint Test 3';

--4. Every bid must correspond to an actual item.
INSERT INTO Bids values ("2001-12-03 05:31:36", 167211988, 5.88, "dawena_zkd2"); 
.print 'Constraint Test 4';

--5. The items for a given category must all exist.
.print 'Constraint Test 5, Ignore Null insert case';

--6. An item cannot belong to a particular category more than once.
INSERT INTO Category values (1672119838, "Footwear");
.print 'Constraint Test 6';

--7. The end time for an auction must always be after its start time.
INSERT INTO Items values (1043374545999,"zz", 30.0, NULL , 30.0, 0, "2001-12-13 18:10:40","2001-12-03 18:10:40","rulabula","brand new beau"); 
.print 'Constraint Test 7';

--8. The Current Price of an item must always match the Amount of the most recent bid for that item.
SELECT Currently FROM Items WHERE ItemID = 1672119838;
INSERT INTO Bids values ("2001-12-04 05:31:36", 1672119838, 10, "dawena"); 
SELECT Currently FROM Items WHERE ItemID = 1672119838;
--SELECT ItemID, UserID, Currently, Ends, Started FROM Items WHERE ItemID = 1672119838;
.print 'Constraint Test 8';

--9. A user may not bid on an item he or she is also selling.
--SELECT * FROM Users WHERE UserID = "jjfarmer";
INSERT INTO Bids values ("2001-12-04 05:31:37", 1672119838, 12, "jjfarmer"); 
.print 'Constraint Test 9';

--10. No auction may have two bids at the exact same time.
INSERT INTO Bids values ("2001-12-07 12:23:02", 1672119838, 12, "dragonrider06"); 
.print 'Constraint Test 10';

--11. No auction may have a bid before its start time or after its end time.
INSERT INTO Bids values ("2012-12-07 12:23:02", 1672119838, 12, "dragonrider06"); 
.print 'Constraint Test 11';

--12. No user can make a bid of the same amount to the same item more than once.
--SELECT * FROM Bids WHERE ItemID = 1672119838;
INSERT INTO Bids values ("2001-12-04 05:31:39", 1672119838, 10, "dawena"); 
.print 'Constraint Test 12';

--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.
SELECT Number_of_Bids FROM Items WHERE ItemID = 1672119838;
INSERT INTO Bids values ("2001-12-08 05:31:39", 1672119838, 11, "dawena"); 
SELECT Number_of_Bids FROM Items WHERE ItemID = 1672119838;
.print 'Constraint Test 13';

--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
INSERT INTO Bids values ("2001-12-08 05:31:40", 1672119838, 9, "dawena"); 
.print 'Constraint Test 14';

--15. All new bids must be placed at the time which matches the current time of your AuctionBase system.
UPDATE CurrentTime SET CurrentTime = "2001-12-08 05:31:40";
INSERT INTO Bids values ("2001-12-08 05:31:41", 1672119838, 9, "dawena"); 
.print 'Constraint Test 15';

--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
UPDATE CurrentTime SET CurrentTime = "2012-12-08 05:31:39" WHERE CurrentTime != 0;
SELECT CurrentTIme FROM CurrentTime;
.print 'Constraint Test 16';


