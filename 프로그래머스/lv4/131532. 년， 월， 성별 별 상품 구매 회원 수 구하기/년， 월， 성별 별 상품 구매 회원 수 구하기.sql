SELECT YEAR(SALES_DATE) YEAR, MONTH(SALES_DATE) MONTH, GENDER, COUNT(DISTINCT USER_ID) USERS
    FROM ONLINE_SALE JOIN USER_INFO USING (USER_ID)
    WHERE GENDER IS NOT NULL
    GROUP BY YEAR(SALES_DATE), MONTH(SALES_DATE), GENDER
    ORDER BY YEAR, MONTH, GENDER