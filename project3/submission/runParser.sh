rm Items.dat
rm Bids.dat
rm Users.dat
rm Category.dat
echo "rm finish"

python my_parser.py ./ebay_data/items-*.json 

echo "my_parser.py finish"

sort -u -o Items.dat Items.dat
sort -u -o Bids.dat Bids.dat
sort -u -o Users.dat Users.dat
sort -u -o Category.dat Category.dat

echo "Sort finish"

sed -i.bak 's/"/""/g' Bids.dat
sed -i.bak 's/|/"|"/g' Bids.dat
sed -i.bak 's/^/"/g' Bids.dat 
sed -i.bak 's/$/"/g' Bids.dat

sed -i.bak 's/"/""/g' Users.dat
sed -i.bak 's/|/"|"/g' Users.dat
sed -i.bak 's/^/"/g' Users.dat 
sed -i.bak 's/$/"/g' Users.dat

sed -i.bak 's/"/""/g' Category.dat
sed -i.bak 's/|/"|"/g' Category.dat
sed -i.bak 's/^/"/g' Category.dat 
sed -i.bak 's/$/"/g' Category.dat

sed -i.bak 's/"/""/g' Items.dat
sed -i.bak 's/|/"|"/g' Items.dat
sed -i.bak 's/^/"/g' Items.dat 
sed -i.bak 's/$/"/g' Items.dat

echo "Sed finish"

sqlite3 Items.db < create.sql
echo "create.sql finish"

sqlite3 Items.db < load.txt 
echo "load.sql finish"


