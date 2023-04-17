WITH IMPOSSIBLE_CAR
    AS (
        SELECT DISTINCT CAR_ID
            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
            WHERE NOT (END_DATE < "2022-11-01" OR "2022-11-30" < START_DATE)
    )
    
SELECT C.CAR_ID,
    C.CAR_TYPE,
    TRUNCATE(C.DAILY_FEE*30*(100-D.DISCOUNT_RATE)*0.01, 0) FEE
    FROM CAR_RENTAL_COMPANY_CAR C
        LEFT JOIN IMPOSSIBLE_CAR IP ON (C.CAR_ID = IP.CAR_ID)
        INNER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN D ON (C.CAR_TYPE = D.CAR_TYPE)
    WHERE IP.CAR_ID IS NULL
        AND C.CAR_TYPE IN ("세단", "SUV")
        AND (D.DURATION_TYPE LIKE "30%")
        AND (500000 <= C.DAILY_FEE*30*(100-D.DISCOUNT_RATE)*0.01)
        AND (C.DAILY_FEE*30*(100-D.DISCOUNT_RATE)*0.01 < 2000000)
    ORDER BY FEE DESC, CAR_TYPE, CAR_ID DESC
