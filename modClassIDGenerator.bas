Attribute VB_Name = "modClassIDGenerator"
'===========================================================================
'
' Module Name:  modClassIDGenerator
' Author:       Slider
' Date:         29/05/01
' Version:      01.00.00
' Description:  For Debug Purposes Only (Generated by VB6 Class Builder)
' Edit History: 01.00.00 29/05/01 Initial Release
'
'===========================================================================

Option Explicit

Function GetNextClassDebugID() As Long
    'class ID generator
    Static lClassDebugID As Long
    lClassDebugID = lClassDebugID + 1
    GetNextClassDebugID = lClassDebugID
End Function

