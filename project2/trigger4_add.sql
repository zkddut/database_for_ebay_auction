--11. No auction may have a bid before its start time or after its end time.
--In trigger4_add.sql, when inserting a bid, we will check if attribute Time is latter than End attribute or earlier than Started in table Items

PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger4;
CREATE trigger trigger4
Before INSERT on Bids
WHEN ((new.Time > (SELECT Ends FROM Items WHERE ItemID = new.ItemID)) or (new.Time < (SELECT Started FROM Items WHERE ItemID = new.ItemID)))
begin
	SELECT raise(rollback, '11. No auction may have a bid before its start time or after its end time.');
end;	
