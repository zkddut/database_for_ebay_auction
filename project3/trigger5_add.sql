--13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular item.
--In triggerN_add.sql, when inserting a bid, trigger will update table Items tuple attribute Number_of_Bids+1 with matched ItemID
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger5;
CREATE trigger trigger5
After INSERT on Bids
for each row
begin
	UPDATE Items SET Number_of_Bids = Number_of_Bids + 1 WHERE ItemID = new.ItemID;
end;	
