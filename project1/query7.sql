SELECT COUNT(DISTINCT Category)
FROM Category_belong
WHERE ItemID IN (
	SELECT ItemID
	FROM Bids
	WHERE Amount > 100)
;
