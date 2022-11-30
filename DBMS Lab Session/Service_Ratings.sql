CREATE PROCEDURE `Service_Rating` ()
BEGIN
SELECT SOP.SUPP_ID, R.RAT_RATSTARS,
CASE
WHEN RAT_RATSTARS = 5  THEN 'Excellent Service'
WHEN RAT_RATSTARS >= 4 THEN 'Good Service'
WHEN RAT_RATSTARS > 2 THEN 'Average Service'
ELSE 'Poor Service'
END AS 'Type_of_Service'
 FROM (SELECT Supp_Pro.SUPP_ID, O.ORD_ID FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.SUPP_ID, supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID) AS Supp_Pro 
INNER JOIN `order` AS O ON O.PRICING_ID = Supp_Pro.PRICING_ID) AS SOP INNER JOIN rating AS R ON R.ORD_ID=SOP.ORD_ID ;
END
