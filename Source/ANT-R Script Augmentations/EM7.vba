PushEventMessage c, 7
Dim durationOfFixation As Long
Dim correctedValue As String
Let durationOfFixation = CLng(c.GetAttrib("DurationOfFixation")) - 1200
Let correctedValue = CStr(durationOfFixation)

c.SetAttrib "DurationOfFixation", correctedValue