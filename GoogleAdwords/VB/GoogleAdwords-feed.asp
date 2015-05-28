<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/cache.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/GoogleAdwords.inc.asp" -->

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
Dim DQuote


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

If OrderObj is Nothing Then
	Response.Write("Nothing there")
Else
	Tab = chr(44)
	DQuote = chr(34)
End If


Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	
f.Writeline ("SKU" & Tab & "Brand" &  Tab & "Product Name" & Tab & "Our Price" & Tab & "Retail/OEM Price" & Tab & "Money Saving" & Tab & "ProductURL" & Tab & "Compatible Printer Models List")
    
For Each ProductItem In OrderObj.Products 
	f.Writeline (_ 
		DQuote & ProductItem.sku & DQuote & Tab & _
		DQuote & ProductItem.brand & DQuote & Tab & _
		DQuote & ProductItem.name & DQuote & Tab & _
		DQuote & ProductItem.price & DQuote & Tab & _ 
		DQuote & ProductItem.retail_price & DQuote & Tab & _ 
		DQuote & ProductItem.money_saving & DQuote & Tab & _ 
		DQuote & ProductItem.product_URL & DQuote & Tab & _
		DQuote & ProductItem.model_list & DQuote _
	) 
Next   
	
'f.Writeline("[END OF FILE]")

' Show some output
Response.Write(CONFIGURATION_DOMAIN_NAME + CONFIGURATION_NEW_DATAFEED_PATH)
f.close 

set f = nothing 
set thefso = nothing 

'Reset some objects
Set Collector = Nothing
	

%>


