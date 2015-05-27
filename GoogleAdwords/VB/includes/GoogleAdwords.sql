SELECT
p.ProductCode AS sku
, p.ProductName AS name
, ROUND(IsNull(pe.SalePrice,pe.ProductPrice),2) AS price
, ROUND(pe.ListPrice,2) AS retail_price
, ROUND((ROUND(pe.ListPrice,2) - ROUND(IsNull(pe.SalePrice,pe.ProductPrice),2)),2) AS money_saving
, pd.ProductDescription AS description 

FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID

WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y')
AND (pe.ProductPrice > 0)
AND CHARINDEX('-',p.ProductCode) <> 0

ORDER BY p.ProductCode