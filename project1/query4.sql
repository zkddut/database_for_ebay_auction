SELECT ItemID
FROM Items
WHERE Currently = (SELECT MAX(i.Currently) FROM Items i)
;
