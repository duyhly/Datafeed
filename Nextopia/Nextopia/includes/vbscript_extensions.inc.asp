<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2009-2011 Brand Labs LLC
'* 
'* Version 1.0.5
'* 
'*--------------------------------------------------------------------------*

Class VBScriptExtensions
	'*
	'* StripHTML from http://4guysfromrolla.com/webtech/042501-1.shtml
	'*
	Public Function StripHTML(vstrHTML)
		vstrHTML = CStrToZeroLengthIfUnusable(vstrHTML)
	
		'Strips the HTML tags from vstrHTML
		
		Dim objRegExp, strOutput
		Set objRegExp = New Regexp
		
		objRegExp.IgnoreCase = True
		objRegExp.Global = True
		objRegExp.Pattern = "<(.|\n)+?>"
		
		'Replace all HTML tag matches with the empty string
		strOutput = objRegExp.Replace(vstrHTML, "")
		  
		'Replace all < and > with &lt; and &gt;
		strOutput = Replace(strOutput, "<", "&lt;")
		strOutput = Replace(strOutput, ">", "&gt;")
		
		StripHTML = strOutput    'Return the value of strOutput
		
		Set objRegExp = Nothing
	End Function
	
	Public Function GetSanitizedHtmlString(vstrSource)
		Dim strReturnVal 'As String
		
		If Not IsUsableString(vstrSource) Then
			GetSanitizedHtmlString = ""
			Exit Function
		End If
		
		strReturnVal = vstrSource
		
		strReturnVal = OptimizedReplaceAll(strReturnVal, "&", "&#38;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "<", "&#60;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "=", "&#61;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, ">", "&#62;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "/", "&#47;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "\", "&#92;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "(", "&#40;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, ")", "&#41;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, "'", "&#39;")
		strReturnVal = OptimizedReplaceAll(strReturnVal, """", "&#34;")
		
		GetSanitizedHtmlString = strReturnVal
		
		Exit Function
	End Function
	
	Public Function OptimizedReplaceAll(vstrSource, vstrSearchString, vstrReplacementString) 'As String
		Dim strReturnVal 'As String
		
		strReturnVal = vstrSource
		OptimizedReplaceAll = strReturnVal
		
		If Not IsUsableString(vstrSource) Then
			Exit Function
		End If
		vstrSearchString = CStrToZeroLengthIfUnusable(vstrSearchString)
		vstrReplacementString = CStrToZeroLengthIfUnusable(vstrReplacementString)
		
		If 0 < Len(vstrSource) Then
			If 0 < InStr(1, vstrSource, vstrSearchString, 1) Then 'Case insensitive search
				strReturnVal = Replace(vstrSource, vstrSearchString, vstrReplacementString)
			End If
		End If
		
		OptimizedReplaceAll = strReturnVal
		
		Exit Function
	End Function
	
	Public Function GetSqlEscapedString(vstrSource) 'As String
		Dim strReturnVal 'As String
		
		strReturnVal = vstrSource
		
		strReturnVal = OptimizedReplaceAll(strReturnVal, "'", "''")
		
		GetSqlEscapedString = strReturnVal
		Exit Function
	End Function
	
	Public Function IsUsableString(vstrSource) 'As Boolean
		Dim blnReturnVal 'As Boolean
		
		blnReturnVal = False
		If Not IsEmpty(vstrSource) Then
			If Not IsNull(vstrSource) Then
				If 0 < Len(vstrSource) Then
					blnReturnVal = True
				End If
			End If
		End If
		
		IsUsableString = blnReturnVal
		Exit Function
	End Function
	
	Public Function CStrToZeroLengthIfUnusable(vstrSource) 'As String
		If IsUsableString(vstrSource) Then
			CStrToZeroLengthIfUnusable = vstrSource
		Else
			CStrToZeroLengthIfUnusable = ""
		End If
		Exit Function
	End Function
	
	Public Function StrBeginsWith(vstrString, vstrCompareTo, vintCompareMethod) 'As Boolean
		Dim blnReturnVal 'As Boolean
		
		If 1 = InStr(1, vstrString, vstrCompareTo, vintCompareMethod) Then
			blnReturnVal = True
		Else
			blnReturnVal = False
		End If
		
		StrBeginsWith = blnReturnVal
		Exit Function
	End Function
	
	Public Function StrEndsWith(vstrString, vstrCompareTo, vintCompareMethod) 'As Boolean
		Dim blnReturnVal 'As Boolean
		
		If (Len(vstrString) - Len(vstrCompareTo) + 1) = InStrRev(vstrString, vstrCompareTo, Len(vstrString), vintCompareMethod) Then
			blnReturnVal = True
		Else
			blnReturnVal = False
		End If
		
		StrEndsWith = blnReturnVal
		Exit Function
	End Function
	
	Function GetConsecutiveMatchesReplaced(vstrSource, vstrSearchString, vstrReplacementString)
		Dim strReturnVal 'As String
		Dim astrTemp 'As String()
		Dim i 'As Integer
		
		strReturnVal = ""
		If 0 < Len(vstrSource) Then
			astrTemp = Split(vstrSource, vstrSearchString)
			For i = LBound(astrTemp) To UBound(astrTemp)
				If 0 < Len(astrTemp(i)) Then
					If 0 < Len(strReturnVal) Then
						strReturnVal = strReturnVal & vstrReplacementString & astrTemp(i)
					Else
						strReturnVal = strReturnVal & astrTemp(i)
					End If
				End If
			Next
		End If
		
		GetConsecutiveMatchesReplaced = strReturnVal
		
		Exit Function
	End Function
	
	Public Function CDblOrNull(ByVal vNumber) 'As Double (or Null)
		If IsEmpty(vNumber) Then
			CDblOrNull = Null
			Exit Function
		ElseIf IsNull(vNumber) Then
			CDblOrNull = Null
			Exit Function
		ElseIf IsNumeric(vNumber) Then
			CDblOrNull = CDbl(vNumber)
			Exit Function
		Else
			CDblOrNull = Null
			Exit Function
		End If
	End Function
	
	Public Function CLngOrNull(ByVal vNumber) 'As Long (or Null)
		If IsEmpty(vNumber) Then
			CLngOrNull = Null
			Exit Function
		ElseIf IsNull(vNumber) Then
			CLngOrNull = Null
			Exit Function
		ElseIf IsNumeric(vNumber) Then
			CLngOrNull = CLng(vNumber)
			Exit Function
		Else
			CLngOrNull = Null
			Exit Function
		End If
	End Function
	
	Public Function CIntOrNull(ByVal vNumber) 'As Int (or Null)
		If IsEmpty(vNumber) Then
			CIntOrNull = Null
			Exit Function
		ElseIf IsNull(vNumber) Then
			CIntOrNull = Null
			Exit Function
		ElseIf IsNumeric(vNumber) Then
			CIntOrNull = CInt(vNumber)
			Exit Function
		Else
			CIntOrNull = Null
			Exit Function
		End If
	End Function
	
	Public Function GetXMLFieldText(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		GetXMLFieldText = Null
		
		If Document Is Nothing Then
			Exit Function
		End If
		
		'Retrieve node
		Set Node = Document.selectSingleNode(Pattern)
		If Node Is Nothing Then
			Exit Function
		End If
		'Return value
		GetXMLFieldText = Node.text
		Set Node = Nothing
	End Function
	
	Public Function GetXMLAttributeText(ByVal Node, ByVal AttributeName)
		Dim Attr 'As ?
		
		'Default return value
		GetXMLAttributeText = Null
		
		If Node Is Nothing Then
			Exit Function
		End If
		
		'Retrieve node
		Set Attr = Node.attributes.getNamedItem(AttributeName)
		If Attr Is Nothing Then
			Exit Function
		End If
		'Return value
		GetXMLAttributeText = Attr.text
		Set Attr = Nothing
	End Function
End Class
%>