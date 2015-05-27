<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2008-2010 Brand Labs LLC
'*
'* Version 2.0.2
'* 
'*--------------------------------------------------------------------------*

Class Cache
	Private FSO 'As Scripting.FileSystemObject
	Private LocalPath 'As String
	Private LocalAge 'As Long

	Private Sub Class_Initialize()
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		LocalAge = 3600
		LocalPath = Null
	End Sub
	
	Private Sub Class_Terminate()
		Set FSO = Nothing
	End Sub
	
	'Path for cache
	Public Property Let Path(ByVal vPath)
		LocalPath = vPath
	End Property

	Public Property Get Path() 'As String
		Path = LocalPath
	End Property
	
	'Age in seconds of the cache
	Public Property Let Age(ByVal vAge)
		LocalAge = vAge
	End Property

	Public Property Get Age() 'As Long
		Age = LocalAge
	End Property
	
	Public Function GetCache(ByVal Key) 'As String
		GetCache = GetCache_(Key, True, False)
	End Function

	Public Function GetCacheB(ByVal Key, ByVal Send) 'As Variant
		GetCacheB = GetCache_(Key, False, Send)
	End Function
	
	Public Function IsCached(ByVal Key) 'As Boolean
		Dim PathToFile 'As String
		Dim File 'As Scripting.File
		Dim CacheDate 'As Date
	
		'Default return value if failure
		IsCached = False
		
		PathToFile = CreatePathToFile(Key)
		
		If IsNull(PathToFile) Or Not FSO.FileExists(PathToFile) Then
			Exit Function
		End If

		Set File = FSO.GetFile(PathToFile)
		CacheDate = File.DateLastModified
		Set File = Nothing
		
		If DateDiff("s", CacheDate, Now()) > LocalAge Then
			Exit Function
		End If
		
		'We got this far, so the item is cached
		IsCached = True
	End Function	
	
	Public Sub DeleteCache(ByVal Key)
		Dim PathToFile 'As String
	
		'Make sure this is even cached
		If Not IsCached(Key) Then
			Exit Sub
		End If
		'Get the path
		PathToFile = CreatePathToFile(Key)
		'If nothing exists, just exit
		If IsNull(PathToFile) Then
			Exit Sub
		End If
		
		'Delete the cache file
		Call FSO.DeleteFile(PathToFile, True)
	End Sub
	
	Private Function GetCache_(ByVal Key, ByVal IsText, ByVal SendImmediately) 'As Variant
		Dim PathToFile 'As String
		Dim Stream 'As ADODB.Stream
		Dim Data 'As Byte()
		
		'Default return value if failure
		GetCache_ = Null

		'See if cache is too old to return
		If GetCacheAge(Key) > LocalAge Then
			Exit Function
		End If
		
		'See if file exists
		PathToFile = CreatePathToFile(Key)
		If Not FSO.FileExists(PathToFile) Then
			Exit Function
		End If		
				
		'Read data from cache file
		Set Stream = Server.CreateObject("ADODB.Stream")
		Call Stream.Open()		
		Stream.Position = 0
		If IsText Then
			Stream.Type = 2 'adTypeText
		Else
			Stream.Type = 1 'adTypeBinary
		End If		
		Call Stream.LoadFromFile(PathToFile)
		
		'If data is text/string, use different method
		If IsText Then			
			If SendImmediately Then
				Response.Write(Stream.ReadText(-1)) 'adReadAll
				GetCache_ = True
			Else
				GetCache_ = Stream.ReadText(-1) 'adReadAll
			End If
		Else	
			Data = Stream.Read(-1) 'adReadAll
			If IsEmpty(Data) Or IsNull(Data) Or Not IsArray(Data) Then
				Data = Null
			End If
					
			If SendImmediately Then
				'Only output if not null
				If Not IsNull(Data) Then
					Response.BinaryWrite(Data)
				End If
				GetCache_ = True
			Else
				GetCache_ = Data  
			End If			
		End If
				
		Call Stream.Close()
		Set Stream = Nothing
	End Function
	
	Public Function GetCacheAge(ByVal Key) 'As Long
		Dim PathToFile 'As String
		Dim File 'As Scripting.File
		Dim CacheDate 'As Date
		
		'Default return value if failure
		GetCacheAge = 0
		
		'See if file exists
		PathToFile = CreatePathToFile(Key)
		If Not FSO.FileExists(PathToFile) Then
			Exit Function
		End If		
		
		Set File = FSO.GetFile(PathToFile)
		CacheDate = File.DateLastModified	
		Set File = Nothing
		
		GetCacheAge = CLng(DateDiff("s", CacheDate, Now()))
	End Function
	
	Public Function GetCacheTimeLeft(ByVal Key) 'As Long
		GetCacheTimeLeft = (LocalAge - GetCacheAge(Key))
		
		If GetCacheTimeLeft < 0 Then
			GetCacheTimeLeft = 0
		End If
	End Function
	
	Private Function CreatePathToFile(ByVal Key)
		Dim Folder 'As Scripting.Folder
		Dim PathToFile 'As String
		
		'Default return value if failure
		CreatePathToFile = Null
		
		'Make sure we have a path for storage
		If IsNull(LocalPath) Or IsEmpty(LocalPath) Or Trim(LocalPath) = "" Then
			Exit Function
		End If
		
		Set Folder = FSO.GetFolder(LocalPath)
		PathToFile = FSO.BuildPath(Folder.Path, Key)
		Set Folder = Nothing
		
		CreatePathToFile = PathToFile	
	End Function
	
	Public Function SaveCache(ByVal Key, ByRef Data)
		SaveCache = SaveCache_(Key, Data, True)
	End Function

	Public Function SaveCacheB(ByVal Key, ByRef Data)
		SaveCacheB = SaveCache_(Key, Data, False)
	End Function
		
	Private Function SaveCache_(ByVal Key, ByRef Data, ByVal IsText)
		Dim Folder 'As Scripting.Folder
		Dim PathToFile 'As String
		Dim Stream 'As As ADODB.Stream
		Dim TemporaryFilePath 'As String
		Dim Size 'As Long
		
		'Set default return value
		SaveCache_ = False
		
		'Make sure we have a path for storage
		If IsNull(LocalPath) Or IsEmpty(LocalPath) Or Trim(LocalPath) = "" Then			
			Exit Function
		End If
		
		Set Folder = FSO.GetFolder(LocalPath)
		PathToFile = CreatePathToFile(Key)
				
		'Create temporary file
		TemporaryFilePath = FSO.BuildPath(Folder.Path, FSO.GetTempName())
	
		'Reset folder object
		Set Folder = Nothing
	
		'Get size of data
		If IsEmpty(Data) Or IsNull(Data) Then
			Size = 0
		Else
			If IsArray(Data) Then
				Size = UBound(Data)-LBound(Data)
			Else
				Size = Len(CStr(Data))
			End If
		End If
	
		'Output to the temporary file
		Set Stream = Server.CreateObject("ADODB.Stream")
		Call Stream.Open()		
		Stream.Position = 0

		'Only output if something is available		
		If Size > 0 Then
			'If data is text/string, use different method		
			If IsText Then
				Stream.Type = 2 'adTypeText
				Call Stream.WriteText(Data)
			Else			
				Stream.Type = 1 'adTypeBinary
				Call Stream.Write(Data)
			End If
		End If
		
		Call Stream.SaveToFile(TemporaryFilePath, 2) 'adSaveCreateOverwrite
		Call Stream.Close()
		Set Stream = Nothing

		'Move the temporary file		
		Call FSO.CopyFile(TemporaryFilePath, PathToFile, True)		
		
		'Delete the temporary file
		Call FSO.DeleteFile(TemporaryFilePath, True)
		
		SaveCache_ = True
	End Function	
End Class
%>