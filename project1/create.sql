drop table if exists Items;
create table Items 
	(ItemID PRIMARY KEY, Name, Currently, BuyPrice, First_Bid, Number_of_Bids, Location, Country, Started, Ends, Seller_UserID, Description);
drop table if exists Category_belong;
create table Category_belong 
	(ItemID, Category, CONSTRAINT pk_category PRIMARY KEY (ItemID, Category));
drop table if exists Bids;
create table Bids 
	(Time, ItemID, Amount, Bidder_UserID, Location, Country, CONSTRAINT pk_bids PRIMARY KEY (Time, Bidder_UserID));
drop table if exists Users;
create table Users 
	(UserID PRIMARY KEY, Rating);
drop table if exists Category;
create table Category 
	(Category PRIMARY KEY);


