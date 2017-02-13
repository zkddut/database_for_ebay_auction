-- 9. A user may not bid on an item he or she is also selling.
-- In trigger2_add.sql, when inserting a bid, we will check if UserID is same as UserID in table Items for this bid Items
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger2;
CREATE trigger trigger2
Before INSERT on Bids
WHEN (new.UserID = (SELECT UserID FROM Items WHERE ItemID = new.ItemID))
begin
	SELECT raise(rollback, 'User cannot bid on the item she is also selling');
end;	
