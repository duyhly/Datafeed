<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2011 Brand Labs LLC
'* 
''*--------------------------------------------------------------------------*

%>
<%
Class ProductList
	Public Products 'As Product()

	Private PrCount
	Private Sub Class_Initialize()
		Products = Array()
		PrCount = 0
	End Sub
	
	Private Sub Class_Terminate()
		Set Products = Nothing
	End Sub
	
	Public Sub addProduct(Product)
		Redim Preserve Products(PrCount)
		Set Products(PrCount) = Product
		PrCount = PrCount + 1
	End Sub
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "Products", Products
		End With
	End Function	
End Class

	
Class Product
	Public sku
	Public brand
	public name
	
	Public price
	Public retail_price
	Public money_saving
	
	Public product_URL
    Public description
	Public model_list


	Private Sub Class_Initialize()
	sku= Null
	brand= Null
	name = Null
	
	price = Null
	retail_price = Null 
	money_saving = Null
	
	product_URL = Null
	description = Null 
	model_list = Null
    
  
 
	End Sub
	
	Private Sub Class_Terminate()
		
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "sku", sku
			.Add "brand", brand
			.Add "name", name
			
			.Add "price", price
			.Add "retail_price", retail_price
			.Add "money_saving", money_saving
			
			.Add "product_URL", product_URL
			.Add "description", description
			.Add "model_list", model_list
				
		End With
	End Function	
    End Class


Class OrderTrackingCollector

	Private mVBExt 'As VBScriptExtensions
	
	Private mVolusionAPICallObject 'As VolusionAPICall
	Private mFSO 'As Scripting.FileSystemObject
	
	Private mInstallPath 'As String
	
	Private Sub Class_Initialize()
		Set mVBExt = New VBScriptExtensions
		Set mVolusionAPICallObject = Nothing
		Set mFSO = Nothing
	End Sub
	
	Private Sub Class_Terminate()
		Set mFSO = Nothing
		Set mVolusionAPICallObject = Nothing
		Set mVBExt = Nothing
	End Sub
	
	Private Property Get VolusionAPICallObject() 'As VolusionAPICall
		If mVolusionAPICallObject Is Nothing Then
			Set mVolusionAPICallObject = New VolusionAPICall
		End If
		Set VolusionAPICallObject = mVolusionAPICallObject
	End Property
	
	Private Property Get FSO() 'As Scripting.FileSystemObject
		If mFSO Is Nothing Then
			Set mFSO = Server.CreateObject("Scripting.FileSystemObject")
		End If
		Set FSO = mFSO
	End Property
	
	Public Property Let InstallPath(ByVal vInstallPath)
		mInstallPath = vInstallPath
	End Property
	
	Public Property Let DestinationPath(ByVal vDestinationPath)
		VolusionAPICallObject.DestinationPath = vDestinationPath
	End Property
		
	Public Property Let DomainName(ByVal vDomainName)
		VolusionAPICallObject.DomainName = vDomainName
	End Property
	
	Public Property Let UserName(ByVal vUserName)
		VolusionAPICallObject.UserName = vUserName
	End Property
	
	Public Property Let Password(ByVal vPassword)
		VolusionAPICallObject.Password = vPassword
	End Property
	
	Public Property Let UseSSL(ByVal vUseSSL)
		VolusionAPICallObject.UseSSL = vUseSSL
	End Property
	
   

	Public Function RetrievePt() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim Node
		Dim newIndex
		Dim SQLFile
		Dim ProductList
		Dim ProductNode


		set fs=Server.CreateObject("Scripting.FileSystemObject")

		'Set default return value
		Set RetrievePt = Nothing
		
		Set ProductList = Server.CreateObject("Scripting.Dictionary")
		
		'Setup SQL using template
		SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_SQL_FILE) _
		)
		
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		)

		'Parse results
		If Not VolusionAPICallObject.ResponseIsValid Then
			Response.Write("Response Invalid!")
			Exit Function
		End If
		
		'Get the node list
		Set Document = VolusionAPICallObject.ResponseXML
		
		Set ProductNode = Document.documentElement.selectNodes("Products")	
		 
		If ProductNode.length < 1 Then
			Set ProductNode = Nothing 	
			Response.Write("Response is empty<br>")
			Exit Function
		 
		End If
		    Response.Write("Total Record: " & ProductNode.length)
			
			Set ProductList = new ProductList
			
			For Each PrNode In ProductNode
				Set tmpProduct = New Product
		
				tmpProduct.sku = Field(PrNode, "sku")			
				tmpProduct.brand = GetBrandFromSKU(tmpProduct.sku)
				tmpProduct.name = Field(PrNode, "name") 
				
				tmpProduct.price = Field(PrNode, "price")
				tmpProduct.price = Round(tmpProduct.price, 2)
				tmpProduct.retail_price = Field(PrNode, "retail_price")
				If tmpProduct.retail_price Then
					tmpProduct.retail_price = Round(tmpProduct.retail_price, 2)
				End If
				tmpProduct.money_saving = Field(PrNode, "money_saving")
				If tmpProduct.money_saving Then
					tmpProduct.money_saving = Round(tmpProduct.money_saving, 2)
				End If
				
				tmpProduct.product_URL = GetProductURLFromSKU(tmpProduct.sku)
				tmpProduct.description = Field(PrNode, "description")
		
				tmpProduct.model_list = GetModelListFromDescription(tmpProduct.description)

				ProductList.addProduct(tmpProduct)
				
				Set tmpProduct = Nothing
			Next
		
		Set ProductNode = Nothing
		Set RetrievePt = ProductList

		Set ProductNode = Nothing
		Set PrNode = Nothing
	End Function
	
	Private Function GetBrandFromSKU(ByVal sku)
		Dim brand
		GetBrandFromSKU = Null
		Dim item
		
		Dim subStringArray
		subStringArray = Split(sku, "-")
		
		brand = ""
		If UBound(subStringArray) > 2 Then
			brand = subStringArray(1)
			' Handle two exceptions: Kyocera-Mita and Konica-Minolta brand
			If StrComp(brand, "Kyocera", 1) = 0 or StrComp(brand, "Konica", 1) = 0 then
				brand = brand + "-" + subStringArray(2)
			End If
			
		End If
		
		GetBrandFromSKU = brand
		Set brand = Nothing
		
	End Function
	
	Private Function GetProductURLFromSKU(ByVal sku)
		GetProductURLFromSKU = Config_ProductBaseURL + Trim(sku)
	End Function
	
	Private Function GetModelListFromDescription(ByVal description)
		Dim re
		Dim oMatch
		Dim listModel
		Dim strModel
		
		GetModelListFromDescription = Null
		
		Set re = new RegExp 'new regular expressions object
		re.IgnoreCase = true 'ignore case when matching
		re.Global = true 'do not stop after first match
		
		re.Pattern = "<a[^>]+>(.*?)</a>" 'search all <a/> tags pattern
		
		listModel = ""
		
		If Len(description) > 0 Then
			description = Replace(description, vbLf, "")
			
			For Each oMatch in re.Execute(description) 
				strModel = Trim(oMatch.SubMatches(0))
				If Len(listModel) = 0 Then
					listModel =	strModel
				Else
					listModel = listModel + "," + strModel
				End If
				strModel = ""
			Next
		End If

		
		
		GetModelListFromDescription = listModel
		Set strModel = Nothing
		Set listModel = Nothing
		Set re = Nothing
		Set oMatch = Nothing
		
	End Function
	
	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		Field = Null
		
		If Document Is Nothing Then
			Exit Function
		End If
		
		'Retrieve node
		Set Node = Document.selectSingleNode(Pattern)
		If Node Is Nothing Then
			Exit Function
		End If
		'Return value
		Field = Node.text
		Set Node = Nothing
	End Function




End Class


%>