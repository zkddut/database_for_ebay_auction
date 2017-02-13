--16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
--In triggerN_add.sql, when update the CurrentTime in Table CurrentTime, we will check it is latter than the old one.	
PRAGMA foreign_keys = ON;
DROP trigger if EXISTS trigger8;
CREATE trigger trigger8
Before UPDATE on CurrentTime
WHEN (new.CurrentTime <= (SELECT CurrentTime FROM CurrentTime))
begin
	SELECT raise(rollback, '16. The current time of your AuctionBase system can only advance forward in time, not backward in time.');
end;	
--Assume We can only UPDATE the ONLY entry in CurrentTime
