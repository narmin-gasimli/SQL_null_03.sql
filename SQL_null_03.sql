WITH a AS (
    SELECT 1 Id, 50 number UNION ALL
    SELECT 2 Id, 65 number UNION ALL
    SELECT 3 Id, 80 number UNION ALL
    SELECT 4 Id, NULL number UNION ALL
    SELECT 5 Id, 110 number UNION ALL
    SELECT 6 Id, 123 number UNION ALL
    SELECT 7 Id, NULL number UNION ALL
    SELECT 8 Id, NULL number UNION ALL
    SELECT 9 Id, 155 number UNION ALL
    SELECT 10 Id, 170 number UNION ALL
    SELECT 11 Id, 176 number UNION ALL
    SELECT 12 Id, 185 number
),
b AS (
	SELECT Id, number,
		   CASE WHEN number IS NULL THEN 1 ELSE 0 END AS s�tun1,
		   CASE WHEN number IS NULL THEN 0 ELSE 1 END AS s�tun2,
		   SUM(CASE WHEN number IS NULL THEN 0 ELSE 1 END) OVER (ORDER BY Id) AS s�tun3
	FROM a
),
c AS (
	SELECT Id, number, s�tun1, s�tun2, s�tun3,
		COUNT(*) OVER(PARTITION BY s�tun3) AS s�tun4,
		(  ROW_NUMBER() OVER(PARTITION BY s�tun3 ORDER BY Id)-1  ) AS s�tun6, 
		LEAD(s�tun3) over(order by Id desc) sutun10
	FROM b
)
-------Umumi cagir hamisini-------------
select  *,
		s�tun1 * s�tun4 AS s�tun5,
		s�tun6,
		ISNULL(MAX(c.number) OVER(PARTITION BY s�tun3), 0)*s�tun1   AS s�tun7,
		ISNULL(MAX(c.number) OVER(PARTITION BY sutun10), 0)*s�tun1   AS s�tun9
FROM c

