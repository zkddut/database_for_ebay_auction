SELECT COUNT(*) FROM (
	SELECT ItemID
	FROM Category_belong
	GROUP BY ItemID
	HAVING COUNT(Category) = 4)
;
