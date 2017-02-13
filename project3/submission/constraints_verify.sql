--1. No two users can share the same User ID.
SELECT UserID
FROM Users
GROUP BY UserID
HAVING COUNT(*) > 1;
.print "Constraint Verify 1";

--2. All sellers and bidders must already exist as users.
SELECT s.UserID as Seller
FROM Items as s 
WHERE s.UserID NOT IN (
	SELECT u.UserID
	FROM Users as u); 
.print 'Constraint Verify 2';


SELECT b.UserID as Bidder
FROM Bids as b 
WHERE b.UserID NOT IN (
	SELECT u.UserID
	FROM Users as u); 

--3. No two items can share the same Item ID.
SELECT ItemID
FROM Items
GROUP BY ItemID
HAVING COUNT(*) > 1;
.print 'Constraint Verify 3';


--4. Every bid must correspond to an actual item.
SELECT ItemID
FROM Bids  
WHERE ItemID NOT IN (
	SELECT ItemID
	FROM Items); 
.print 'Constraint Verify 4';

--5. The items for a given category must all exist.
SELECT ItemID
FROM Items
WHERE ItemID NOT IN (
	SELECT ItemID
	FROM Category); 
.print 'Constraint Verify 5, Do not consider ItemID = null in table Category';

--6. An item cannot belong to a particular category more than once.
SELECT i.ItemID
FROM Items as i
WHERE i.ItemID IN (
	SELECT c.ItemID
	FROM Category as c
	WHERE i.ItemID = c.ItemID
	GROUP BY Category
	HAVING COUNT(*) >1);
.print 'Constraint Verify 6';

--7. The end time for an auction must always be after its start time.
SELECT Ends
FROM Items
WHERE Ends < Started; 
.print 'Constraint Verify 7';

--8. The Current Price of an item must always match the Amount of the most recent bid for that item.
SELECT i.Currently
FROM Items as i
WHERE i.Currently != (
	SELECT b.Amount
	FROM Bids as b
	WHERE b.ItemID = i.ItemID
	GROUP BY ItemID
	HAVING MAX(Amount)); 
.print 'Constraint Verify 8';

--9. A user may not bid on an item he or she is also selling.
SELECT i.UserID
FROM Items as i
WHERE i.UserID IN (
	SELECT b.UserID
	FROM Bids as b
	WHERE b.ItemID = i.ItemID); 
.print 'Constraint Verify 9';

--10. No auction may have two bids at the exact same time.
SELECT TIME
FROM Bids
GROUP BY ItemID
HAVING COUNT(TIME) > COUNT(DISTINCT TIME);
.print 'Constraint Verify 10';

--11. No auction may have a bid before its start time or after its end time.
SELECT b.TIME
FROM Bids as b
GROUP BY b.ItemID
HAVING b.TIME < (
	SELECT i.Started
	FROM Items as i
	WHERE i.ItemID = b.ItemID)
	and
       b.TIME > (
	SELECT i.Ends
	FROM Items as i
	WHERE i.ItemID = b.ItemID);
.print 'Constraint Verify 11';

--12. No user can make a bid of the same amount to the same item more than once.
SELECT i.ItemID
FROM Items as i
WHERE i.ItemID IN (
	SELECT b.ItemID
	FROM Bids as b
	WHERE b.ItemID = i.ItemID 
	GROUP BY b.UserID
	HAVING COUNT(Amount) > COUNT(DISTINCT Amount));
.print 'Constraint Verify 12';

--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.
SELECT i.ItemID
FROM Items as i
WHERE Number_of_Bids != (
	SELECT COUNT(*)
	FROM Bids as b
	WHERE b.ItemID = i.ItemID);
.print 'Constraint Verify 13';

--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
SELECT i.ItemID
FROM Items as i
WHERE i.ItemID in(
	SELECT b.ItemID
	FROM Bids as b
	WHERE b.ItemID = i.ItemID
	GROUP BY b.ItemID
	HAVING b.Time = Max(b.Time) and b.Amount < Max(b.Amount));
.print 'Constraint Verify 14';

--15. All new bids must be placed at the time which matches the current time of your AuctionBase system.
SELECT Time
FROM Bids
WHERE Time > (
	SELECT CurrentTime
	FROM CurrentTime);
.print 'Constraint Verify 15';

--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
SELECT Time
FROM Bids
WHERE Time > (
	SELECT CurrentTime
	FROM CurrentTime);
.print 'Constraint Verify 16';


