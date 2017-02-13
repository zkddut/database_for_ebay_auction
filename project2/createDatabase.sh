/usr/class/cs145/bin/sqlite3 Items.db < create.sql
echo "create.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < load.txt
echo "load.txt finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger1_add.sql
echo "trigger1_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger2_add.sql
echo "trigger2_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger3_add.sql
echo "trigger3_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger4_add.sql
echo "trigger4_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger5_add.sql
echo "trigger5_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger6_add.sql
echo "trigger6_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger7_add.sql
echo "trigger7_add.sql finish";
/usr/class/cs145/bin/sqlite3 Items.db < trigger8_add.sql
echo "trigger8_add.sql finish";
#/usr/class/cs145/bin/sqlite3 Items.db < constraints_test.sql
/usr/class/cs145/bin/sqlite3 Items.db < constraints_verify.sql
echo "constraint_verify.sql finish";


