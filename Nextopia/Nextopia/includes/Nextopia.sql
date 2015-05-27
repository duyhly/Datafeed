
SELECT
p.ProductCode AS sku
, p.Photos_Cloned_From As Photos_Cloned_From
, ROUND(IsNull(pe.SalePrice,pe.ProductPrice),2) AS price
, p.ProductName AS name
, pd.ProductDescription AS description 
, 'Config_FullStoreURLv/vspfiles/photos/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '-1.jpg' AS thumbnail_image_URL
, 'Config_FullStoreURLv/vspfiles/photos/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '-2.jpg' AS Large_Image_URL
, 'Config_FullStoreURLProductDetails.asp?ProductCode=' + p.ProductCode AS detail_page_URL
, ROUND(pe.ListPrice,2) AS retail_price
, pd.ProductDescriptionShort AS Short_Product_Description

FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID

WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y')
AND (pe.ProductPrice > 0)
AND (pe.Yahoo_Medium = '444')

ORDER BY p.ProductCode 