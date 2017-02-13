SELECT COUNT(UserID)
FROM (
	SELECT Items.Seller_UserID As UserID
	FROM Items
	WHERE Items.Location = 'New York'
	UNION
	SELECT Bids.Bidder_UserID As UserID
	FROM Bids
	WHERE Bids.Location = 'New York') as Bid_Sell_UserID;
