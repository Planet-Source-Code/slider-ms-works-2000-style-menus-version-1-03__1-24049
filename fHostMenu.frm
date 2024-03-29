VERSION 5.00
Object = "{9029C219-2B47-43F4-8B5C-C9EE5C0D8E15}#3.0#0"; "prjMenu.ocx"
Begin VB.Form fHostMenu 
   Caption         =   "MS WORKS 2000 Style Menus v1.03"
   ClientHeight    =   4710
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6480
   Icon            =   "fHostMenu.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4710
   ScaleWidth      =   6480
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox picHilite 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      ForeColor       =   &H80000008&
      Height          =   690
      Left            =   2050
      ScaleHeight     =   660
      ScaleWidth      =   2610
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   2640
      Width           =   2640
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "T&ube Vertical"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   5
         Left            =   1155
         TabIndex        =   18
         Top             =   420
         Width           =   1275
      End
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "T&ube Horizontal"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   4
         Left            =   1155
         TabIndex        =   17
         Top             =   210
         Width           =   1420
      End
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "&Flat"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   0
         Left            =   105
         TabIndex        =   13
         Top             =   0
         Value           =   -1  'True
         Width           =   750
      End
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "&Bitmap"
         Enabled         =   0   'False
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   3
         Left            =   1155
         TabIndex        =   16
         Top             =   0
         Width           =   1170
      End
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "&Vertical"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   2
         Left            =   105
         TabIndex        =   15
         Top             =   420
         Width           =   1170
      End
      Begin VB.OptionButton OptDialog 
         Appearance      =   0  'Flat
         Caption         =   "&Horizontal"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   1
         Left            =   105
         TabIndex        =   14
         Top             =   210
         Width           =   1170
      End
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "&Graduated Hilite"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   6
      Left            =   1785
      TabIndex        =   10
      Top             =   2400
      Value           =   1  'Checked
      Width           =   1450
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "Show &ToolTips"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   5
      Left            =   1785
      TabIndex        =   8
      ToolTipText     =   "Multiline Tooltips supported!"
      Top             =   2160
      Value           =   1  'Checked
      Width           =   1410
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "&Mouse Hover"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   4
      Left            =   1785
      TabIndex        =   6
      Top             =   1920
      Value           =   1  'Checked
      Width           =   1305
   End
   Begin prjMenu.ucHMenu ucHMenu 
      Height          =   855
      Left            =   105
      TabIndex        =   0
      Top             =   105
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   1508
      SelectedHiliteColor2=   192
      HoverColor      =   8421631
      BeginProperty SelectTextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty TextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty DisabledTextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin prjMenu.ucVMenu ucVMenu 
      Height          =   2010
      Left            =   105
      TabIndex        =   1
      Top             =   1050
      Width           =   1590
      _ExtentX        =   2805
      _ExtentY        =   3545
      SelectedHiliteColor=   16761087
      SelectedHiliteColor2=   12583104
      HoverColor      =   16711935
      BeginProperty SelectTextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty TextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty DisabledTextFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "Show &Focus Rect."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   3
      Left            =   1800
      TabIndex        =   5
      Top             =   1680
      Value           =   1  'Checked
      Width           =   1935
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "S&how Seperators"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   1800
      TabIndex        =   4
      Top             =   1440
      Value           =   1  'Checked
      Width           =   1935
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "&Remember Selections"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   1800
      TabIndex        =   3
      Top             =   1200
      Value           =   1  'Checked
      Width           =   1935
   End
   Begin VB.Frame fraDialog 
      Caption         =   "Selected Menu Item"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1785
      TabIndex        =   20
      Top             =   3780
      Width           =   2535
      Begin VB.Label lblDialog 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.CheckBox chkDialog 
      Appearance      =   0  'Flat
      Caption         =   "&Show Disabled Items"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1800
      TabIndex        =   2
      Top             =   960
      Width           =   1935
   End
   Begin VB.Label lblHilite 
      AutoSize        =   -1  'True
      Caption         =   "v1.02"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   1
      Left            =   3255
      TabIndex        =   9
      Top             =   2160
      Width           =   465
   End
   Begin VB.Label lblHilite 
      AutoSize        =   -1  'True
      Caption         =   "v1.01"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   3255
      TabIndex        =   7
      Top             =   1920
      Width           =   465
   End
   Begin VB.Label lblHilite 
      AutoSize        =   -1  'True
      Caption         =   "NEW!"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   2
      Left            =   3255
      TabIndex        =   11
      Top             =   2400
      Width           =   405
   End
   Begin VB.Label lblNote 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Note: Cursor Keys also work! "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   1785
      TabIndex        =   19
      Top             =   3465
      Width           =   2535
   End
End
Attribute VB_Name = "fHostMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===========================================================================
'
' Form Name:    fHostMenu
' Author:       Slider
' Date:         29/05/2001
' Version:      01.00.02
' Description:  MS Works Vertical Style Menus Demonstation Application
' Edit History: 01.00.00 29/05/01 Initial Release
'               01.00.01 30/05/01 Added cursor movement between Menus
'               01.00.02 07/06/01 Added ToolTip selection support
'               01.00.03 13/06/01 Added New selection options
'
'===========================================================================

Option Explicit

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Const WM_SETREDRAW = &HB

Private Const mclMsgbxEXITAPP As Long = vbDefaultButton2 + vbQuestion + vbYesNo

Private Const clHFLAT_HILITE As Long = &H0&     '## v1.03
Private Const clHHILITE1 As Long = &H8080FF     '##
Private Const clHHILITE2 As Long = &HC0&        '##

Private Const clVFLAT_HILITE As Long = &HC0FFFF '## v1.03
Private Const clVHILITE1 As Long = &HFFC0FF     '##
Private Const clVHILITE2 As Long = &HC000C0     '##

Dim mlOldIndex As Long  '## Used by pExitApp subroutine

Private Sub chkDialog_Click(Index As Integer)

    Dim bState As Boolean

    bState = IIf(chkDialog(Index).Value, True, False)
    Select Case Index
        Case 0 '## Show Disabled
            ucHMenu.ShowDisabledItems = bState
            ucVMenu.ShowDisabledItems = bState
            With ucVMenu
                If .SelectedItem Then
                    lblDialog.Caption = .MenuItem(.SelectedItem).Desc
                Else
                    lblDialog.Caption = ""
                End If
            End With

        Case 1 '## Remember Selected
            '!! Handled by ucVMenu.ShowMenu method. See
            '   Form_Load & ucHMenu_ItemSelected events below

        Case 2 '## Show Separators
            ucHMenu.ShowSeparators = bState
            ucVMenu.ShowSeparators = bState

        Case 3 '## Show Focus Rectangle
            ucHMenu.ShowFocusRect = bState
            ucVMenu.ShowFocusRect = bState

        Case 4 '## Mouse Hover
            ucHMenu.ShowHover = bState
            ucVMenu.ShowHover = bState

        Case 5 '## Show ToolTips
            ucHMenu.ShowToolTips = bState
            ucVMenu.ShowToolTips = bState

        Case 6 '## Selection Hilite Type                                '## v1.03
            OptDialog(0).Enabled = bState                               '##
            OptDialog(1).Enabled = bState                               '##
            OptDialog(2).Enabled = bState                               '##
            'OptDialog(3).Enabled = bState                              '##
            Select Case bState                                          '##
                Case True                                               '##
                    If OptDialog(1).Value = True Then                   '##
                        ucHMenu.SelectedHiliteColor = clHHILITE1        '##
                        ucHMenu.HiLiteMode = [egh Horizontal Gradient]  '##
                        ucVMenu.SelectedHiliteColor = clVHILITE1        '##
                        ucVMenu.HiLiteMode = [egv Horizontal Gradient]  '##
                    ElseIf OptDialog(2).Value = True Then               '##
                        ucHMenu.SelectedHiliteColor = clHHILITE1        '##
                        ucHMenu.HiLiteMode = [egh Vertical Gradient]    '##
                        ucVMenu.SelectedHiliteColor = clVHILITE1        '##
                        ucVMenu.HiLiteMode = [egv Vertical Gradient]    '##
                    ElseIf OptDialog(3).Value = True Then               '##
                        ucHMenu.HiLiteMode = [egh Bitmap]               '##
                        ucVMenu.HiLiteMode = [egv Bitmap]               '##
                    ElseIf OptDialog(4).Value = True Then                   '##
                        ucHMenu.SelectedHiliteColor = clHHILITE1        '##
                        ucHMenu.HiLiteMode = [egh Tube Horizontal Gradient]  '##
                        ucVMenu.SelectedHiliteColor = clVHILITE1        '##
                        ucVMenu.HiLiteMode = [egv Tube Horizontal Gradient]  '##
                    ElseIf OptDialog(5).Value = True Then               '##
                        ucHMenu.SelectedHiliteColor = clHHILITE1        '##
                        ucHMenu.HiLiteMode = [egh Tube Vertical Gradient]    '##
                        ucVMenu.SelectedHiliteColor = clVHILITE1        '##
                        ucVMenu.HiLiteMode = [egv Tube Vertical Gradient]    '##
                    Else                                                '##
                        ucHMenu.SelectedHiliteColor = clHFLAT_HILITE    '##
                        ucHMenu.HiLiteMode = [egh Normal]               '##
                        ucVMenu.SelectedHiliteColor = clVFLAT_HILITE    '##
                        ucVMenu.HiLiteMode = [egv Normal]               '##
                    End If                                              '##
                Case False                                              '##
                    ucHMenu.SelectedHiliteColor = clHFLAT_HILITE        '##
                    ucHMenu.HiLiteMode = [egh Normal]                   '##
                    ucVMenu.SelectedHiliteColor = clVFLAT_HILITE        '##
                    ucVMenu.HiLiteMode = [egv Normal]                   '##
            End Select                                                  '##

    End Select
    ucHMenu.SetFocus

End Sub

Private Sub Form_Load()

    Dim oTxtFont As New StdFont
    Dim oSelFont As New StdFont
    Dim oDisFont As New StdFont
    Dim lPtr     As Long

    With oTxtFont
        .Name = "Tahoma": .Size = 8: .Bold = False
    End With

    With oSelFont
        .Name = "Tahoma": .Size = 8: .Bold = True
    End With

    With oDisFont
        .Name = "Tahoma": .Size = 8: .Bold = False: .Italic = True
    End With

    With ucHMenu
        Set .SelectTextFont = oSelFont
        Set .TextFont = oTxtFont
        Set .DisabledTextFont = oDisFont

        .SelectedHiliteColor = clHFLAT_HILITE   '## v1.03
        .SelectedHiliteColor2 = clHHILITE2      '##

        .ShowDisabledItems = IIf(chkDialog(0).Value, True, False)
        .ShowSeparators = IIf(chkDialog(2).Value, True, False)
        .ShowFocusRect = IIf(chkDialog(3).Value, True, False)
        .ShowToolTips = True

        .AddItem "File", "File Operations", True
        .AddItem "Edit", "Editing Operations", , False
        .AddItem "View", "View Options", , True
        .AddItem "Project", "Project Settings and Options...", , True
        .AddItem "Format", "Format", , True
        .AddItem "Exit", "Close MS Works 2000 Style Menu " + vbCrLf + "demonstration application", , True
    End With

    With ucVMenu
        Set .SelectTextFont = oSelFont
        Set .TextFont = oTxtFont
        Set .DisabledTextFont = oDisFont

        .SelectedHiliteColor = clVFLAT_HILITE   '## v1.03
        .SelectedHiliteColor2 = clVHILITE2      '##

        .ShowDisabledItems = IIf(chkDialog(0).Value, True, False)
        .ShowSeparators = IIf(chkDialog(2).Value, True, False)
        .ShowFocusRect = IIf(chkDialog(3).Value, True, False)
        .ShowToolTips = True

        lPtr = .AddMenu("File", True)
            .AddItem lPtr, "New Project", "Open a new project file", , False
            .AddItem lPtr, "Open Project", "Open an existing project", , True
            .AddItem lPtr, "Add Project", "Add a project to the project group", , True
            .AddItem lPtr, "Remove Project", "Remove project from the project group", , True
            .AddItem lPtr, "Save Project", "Save project to disk", , True
        lPtr = .AddMenu("Edit", True)
            .AddItem lPtr, "Undo Paste", "Edit Stock", , False
            .AddItem lPtr, "Can't Undo", "Can't Undo", , False
            .AddItem lPtr, "Cut", "Cut", , True
            .AddItem lPtr, "Copy", "Copy", , True
            .AddItem lPtr, "Paste", "Paste", , False
            .AddItem lPtr, "Paste Link", "Paste Link", , False
            .AddItem lPtr, "Remove", "Remove", , False
        lPtr = .AddMenu("View", True)
            .AddItem lPtr, "Code", "Code", , True
            .AddItem lPtr, "Object", "Object", , True
            .AddItem lPtr, "Definition", "Definition", , True
            .AddItem lPtr, "Object Browser", "Object Browser", , True
            .AddItem lPtr, "Immediate Window", "Immediate Window", , True
            .AddItem lPtr, "Locals Window", "Locals Window", , True
            .AddItem lPtr, "Watch Window", "Watch Window", , True
        lPtr = .AddMenu("Project", True)
            .AddItem lPtr, "Add Form", "Add Form", , True
            .AddItem lPtr, "Add MDI Form", "Add MDI Form", , True
            .AddItem lPtr, "Add Module", "Add Module", , True
            .AddItem lPtr, "Add Class Module", "Add Class Module", , True
            .AddItem lPtr, "Add User Control", "Add User Control", , True
            .AddItem lPtr, "Add Property Page", "Add Property Page", , True
            .AddItem lPtr, "Add User Document", "Add User Document", , False
        lPtr = .AddMenu("Format", True)
            .AddItem lPtr, "Align", "Align", , False
            .AddItem lPtr, "Make Same Size", "Make Same Size", , True
            .AddItem lPtr, "Size to Grid", "Size to Grid", , True
            .AddItem lPtr, "Horizontal Spacing", "Horizontal Spacing", , False
            .AddItem lPtr, "Vertical Spacing", "Vertical Spacing", , False
        .ShowMenu "File", , CBool(chkDialog(1).Value = 1)
        If .SelectedItem Then
            lblDialog.Caption = .MenuItem(.SelectedItem).Desc
        Else
            lblDialog.Caption = ""
        End If
        mlOldIndex = 1
    End With

End Sub

Private Sub Form_Resize()

    On Error Resume Next

    Dim lWidth  As Long
    Dim lOffSet As Long
    Dim lLoop   As Long

    With Me
        lWidth = .ScaleWidth \ 3
        If lWidth < 1400 Then lWidth = 1400
        ucHMenu.Move 0, 0, .ScaleWidth, ucHMenu.Height
        ucVMenu.Move .ScaleLeft, ucHMenu.Height, lWidth, .ScaleHeight - ucHMenu.Height
    End With

    lWidth = lWidth + 200
    lOffSet = lblHilite(1).Left - chkDialog(5).Left

    '## Lock control update
    For lLoop = 0 To 5
        pLockControl chkDialog(lLoop), True
        If lLoop < 2 Then
            pLockControl lblHilite(lLoop), True
        End If
    Next
    pLockControl lblNote, True
    pLockControl fraDialog, True

    '## Resize controls
    With chkDialog(0)
        .Move lWidth, .Top, .Width, .Height
        chkDialog(1).Move lWidth, chkDialog(1).Top, .Width, .Height
        chkDialog(2).Move lWidth, chkDialog(2).Top, .Width, .Height
        chkDialog(3).Move lWidth, chkDialog(3).Top, .Width, .Height
        chkDialog(4).Move lWidth, chkDialog(4).Top, chkDialog(4).Width, .Height
        chkDialog(5).Move lWidth, chkDialog(5).Top, chkDialog(5).Width, .Height
        chkDialog(6).Move lWidth, chkDialog(6).Top, chkDialog(6).Width, .Height
    End With
    With lblHilite(0)
        .Move chkDialog(4).Left + lOffSet, .Top, .Width, .Height
        lblHilite(1).Move .Left, lblHilite(1).Top, .Width, .Height
        lblHilite(2).Move .Left, lblHilite(2).Top, .Width, .Height
    End With

    With lblNote
        .Move lWidth, .Top, .Width, .Height
    End With

    With fraDialog
        .Move lWidth, Me.ScaleHeight - .Height - 100, Me.ScaleWidth - lWidth - 100, .Height
        lblDialog.Move 200, lblDialog.Top, .Width - 250, lblDialog.Height
    End With

    '## Unlock control update
    For lLoop = 0 To 5
        pLockControl chkDialog(lLoop), False
        If lLoop < 2 Then
            pLockControl lblHilite(lLoop), False
        End If
    Next
    pLockControl lblNote, False
    pLockControl fraDialog, False

    With picHilite
        .Move lWidth + 250, .Top, .Width, .Height
    End With

    '## Force a refresh
    Me.Refresh

End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = CInt(pExitApp = False)
End Sub

'## Added v1.03
Private Sub OptDialog_Click(Index As Integer)
    Select Case Index
        Case 0
            ucHMenu.SelectedHiliteColor = clHFLAT_HILITE
            ucHMenu.HiLiteMode = [egh Normal]
            ucVMenu.SelectedHiliteColor = clVFLAT_HILITE
            ucVMenu.HiLiteMode = [egv Normal]
        Case 1
            ucHMenu.SelectedHiliteColor = clHHILITE1
            ucHMenu.HiLiteMode = [egh Horizontal Gradient]
            ucVMenu.SelectedHiliteColor = clVHILITE1
            ucVMenu.HiLiteMode = [egv Horizontal Gradient]
        Case 2
            ucHMenu.SelectedHiliteColor = clHHILITE1
            ucHMenu.HiLiteMode = [egh Vertical Gradient]
            ucVMenu.SelectedHiliteColor = clVHILITE1
            ucVMenu.HiLiteMode = [egv Vertical Gradient]
        Case 3
            ucHMenu.HiLiteMode = [egh Bitmap]
            ucVMenu.HiLiteMode = [egv Bitmap]
        Case 4
            ucHMenu.SelectedHiliteColor = clHHILITE1
            ucHMenu.HiLiteMode = [egh Tube Horizontal Gradient]
            ucVMenu.SelectedHiliteColor = clVHILITE1
            ucVMenu.HiLiteMode = [egv Tube Horizontal Gradient]
        Case 5
            ucHMenu.SelectedHiliteColor = clHHILITE1
            ucHMenu.HiLiteMode = [egh Tube Vertical Gradient]
            ucVMenu.SelectedHiliteColor = clVHILITE1
            ucVMenu.HiLiteMode = [egv Tube Vertical Gradient]
    End Select
End Sub

Private Sub ucHMenu_HoverItem(Index As Long)
    Debug.Print "ucHMenu_HoverItem    Desc = "; ucHMenu.MenuItem(Index).Desc

End Sub

Private Sub ucHMenu_ItemSelected(Index As Long)

    Dim lret As Long

    Debug.Print "ucHMenu_ItemSelected    Desc = "; ucHMenu.MenuItem(Index).Desc
    Select Case ucHMenu.MenuItem(Index).Desc
        Case "Exit"
            Unload Me
        Case Else
            ucVMenu.ShowMenu , Index, CBool(chkDialog(1).Value = 1)
'            ucVMenu_ItemSelected ucVMenu.SelectedItem
            mlOldIndex = Index
    End Select

End Sub

Private Sub ucHMenu_MouseEnter()
    Debug.Print "ucHMenu_MouseEnter"
End Sub

Private Sub ucHMenu_MouseLeave()
    Debug.Print "ucHMenu_MouseLeave"
End Sub

Private Sub ucHMenu_RequestMenuItem(Direction As prjMenu.ehDir)

    With ucVMenu
        If .SelectedItem Then
            .SelectedItem = .SelectedItem + Direction
        End If
        .SetFocus
    End With

End Sub

Private Sub ucvMenu_HoverItem(Index As Long)
    Debug.Print "ucvMenu_HoverItem    Desc = "; ucVMenu.MenuItem(Index).Desc, Index
End Sub

Private Sub ucVMenu_ItemSelected(Index As Long)

    Debug.Print "ucVMenu_ItemSelected    Desc = "; ucVMenu.MenuItem(Index).Desc
    lblDialog.Caption = ucVMenu.MenuItem(Index).Desc

End Sub

Private Sub ucVMenu_MouseEnter()
    Debug.Print "ucVMenu_MouseEnter"
End Sub

Private Sub ucVMenu_MouseLeave()
    Debug.Print "ucVMenu_MouseLeave"
End Sub

Private Sub ucVMenu_RequestMenu(Direction As prjMenu.evDir)

    With ucHMenu
        If .SelectedItem Then
            .SelectedItem = .SelectedItem + Direction
        End If
        .SetFocus
    End With

End Sub

Private Function pExitApp() As Boolean
    If (MsgBox("Are you sure?", mclMsgbxEXITAPP, "Exit Program") = vbYes) Then
        pExitApp = True
    Else
        ucHMenu.SelectedItem = mlOldIndex
        pExitApp = False
    End If
End Function

Private Function pLockControl(objX As Object, cLock As Boolean)

   If cLock Then
      ' Disable the Redraw flag for the specified window
      Call SendMessage(objX.hWnd, WM_SETREDRAW, False, 0)
   Else
      ' Enable the Redraw flag for the specified window, and repaint
      Call SendMessage(objX.hWnd, WM_SETREDRAW, True, 0)
      objX.Refresh
   End If

End Function
