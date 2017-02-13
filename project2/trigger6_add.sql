--14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
--In trigger6_add.sql, when inserting a bid, we will check if Amount is higher than all other Amount with same ItemID	
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger6;
CREATE trigger trigger6
Before INSERT on Bids
WHEN (new.Amount <= (SELECT MAX(Amount) FROM Bids WHERE ItemID = new.ItemID))
begin
	SELECT raise(rollback, '14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.');
end;	
