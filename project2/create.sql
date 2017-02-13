drop table if exists Items;
create table Items 
	(ItemID, Name, Currently, Buy_Price, First_Bid, Number_of_Bids, Started, Ends, UserID, Description,
	 CONSTRAINT pk_item PRIMARY KEY (ItemID),
	 FOREIGN KEY(UserID) references Users(UserID),
	 CONSTRAINT chk_end_start CHECK (Ends > Started));

drop table if exists Category;
create table Category 
	(ItemID, Category, 
	 CONSTRAINT pk_category PRIMARY KEY (ItemID, Category),
	 FOREIGN KEY(ItemID) references Items(ItemID));

drop table if exists Bids;
create table Bids 
	(Time, ItemID, Amount, UserID, 
	 CONSTRAINT pk_bids PRIMARY KEY (ItemID, Amount, UserID),
	 FOREIGN KEY(UserID) references Users(UserID),
	 FOREIGN KEY(ItemID) references Items(ItemID));

drop table if exists Users;
create table Users 
	(UserID, Rating, Location, Country,
	 CONSTRAINT pk_users PRIMARY KEY (UserID));

DROP TABLE if exists CurrentTime; 
CREATE TABLE CurrentTime(CurrentTime);
INSERT into CurrentTime values ("2001-12-20 00:00:01"); 
SELECT * from CurrentTime;
