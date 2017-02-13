-- The Current Price of an item must always match the Amount of the most recent bid for that item.
-- In triggerN_add.sql, when inserting a bid, trigger will update table Items attribute Currently as the amount in new Bids tuple
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger1;
CREATE trigger trigger1
AFTER INSERT on Bids
for each row
begin
	UPDATE Items SET Currently = new.Amount WHERE ItemID = new.ItemID;
end;

