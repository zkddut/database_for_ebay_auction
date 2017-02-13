--15. All new bids must be placed at the time which matches the current time of your AuctionBase system. 
--In trigger7_add.sql, when inserting a bid, we will check if Time is same as CurrentTime in Table CurrentTime	
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger7;
CREATE trigger trigger7
Before INSERT on Bids
WHEN (new.Time != (SELECT CurrentTime FROM CurrentTime))
begin
	SELECT raise(rollback, '15. All new bids must be placed at the time which matches the current time of your AuctionBase system. ');
end;	
