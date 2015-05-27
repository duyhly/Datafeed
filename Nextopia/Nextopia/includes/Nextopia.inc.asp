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
	Public Photos_Cloned_From
	Public price
	public name
    Public description
	Public thumbnail_image_URL
	Public Large_Image_URL
	Public detail_page_URL
    Public retail_price
	Public Short_Product_Description


	Private Sub Class_Initialize()
	sku= Null
	Photos_Cloned_From= Null
	price = Null
	name = Null
	description = Null 
	thumbnail_image_URL = Null
	Large_Image_URL = Null
	detail_page_URL = Null
	retail_price = Null  
	Short_Product_Description = Null
	
    
  
 
	End Sub
	
	Private Sub Class_Terminate()
		
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "sku", sku
			.Add "Photos_Cloned_From", Photos_Cloned_From
			.Add "price", price
			.Add "name", name
			.Add "description", description
			.Add "thumbnail_image_URL" ,thumbnail_image_URL
			.Add "Large_Image_URL", Large_Image_URL
			.Add "detail_page_URL", detail_page_URL
			.Add "retail_price", retail_price
			.Add "Short_Product_Description", Short_Product_Description
			
			 
			
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
			Exit Function
		End If

		'Get the node list
		Set Document = VolusionAPICallObject.ResponseXML
		Set ProductNode = Document.documentElement.selectNodes("Products")
		'Set Document = Nothing		
		
		
		 
		If ProductNode.length < 1 Then
			Set ProductNode = Nothing 	
			Response.Write("going Exit soon<br>")
			Exit Function
		 
		End If
		    Response.Write("total records: " & ProductNode.length)
		Set ProductList = new ProductList
		For Each PrNode In ProductNode
			Set tmpProduct = New Product
			tmpProduct.sku = Field(PrNode, "sku")
			tmpProduct.Photos_Cloned_From = Field(PrNode, "Photos_Cloned_From")
			tmpProduct.price = Field(PrNode, "price")
			tmpProduct.price = Round(tmpProduct.price,2)
			tmpProduct.name = Field(PrNode, "name") 
			tmpProduct.description = Field(PrNode, "description")
			
			tmpProduct.thumbnail_image_URL = Field(PrNode, "thumbnail_image_URL")
			tmpProduct.Large_Image_URL = Field(PrNode, "Large_Image_URL")
			tmpProduct.detail_page_URL = Field(PrNode, "detail_page_URL")
			tmpProduct.retail_price = Field(PrNode, "retail_price")
			If tmpProduct.retail_price Then
			tmpProduct.retail_price = Round(tmpProduct.retail_price,2)
			End If
			tmpProduct.Short_Product_Description = Field(PrNode, "Short_Product_Description")
			
	        
			
			ProductList.addProduct(tmpProduct)
			
			Set tmpProduct = Nothing
		Next
		
		Set ProductNode = Nothing
		Set RetrievePt = ProductList

		Set ProductNode = Nothing
		Set PrNode = Nothing
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