rm Items.dat
rm Category_belong.dat
rm Bids.dat
rm Users.dat
rm Category.dat

python my_parser.py ./ebay_data/items-*.json 

sort -u -o Items.dat Items.dat
sort -u -o Category_belong.dat Category_belong.dat
sort -u -o Bids.dat Bids.dat
sort -u -o Users.dat Users.dat
sort -u -o Category.dat Category.dat

sed -i.bak 's/"/""/g' Category_belong.dat
sed -i.bak 's/|/"|"/g' Category_belong.dat
sed -i.bak 's/^/"/g' Category_belong.dat 
sed -i.bak 's/$/"/g' Category_belong.dat

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

sqlite3 Items.db < create.sql
sqlite3 Items.db < load.txt

