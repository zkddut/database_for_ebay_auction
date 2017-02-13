--10. No auction may have two bids at the exact same time.
--	In trigger3_add.sql, when inserting a bid, we will check if Time of new bid same as any bid Time with same ItemID
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger3;
CREATE trigger trigger3
Before INSERT on Bids
for each row
WHEN (new.Time IN (SELECT b.Time FROM Bids AS b WHERE new.ItemID = b.ItemID))
begin
	SELECT raise(rollback, 'No auction may have two bids at the exact same time');
end;

