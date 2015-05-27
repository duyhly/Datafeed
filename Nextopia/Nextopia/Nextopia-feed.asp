<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/cache.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/Nextopia.inc.asp" -->

<%


Dim Collector 'As ProductsCollector

Dim HTML 'As String

Dim OrderObj 'As String

Dim Extensions

Dim thefso, f 
Dim fs
Dim Tab
Dim ProductItem
Dim test
Dim tmpArray
Dim a
Dim b
Dim c
Dim Pa, Pb




'Add type headers
Response.ContentType = "text/html"
Response.Charset="windows-1252"


Sub NoResults
	Response.Write("No order was found with the information you provided. Please go back and try again.")
	Response.End()
End Sub
    
	
	Function stripTags(HTMLstring)
    Dim RegularExpressionObject
	Dim j
    Set RegularExpressionObject = New RegExp
    With RegularExpressionObject
   .Pattern = "<[^>]+>"
   .IgnoreCase = True
   .Global = True
   End With
  HTMLstring = Replace(HTMLstring, CHR(13), " ")
  HTMLstring = Replace(HTMLstring, CHR(10), " ")
  stripTags = RegularExpressionObject.Replace(HTMLstring, " ")
  stripTags= Replace(stripTags, "&nbsp;", "") 
  
  For j = 1 To Len(stripTags)
  stripTags=Replace(stripTags,"  "," ")   
  Next
  

 Set RegularExpressionObject = nothing
 End Function 
 
 

'Missing the cache, lets create it
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
 
Set OrderObj = Collector.RetrievePt()
 

'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file


  If OrderObj is Nothing Then
Response.Write("Nothing there")
'Response.Write(test)
Else
Tab = chr(9)
End If
'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file
 
Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	
	f.Writeline ("sku" & Tab & "price" & Tab & "name" & Tab & "description" & Tab & "thumbnail_image_url" & Tab & "Large_Image_URL" & Tab & "detail_page_url" & Tab & "retail_price" & Tab & "short_product_description")
    
	
    
	For Each ProductItem In OrderObj.Products 
	
	 'ProductItem.description=stripTags(ProductItem.description) 
	 ProductItem.detail_page_URL= Replace(ProductItem.detail_page_URL, "Config_FullStoreURL", Config_FullStoreURL) 
	 
	'check image existance
	 If ProductItem.Photos_Cloned_From <> "" Then 
	 a= ProductItem.Photos_Cloned_From & "-1.jpg" 
	 b= ProductItem.Photos_Cloned_From & "-2.jpg"
	 Else a= ProductItem.sku & "-1.jpg"
	 b= ProductItem.sku & "-2.jpg"
	 End If
	 
	 Pa= Server.MapPath(a)
	 Pb= Server.MapPath(b)
     Pa= left(Pa,instr(Pa,"root")+3)
	 a= Pa & Config_ProductPhotosFolder & a 
	 Pb= left(Pb,instr(Pb,"root")+3)
	 b= Pb & Config_ProductPhotosFolder & b
	 
    
	set fs=Server.CreateObject("Scripting.FileSystemObject")
     'thumbnail_image_url exists
	 if fs.FileExists(a) then
     'response.write("File  exists!")
	 ProductItem.thumbnail_image_url= Replace(ProductItem.thumbnail_image_url, "Config_FullStoreURL", Config_FullStoreURL)
	 else
     'response.write("File  does not exist!")
	 ProductItem.thumbnail_image_url=""
     end if
	 if fs.FileExists(b) then
     'response.write("File  exists!")
	 ProductItem.Large_Image_URL= Replace(ProductItem.Large_Image_URL, "Config_FullStoreURL", Config_FullStoreURL)
	 else
     'response.write("File  does not exist!")
	 ProductItem.Large_Image_URL=""
     end if
	 set fs=nothing
	 
	 
     f.Writeline (ProductItem.sku & Tab & ProductItem.price & Tab & ProductItem.name & Tab & ProductItem.description & Tab & ProductItem.thumbnail_image_URL & Tab & ProductItem.Large_Image_URL & Tab & ProductItem.detail_page_URL & Tab & ProductItem.retail_price & Tab & ProductItem.short_product_description)
	
	
    Next   
	
    f.Writeline("[END OF FILE]")
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing
	

%>


