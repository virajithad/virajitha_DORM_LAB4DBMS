-- 3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.

SELECT count(C.CUS_GENDER), sum(O.ORD_AMOUNT), C.CUS_GENDER  FROM CUSTOMER AS C INNER JOIN `order` AS O ON C.CUS_ID=O.CUS_ID AND O.ORD_AMOUNT >= 3000 GROUP BY C.CUS_GENDER;

-- 4)  Display all the orders along with product name ordered by a customer having Customer_Id=2

SELECT * FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID) AS Supp_Pro 
INNER JOIN `order` AS O  ON O.PRICING_ID = Supp_Pro.PRICING_ID  AND O.CUS_ID=2;

-- 5)	Display the Supplier details who can supply more than one product

SELECT S.SUPP_NAME, count(S.SUPP_ID), S.SUPP_ID, SP.pro_id FROM supplier AS S INNER JOIN supplier_pricing AS SP ON S.SUPP_ID= SP.SUPP_ID GROUP BY S.SUPP_ID HAVING count(S.SUPP_ID) > 1;

-- 6)  Find the least expensive product from each category and print the table with category id, name, product name and price of the product

SELECT C.CAT_ID, sup_pro.minSP, sup_pro.PRO_ID, sup_pro.PRO_NAME, sup_pro.CAT_ID FROM (SELECT MIN(SP.SUPP_PRICE) AS minSP, P.PRO_ID,P.PRO_NAME, P.CAT_ID FROM supplier_pricing AS SP INNER JOIN product AS P ON SP.PRO_ID=P.PRO_ID GROUP BY P.CAT_ID) AS SUP_PRO INNER JOIN CATEGORY AS C ON C.CAT_ID = SUP_PRO.CAT_ID;

-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.

SELECT Supp_Pro.PRO_ID, Supp_Pro.PRO_NAME, O.ORD_DATE, O.ORD_ID FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID) AS Supp_Pro
INNER JOIN `order` AS O ON O.PRICING_ID = Supp_Pro.PRICING_ID AND O.ORD_DATE > '2021-10-05' ;

-- 8) Display customer name and gender whose names start or end with character 'A'.

SELECT C.CUS_NAME, C.CUS_GENDER from customer AS C WHERE C.CUS_NAME LIKE '%A' OR C.CUS_NAME LIKE 'A%';

-- 9) Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, 
-- If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
-- If rating >2 print “Average Service” else print “Poor Service”.

CALL Service_Rating();
