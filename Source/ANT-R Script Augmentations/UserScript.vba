Dim LSLPluginHost As Object

Sub InitializePluginHost()
	Set LSLPluginHost = CreateObject("LSL4EPrime.LSLPluginHost")	
	LSLPluginHost.Initialize
End Sub

Sub DisposePluginHost()
	LSLPluginHost.Dispose
End Sub

Function GetCueTargetCondition(cueCondition As String, targetLocation As String, cueLocation As String) As Long
	If cueCondition = "no" Then
		If targetLocation = "left" Then
			GetCueTargetCondition = 0
			Exit Function
		Else
			GetCueTargetCondition = 4
			Exit Function
		End If
	End If

   	If cueCondition = "double" Then
		If targetLocation = "left" Then
			GetCueTargetCondition = 3
			Exit Function
		Else
			GetCueTargetCondition = 7
			Exit Function
		End If	
	End If

	If cueLocation = "left" Then
		If targetLocation = "left" Then
			GetCueTargetCondition = 1
			Exit Function
		Else
			GetCueTargetCondition = 6
			Exit Function
		End If
	End If

    If cueLocation = "right" Then
		If targetLocation = "left" Then
			GetCueTargetCondition = 2
			Exit Function
		Else
			GetCueTargetCondition = 5
			Exit Function
		End If
	End If

	GetCueTargetCondition = -1
End Function

Function GetCueTargetInterval(intervalBetweenCueAndTarget As String) As Long
	Select Case intervalBetweenCueAndTarget
		Case "0"
			GetCueTargetInterval = 0		
		Case "400"
			GetCueTargetInterval = 1
		Case "800"
			GetCueTargetInterval = 2
		Case Else
			GetCueTargetInterval = -1
	End Select
End Function

Function GetTargetFlankerCondition(targetImage As String) As Long
	Select Case targetImage
		Case "lllll"
			GetTargetFlankerCondition = 0		
		Case "rrrrr"
			GetTargetFlankerCondition = 1
		Case "rrlrr"
			GetTargetFlankerCondition = 2
		Case "llrll"
			GetTargetFlankerCondition = 3	
		Case Else
			GetTargetFlankerCondition = -1
	End Select
End Function

Function GetEventType(eventCode As Integer) As Long
	If eventCode <= 7 Then
		GetEventType = eventCode
		Exit Function
	End If

	GetEventType = -1
End Function

Sub PushEventMessage(context As Context, eventCode As Integer)
	Dim cueCondition As String
	Dim intervalBetweenCueAndTarget As String		
	Dim targetLocation As String	
	Dim cueLocation As String
	Dim targetImage As String	
	Dim eventType As Long
	Dim cueTargetInterval As Long
	Dim cueTargetCondition As Long
	Dim targetFlankerCondition As Long
	Dim message As Long
	
	Let eventType = GetEventType(eventCode)
	Let intervalBetweenCueAndTarget = context.GetAttrib("IntervalBetweenCueAndTarget")
	Let cueTargetInterval = GetCueTargetInterval(intervalBetweenCueAndTarget)
	
	If eventCode = 2 And cueTargetInterval = 0 Then
		Exit Sub
	End If
	
	Let cueCondition = context.GetAttrib("CueCondition")	
	Let targetLocation = context.GetAttrib("TargetLocation")
	Let cueLocation = context.GetAttrib("CueLocation")
	Let targetImage = context.GetAttrib("TargetImage")
		
	Let cueTargetCondition = GetCueTargetCondition(cueCondition, targetLocation, cueLocation)	
	Let targetFlankerCondition = GetTargetFlankerCondition(targetImage)
		
	Let message = eventType * 10000 + cueTargetCondition * 1000 + cueTargetInterval * 100 + targetFlankerCondition * 10
	
	LSLPluginHost.PushEventMessage message
End Sub