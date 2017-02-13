PRAGMA foreign_keys = ON;
select * from Items WHERE ItemID = 1048289208 AND Started <= '2001-12-20 00:00:01' AND Ends >= '2001-12-20 00:00:01' And Buy_Price > Currently;
select * from Items WHERE ItemID = 1048289208 AND (Ends < '2001-12-20 00:00:01' OR Buy_Price <= Currently);

--SELECT * FROM Category LIMIT 5;
--SELECT * FROM Items WHERE ItemID = 1046807992;
--select  Buy_Price, Currently from Items WHERE ItemID = 1046807992 AND Started <= '2001-12-20 00:00:01' AND Ends >= '2001-12-20 00:00:01';
--SELECT * FROM Bids WHERE ItemID = 1672119838;
--INSERT INTO Bids (ItemID, Amount, UserID, Time) VALUES (1672119838, '30', 'tommyway.com', '2014-01-01 12:00:00');
