--When buy price reached, anuction will close 
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger9;
CREATE trigger trigger9
Before INSERT on Bids
WHEN (new.ItemID IN (SELECT ItemID FROM Items WHERE (ItemID == new.ItemID AND Currently >= Buy_Price)))
begin
	SELECT raise(rollback, 'When buy price reached, anuction will close');
end;	
--Assume We can only UPDATE the ONLY entry in CurrentTime
