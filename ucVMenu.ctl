VERSION 5.00
Begin VB.UserControl ucVMenu 
   Appearance      =   0  'Flat
   ClientHeight    =   645
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1065
   ScaleHeight     =   645
   ScaleWidth      =   1065
   Begin VB.Timer tmrDialog 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   525
      Top             =   105
   End
   Begin VB.PictureBox picContainer 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   0  'None
      FillColor       =   &H00C0C0C0&
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
      Height          =   390
      Left            =   120
      ScaleHeight     =   390
      ScaleWidth      =   345
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   120
      Width           =   345
   End
End
Attribute VB_Name = "ucVMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'===========================================================================
'
' Control Name: ucVMenu
' Author:       Slider
' Date:         29/05/2001
' Version:      01.00.02
' Description:  MS Works Vertical Style Menus
' Edit History: 01.00.00 29/05/01 Initial Release
'               01.00.01 30/05/01 Fixed Hover
'                                 Added: events RequestMenu, Mouse Enter/Leave
'                                 Property SelectedItem now returns Indexed
'                                   item correctly
'               01.00.02 07/06/01 Added: ToolTip support
'                                 Fixed: Issue when no Menus exist (Dave Buckner)
'                                 Fixed: Hover mode still worked even when
'                                        disabled
'                                 Fixed: Flickering of ToolTips
'               01.00.03 13/06/01 Added: Horizonal/Vertical Graduated Selection
'                                        Hilite
'
'===========================================================================

Option Explicit

Private Const mclDRAWTEXTPARAM As Long = DT_SINGLELINE + DT_WORD_ELLIPSIS + DT_LEFT
Private Const mclTIPTIME = 75  ' milli-seconds  '## v1.02

Private mcMemDC          As cMemDC
Private moTip            As cInfoTip            '## v1.02
Private mlTipTime        As Long                '##
Private mPtTip           As POINTAPI            '##
Private moMenu           As colMenus
Private mUCRect          As RECT
Private mlHoverItem      As Long
Private mlOldHoverItem   As Long
Private mlMenuPtr        As Long
Private mlFontCount      As Long
Private moFnt()          As StdFont
Private mlFnt()          As Long
Private mlFontBold       As Long
Private mlFontNorm       As Long
Private mlFontDisabled   As Long
Private mlTextHeight     As Long
Private mlItemHeight     As Long
Private mbMouseDown      As Boolean
Private mbMouseMove      As Boolean
Private mbGotFocus       As Boolean

Private moSelTextColor   As OLE_COLOR
Private moSelHiliteColor As OLE_COLOR
Private moTextColor      As OLE_COLOR
Private moDisabledColor  As OLE_COLOR
Private moSeparatorColor As OLE_COLOR
Private moBackColor      As OLE_COLOR
Private moHoverColor     As OLE_COLOR
Private moSelTextFont    As StdFont
Private moTextFont       As StdFont
Private moDisabledFont   As StdFont
Private mbShowDisabled   As Boolean
Private mbShowToolTips   As Boolean
Private mbShowSeparators As Boolean
Private mbShowFocusRect  As Boolean
Private mbShowHover      As Boolean
Private meSelHiLiteMode   As eVHiLiteMode   '## v1.03
Private moSelHiliteColor2 As OLE_COLOR      '##

Public Enum eVHiLiteMode                    '## v1.03
    [egv Normal] = 0                        '##
    [egv Horizontal Gradient] = 1           '##
    [egv Vertical Gradient] = 2             '##
    [egv Tube Horizontal Gradient] = 3      '##
    [egv Tube Vertical Gradient] = 4        '##
    [egv Bitmap] = 5                        '## (future)
End Enum                                    '##

Private Enum eFindItemMode
    efimForward = 0
    efimBackward = 1
End Enum

Public Enum evDir                           '## v1.01
    evdPreviousMenu = -1                    '##
    evdNextMenu = 1                         '##
End Enum                                    '##

Event ItemSelected(Index As Long)
Event HoverItem(Index As Long)
Event RequestMenu(Direction As evDir)       '## v1.01
Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Event MouseEnter()                          '## v1.01
Event MouseLeave()                          '##
Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

Public Property Get hWnd() As Long
    hWnd = UserControl.hWnd
End Property

Public Property Get SelectedTextColor() As OLE_COLOR
    SelectedTextColor = moSelTextColor
End Property

Public Property Let SelectedTextColor(ByVal NewColor As OLE_COLOR)
    moSelTextColor = NewColor
    PropertyChanged "SelectedTextColor"
    pDraw
End Property

Public Property Get SelectedHiliteColor() As OLE_COLOR
    SelectedHiliteColor = moSelHiliteColor
End Property

Public Property Let SelectedHiliteColor(ByVal NewColor As OLE_COLOR)
    moSelHiliteColor = NewColor
    PropertyChanged "SelectedHiliteColor"
    pDraw
End Property

Public Property Get SelectedHiliteColor2() As OLE_COLOR                 '## v1.03
    SelectedHiliteColor2 = moSelHiliteColor2                            '##
End Property                                                            '##

Public Property Let SelectedHiliteColor2(ByVal NewColor As OLE_COLOR)   '## v1.03
    moSelHiliteColor2 = NewColor                                        '##
    PropertyChanged "SelectedHiliteColor2"                              '##
    pDraw                                                               '##
End Property                                                            '##

Public Property Get TextColor() As OLE_COLOR
    TextColor = moTextColor
End Property

Public Property Let TextColor(ByVal NewColor As OLE_COLOR)
    moTextColor = NewColor
    PropertyChanged "TextColor"
    pDraw
End Property

Public Property Get DisabledTextColor() As OLE_COLOR
    DisabledTextColor = moDisabledColor
End Property

Public Property Let DisabledTextColor(ByVal NewColor As OLE_COLOR)
    moDisabledColor = NewColor
    PropertyChanged "DisabledTextColor"
    pDraw
End Property

Public Property Get SeparatorColor() As OLE_COLOR
    SeparatorColor = moSeparatorColor
End Property

Public Property Let SeparatorColor(ByVal NewColor As OLE_COLOR)
    moSeparatorColor = NewColor
    PropertyChanged "SeparatorColor"
    pDraw
End Property

Public Property Get BackColor() As OLE_COLOR
    BackColor = moBackColor
End Property

Public Property Let BackColor(ByVal NewColor As OLE_COLOR)
    moBackColor = NewColor
    PropertyChanged "BackColor"
    pDraw
End Property

Public Property Get HoverColor() As OLE_COLOR
    HoverColor = moHoverColor
End Property

Public Property Let HoverColor(ByVal NewColor As OLE_COLOR)
    moHoverColor = NewColor
    PropertyChanged "HoverColor"
    pDraw
End Property

Public Property Get SelectTextFont() As StdFont
   Set SelectTextFont = moSelTextFont
End Property

Public Property Set SelectTextFont(ByVal sFont As StdFont)
    Set moSelTextFont = sFont
    mlFontBold = pAddFontIfRequired(moSelTextFont)
    PropertyChanged "SelectTextFont"
    pDraw
End Property

Public Property Get TextFont() As StdFont
   Set TextFont = moTextFont
End Property

Public Property Set TextFont(ByVal sFont As StdFont)
    Set moTextFont = sFont
    mlFontNorm = pAddFontIfRequired(moTextFont)
    PropertyChanged "TextFont"
    pDraw
End Property

Public Property Get DisabledTextFont() As StdFont
   Set DisabledTextFont = moDisabledFont
End Property

Public Property Set DisabledTextFont(ByVal sFont As StdFont)
    Set moDisabledFont = sFont
    mlFontDisabled = pAddFontIfRequired(moDisabledFont)
    PropertyChanged "DisabledTextFont"
    pDraw
End Property

Public Property Get ShowDisabledItems() As Boolean
    ShowDisabledItems = mbShowDisabled
End Property

Public Property Let ShowDisabledItems(ByVal Flag As Boolean)
    mbShowDisabled = Flag
    PropertyChanged "ShowDisabledItems"
    pDraw
End Property

Public Property Get ShowToolTips() As Boolean
    ShowToolTips = mbShowToolTips
End Property

Public Property Let ShowToolTips(ByVal Flag As Boolean)
    mbShowToolTips = Flag
    PropertyChanged "ShowToolTips"
    pDraw
End Property

Public Property Get ShowSeparators() As Boolean
    ShowSeparators = mbShowSeparators
End Property

Public Property Let ShowSeparators(ByVal Flag As Boolean)
    mbShowSeparators = Flag
    PropertyChanged "ShowSeparators"
    pDraw
End Property

Public Property Get ShowFocusRect() As Boolean
    ShowFocusRect = mbShowFocusRect
End Property

Public Property Let ShowFocusRect(ByVal Flag As Boolean)
    mbShowFocusRect = Flag
    PropertyChanged "ShowFocusRect"
    pDraw
End Property

Public Property Get ShowHover() As Boolean
    ShowHover = mbShowHover
End Property

Public Property Let ShowHover(ByVal Flag As Boolean)
    If (Not Flag = mbShowHover) Then mlHoverItem = 0
    mbShowHover = Flag
    PropertyChanged "ShowHover"
    pDraw
End Property

Public Property Get HiLiteMode() As eVHiLiteMode             '## v1.03
    HiLiteMode = meSelHiLiteMode                            '##
End Property                                                '##

Public Property Let HiLiteMode(ByVal Mode As eVHiLiteMode)   '##
    meSelHiLiteMode = Mode                                  '##
    PropertyChanged "HiLiteMode"                            '##
    pDraw
End Property


Public Property Get SelectedItem() As Long
    SelectedItem = moMenu(mlMenuPtr).Selected
End Property

Public Property Let SelectedItem(ByVal ItemPtr As Long)
    Dim lPtr As Long
    If ItemPtr Then
        With moMenu(mlMenuPtr)
            If ItemPtr > .MenuItem.Count Then
                ItemPtr = .MenuItem.Count
            End If
            If .MenuItem(ItemPtr).Enabled = False Then
                lPtr = pFindItem(ItemPtr, efimForward)
                If lPtr = 0 Then
                    pFindItem ItemPtr, efimBackward
                End If
            Else
                .Selected = ItemPtr
            End If
            pDraw
            RaiseEvent ItemSelected(.Selected)
        End With
    End If
End Property

Public Property Get MenuCount() As Long
    MenuCount = moMenu.Count
End Property

Public Property Get MenuItemCount() As Long
    MenuItemCount = moMenu(mlMenuPtr).MenuItem.Count
End Property

Public Property Get MenuItem(ByVal Index As Long) As cMenuItem
    With moMenu(mlMenuPtr)
        If Index < 1 Then Index = .Selected
        If Index <= .MenuItem.Count Then
            Set MenuItem = .MenuItem(Index)
        End If
    End With
End Property

Public Property Set MenuItem(ByVal Index As Long, ByVal Item As cMenuItem)
    With moMenu(mlMenuPtr)
        If Index < 1 Then Index = .Selected
        If Index <= .MenuItem.Count Then
            Set .MenuItem(Index) = Item
            pDraw
        End If
    End With
End Property

Public Function AddMenu(Caption As String, _
               Optional Enabled As Boolean = True) As Long

    Dim lLoop As Long

    If Len(Caption) Then
        With moMenu
            .Add Caption, Enabled
            For lLoop = 1 To .Count
                If .Item(lLoop).Desc = Caption Then
                    AddMenu = lLoop
                    Exit For
                End If
            Next
        End With
    End If

End Function

Public Function MenuExist(ByVal Caption As String) As Boolean

    Dim oMenu As cMenu

    If Len(Caption) Then
        Caption = UCase$(Caption)
        For Each oMenu In moMenu
            If UCase$(oMenu.Desc) = Caption Then
                MenuExist = True
                Exit For
            End If
        Next
    End If

End Function

Public Function AddItem(ParentIndex As Long, _
                        Desc As String, _
                        ToolTip As String, _
               Optional Tag As Variant, _
               Optional Enabled As Boolean = True) As Long

    Dim lLoop As Long

    If ParentIndex Then
        If Len(Desc) Then
            With moMenu(ParentIndex).MenuItem
                .Add Desc, ToolTip, Tag, Enabled
                For lLoop = 1 To .Count
                    If .Item(lLoop).Desc = Desc Then
                        AddItem = lLoop
                        Exit For
                    End If
                Next
            End With
        End If
    End If

End Function

Public Sub ShowMenu(Optional ByVal Caption As String = "", _
                    Optional ByVal Index As Long = 1, _
                    Optional ByVal RememberSelected As Boolean = True)

    Dim lLoop As Long
    Dim sTxt  As String

    With moMenu
        If Len(Caption) Then
            sTxt = UCase$(Caption)
            For lLoop = 1 To .Count
                If UCase$(.Item(lLoop).Desc) = sTxt Then
                    If lLoop <> mlMenuPtr Then
                        mlMenuPtr = lLoop
                        If moMenu(lLoop).Selected = 0 Then
                            pFindItem 1, efimForward
                        ElseIf RememberSelected = False Then
                            pFindItem 1, efimForward
                        End If
                        moTip.Hide              '## v1.02a
                        mlTipTime = 0           '##
                        pDraw
'                        If Not pFindItem(1, efimForward) Then
'                            moMenu(lLoop).Selected = 0
                    End If
                    Exit For
                End If
            Next
        Else
            If Index <> mlMenuPtr Then
                If Index < 1 Then Index = 1
                If Index <= .Count Then
                    mlMenuPtr = Index
                    If moMenu(mlMenuPtr).Selected < 1 Then
                        pFindItem 1, efimForward
                    ElseIf RememberSelected = False Then
                        pFindItem 1, efimForward
                    End If
                    moTip.Hide                  '## v1.02a
                    mlTipTime = 0               '##
                    pDraw
                End If
            End If
        End If
    End With
    If moMenu(mlMenuPtr).Selected Then
        RaiseEvent ItemSelected(moMenu(mlMenuPtr).Selected)
    End If

End Sub

Public Sub Refresh()
    pDraw
End Sub

Private Sub picContainer_GotFocus()
    mbGotFocus = True
    pDraw
End Sub

Private Sub picContainer_KeyDown(KeyCode As Integer, Shift As Integer)

    Dim bUpdate As Boolean
    Dim lMax    As Long

'    Debug.Print "picContainer_KeyDown", KeyCode, Shift
    With moMenu(mlMenuPtr)
        If .Selected Then
            lMax = .MenuItem.Count
            Select Case KeyCode
                Case 33 ' Home
                    bUpdate = pFindItem(1, efimForward)
                Case 36 ' PgUp
                    bUpdate = pFindItem(1, efimForward)
                Case 38 ' Up
                    bUpdate = pFindItem(.Selected - 1, efimBackward)
                Case 37 ' Left                                  '## v1.01
                    RaiseEvent RequestMenu(evdPreviousMenu)     '##
                Case 39 ' Right                                 '##
                    RaiseEvent RequestMenu(evdNextMenu)         '##
                Case 40 ' Down
                    bUpdate = pFindItem(.Selected + 1, efimForward)
                Case 34 ' PgDn
                    bUpdate = pFindItem(lMax, efimBackward)
                Case 35 ' End
                    bUpdate = pFindItem(lMax, efimBackward)
            End Select
        End If
    
        If bUpdate Then
            pDraw
            RaiseEvent ItemSelected(.Selected)
        End If
    End With

End Sub

Private Sub picContainer_LostFocus()
    mbGotFocus = False
    moTip.Hide                              '## v1.02a
    mlTipTime = 0                           '##
    pDraw
    Debug.Print "picContainer_LostFocus"
End Sub

Private Sub picContainer_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseDown(Button, Shift, X, Y)
    Dim lPtr As Long
    lPtr = pGetItem(X, Y)
    If lPtr Then
        With moMenu(mlMenuPtr)
            'Debug.Print "Item="; .Desc
            If .MenuItem(lPtr).Enabled Then
                .Selected = lPtr
                mbMouseDown = True
                pDraw
            End If
        End With
    End If
End Sub

Private Sub picContainer_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Not tmrDialog.Enabled Then               '## v1.01
        RaiseEvent MouseEnter                   '##
        tmrDialog.Enabled = True                '##
    End If                                      '##
    'If mbShowHover Then                        '## v1.02a
        mlHoverItem = pGetItem(X, Y)
    'End If                                     '## v1.02a
    RaiseEvent MouseMove(Button, Shift, X, Y)
End Sub

Private Sub picContainer_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseUp(Button, Shift, X, Y)
    If mbMouseDown Then
        With moMenu(mlMenuPtr)
            If .Enabled Then
                moTip.Hide
                RaiseEvent ItemSelected(.Selected)
            End If
        End With
    End If
    mbMouseDown = False
End Sub

Private Sub tmrDialog_Timer()

    Dim csrPnt As POINTAPI
    
    If mlMenuPtr = 0 Then Exit Sub                                              '## v1.02a (Dave Buckner)
    mlTipTime = mlTipTime + 1                                                   '## v1.02
    GetCursorPos csrPnt
    ScreenToClient UserControl.hWnd, csrPnt
    If PtInRect(mUCRect, csrPnt.X, csrPnt.Y) Then
        With moMenu(mlMenuPtr)
            If mlHoverItem = 0 Then mlTipTime = 0                               '## v1.02
            If mlTipTime > mclTIPTIME And mbShowToolTips And mlHoverItem Then   '##
                If (mPtTip.X <> csrPnt.X) Or (mPtTip.Y <> csrPnt.Y) Then        '##
                    moTip.Show moMenu(mlMenuPtr).MenuItem(mlHoverItem).Tip      '##
                    mPtTip.X = csrPnt.X                                         '##
                    mPtTip.Y = csrPnt.Y                                         '##
                End If                                                          '##
            Else                                                                '##
                moTip.Hide                                                      '##
            End If                                                              '##
            If mlHoverItem <> .Selected And mlHoverItem <> mlOldHoverItem And _
                                            mlHoverItem And mbShowHover Then    '## v1.02a
                mlOldHoverItem = mlHoverItem
                If .Enabled And .MenuItem(mlHoverItem).Enabled Then
                    RaiseEvent HoverItem(mlHoverItem)
                End If
            End If
        End With
    Else
        moTip.Hide                                                              '## v1.02
        mlTipTime = 0                                                           '##
        tmrDialog.Enabled = False
        mlOldHoverItem = 0
        mlHoverItem = 0
        RaiseEvent MouseLeave
    End If
    pDraw

End Sub

Private Sub UserControl_Initialize()
    pInitialise
End Sub

Private Sub UserControl_InitProperties()

    Dim sFnt1 As New StdFont
    Dim sFnt2 As New StdFont
    Dim sFnt3 As New StdFont

    With sFnt1
        .Name = "MS Sans Serif": .Size = 8: .Bold = True
    End With
    With sFnt2
        .Name = "MS Sans Serif": .Size = 8: .Bold = False
    End With
    With sFnt3
        .Name = "MS Sans Serif": .Size = 8: .Bold = False: .Italic = True
    End With

    mbShowDisabled = False
    mbShowToolTips = False
    mbShowSeparators = True
    mbShowFocusRect = True
    mbShowHover = True
    meSelHiLiteMode = [egv Normal]  '## v1.03

    moSelTextColor = &H0&
    moSelHiliteColor = &HC0FFFF
    moSelHiliteColor2 = &H0         '## v1.03
    moTextColor = &H404040
    moDisabledColor = &H808080
    moSeparatorColor = &HC0C0C0
    moBackColor = &HE0E0E0
    moHoverColor = &H80FF&

    Set Me.SelectTextFont = sFnt1
    Set Me.TextFont = sFnt2
    Set Me.DisabledTextFont = sFnt3

End Sub

Private Sub UserControl_LostFocus()
    Debug.Print "UserControl_LostFocus"
End Sub

Private Sub UserControl_Paint()
    pDraw
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    pInitialise

    Dim sFnt1 As New StdFont
    Dim sFnt2 As New StdFont
    Dim sFnt3 As New StdFont

    With sFnt1
        .Name = "MS Sans Serif": .Size = 8: .Bold = True
    End With
    With sFnt2
        .Name = "MS Sans Serif": .Size = 8: .Bold = False
    End With
    With sFnt3
        .Name = "MS Sans Serif": .Size = 8: .Bold = False: .Italic = True
    End With

    mbShowDisabled = PropBag.ReadProperty("ShowDisabledItems", False)
    mbShowToolTips = PropBag.ReadProperty("ShowToolTips", False)
    mbShowSeparators = PropBag.ReadProperty("ShowSeparators", True)
    mbShowFocusRect = PropBag.ReadProperty("ShowFocusRect", True)
    mbShowHover = PropBag.ReadProperty("ShowHover", True)
    meSelHiLiteMode = PropBag.ReadProperty("HiLiteMode", [egv Normal])      '## v1.03

    moSelTextColor = PropBag.ReadProperty("SelectedTextColor", &H0&)
    moSelHiliteColor = PropBag.ReadProperty("SelectedHiliteColor", &HC0FFFF)
    moSelHiliteColor2 = PropBag.ReadProperty("SelectedHiliteColor2", &H0&)  '## v1.03
    moTextColor = PropBag.ReadProperty("TextColor", &H404040)
    moDisabledColor = PropBag.ReadProperty("DisabledTextColor", &H808080)
    moSeparatorColor = PropBag.ReadProperty("SeparatorColor", &HC0C0C0)
    moBackColor = PropBag.ReadProperty("BackColor", &HE0E0E0)
    moHoverColor = PropBag.ReadProperty("HoverColor", &H80FF&)

    Set Me.SelectTextFont = PropBag.ReadProperty("SelectTextFont", sFnt1)
    Set Me.TextFont = PropBag.ReadProperty("TextFont", sFnt2)
    Set Me.DisabledTextFont = PropBag.ReadProperty("DisabledTextFont", sFnt3)

End Sub

Private Sub UserControl_Resize()
    With UserControl
        picContainer.Move .ScaleLeft, .ScaleTop, .ScaleWidth, .ScaleHeight
        mUCRect.Right = .Width \ Screen.TwipsPerPixelX
        mUCRect.Bottom = .Height \ Screen.TwipsPerPixelY
    End With
    pDraw
End Sub

Private Sub UserControl_Terminate()

    Dim iFnt As Long

    For iFnt = 1 To mlFontCount
        DeleteObject mlFnt(iFnt)
    Next

    Set moMenu = Nothing
    Set mcMemDC = Nothing
    Set moTip = Nothing

End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

    Dim sFnt1 As New StdFont
    Dim sFnt2 As New StdFont
    Dim sFnt3 As New StdFont

    With sFnt1
        .Name = "MS Sans Serif": .Size = 8: .Bold = True
    End With
    With sFnt2
        .Name = "MS Sans Serif": .Size = 8: .Bold = False
    End With
    With sFnt3
        .Name = "MS Sans Serif": .Size = 8: .Bold = False: .Italic = True
    End With

    PropBag.WriteProperty "ShowDisabledItems", mbShowDisabled, False
    PropBag.WriteProperty "ShowToolTips", mbShowToolTips, False
    PropBag.WriteProperty "ShowSeparators", mbShowSeparators, True
    PropBag.WriteProperty "ShowFocusRect", mbShowFocusRect, True
    PropBag.WriteProperty "ShowHover", mbShowHover, True
    PropBag.WriteProperty "HiLiteMode", meSelHiLiteMode, [egv Normal]       '## v1.03

    PropBag.WriteProperty "SelectedTextColor", moSelTextColor, &H0&
    PropBag.WriteProperty "SelectedHiliteColor", moSelHiliteColor, &HC0FFFF
    PropBag.WriteProperty "SelectedHiliteColor2", moSelHiliteColor2, &H0    '## v1.03
    PropBag.WriteProperty "TextColor", moTextColor, &H404040
    PropBag.WriteProperty "DisabledTextColor", moDisabledColor, &H808080
    PropBag.WriteProperty "SeparatorColor", moSeparatorColor, &HC0C0C0
    PropBag.WriteProperty "BackColor", moBackColor, &HE0E0E0
    PropBag.WriteProperty "HoverColor", moHoverColor, &H80FF&

    PropBag.WriteProperty "SelectTextFont", moSelTextFont, sFnt1
    PropBag.WriteProperty "TextFont", moTextFont, sFnt2
    PropBag.WriteProperty "DisabledTextFont", moDisabledFont, sFnt3

End Sub

Private Function pFindItem(ByVal Start As Long, Mode As eFindItemMode) As Boolean

    Dim lLoop As Long
    Dim lMax  As Long

    With moMenu(mlMenuPtr)
        lMax = .MenuItem.Count
        If Start < 1 Then Start = 1
        If Start > lMax Then Start = lMax
        Select Case Mode
            Case efimForward
                For lLoop = Start To lMax
                    If .MenuItem(lLoop).Enabled Then
                        If .Enabled Then
                            If lLoop <> .Selected Then
                                pFindItem = True
                                .Selected = lLoop
                            End If
                        End If
                        Exit For
                    End If
                Next

            Case efimBackward
                For lLoop = Start To 1 Step -1
                    If .MenuItem(lLoop).Enabled Then
                        If .Enabled Then
                            If lLoop <> .Selected Then
                                pFindItem = True
                                .Selected = lLoop
                            End If
                        End If
                        Exit For
                    End If
                Next

        End Select
    End With

End Function

Private Sub pInitialise()
    Set mcMemDC = New cMemDC
    Set moMenu = New colMenus
    Set moTip = New cInfoTip        '## v1.02
    moTip.hWnd = picContainer.hWnd  '## v1.02
End Sub

'## Returns the Item's width in pixels
Private Function pGetItemWidth(FntPtr, ItemPtr) As Long
    With picContainer
        Set .Font = moFnt(FntPtr)
        pGetItemWidth = .TextWidth(moMenu(mlMenuPtr).MenuItem(ItemPtr).Desc) \ Screen.TwipsPerPixelX
    End With
End Function

'## Returns the Item's height in pixels
Private Function pGetItemHeight(FntPtr) As Long
    With picContainer
        Set .Font = moFnt(FntPtr)
        pGetItemHeight = .TextHeight("Mg") \ Screen.TwipsPerPixelY
    End With
End Function

'## Returns co-odinates for MenuItem(Index)
Private Function pGetPositionRect(Position As Long) As RECT

    Dim tRect As RECT
    Dim xTm   As TEXTMETRIC

    GetTextMetrics picContainer.hdc, xTm
    mlTextHeight = xTm.tmHeight - xTm.tmInternalLeading
    mlItemHeight = mlTextHeight * 2.5
    tRect.Top = mlTextHeight + mlItemHeight * (Position - 1) - 1
    tRect.Bottom = tRect.Top + mlItemHeight
    tRect.Left = 10
    tRect.Right = picContainer.Width \ Screen.TwipsPerPixelX - tRect.Left
    pGetPositionRect = tRect

End Function

'## Gets Menuitem's Index from Mouse co-ordinates
Private Function pGetItem(X As Single, Y As Single) As Long

    Dim lPtr  As Long
    Dim tRect As RECT
    Dim lLoop As Long
    Dim lMax  As Long

    If mlMenuPtr = 0 Then Exit Function         '## v1.02a (Dave Buckner)
    With moMenu(mlMenuPtr)
        lMax = .MenuItem.Count
        Do
            lPtr = lPtr + 1
            tRect = pGetPositionRect(lPtr)
            If PtInRect(tRect, CLng(X \ Screen.TwipsPerPixelX), CLng(Y \ Screen.TwipsPerPixelY)) Then
                '## now figure out the index
                For lLoop = 1 To .MenuItem.Count
                    If .MenuItem(lLoop).pDisplayNDX = lPtr Then
                       pGetItem = lLoop
                       Exit For
                    End If
                Next
                Exit Do
            End If
        Loop Until lPtr > lMax
    End With

End Function

Private Sub pDraw()

    Dim PicRect      As RECT
    Dim lpPoint      As POINTAPI
    Dim lHDC         As Long
    Dim lhDCU        As Long
    Dim bMemDC       As Boolean
    Dim tRectItem    As RECT
    Dim tR           As RECT        '## v1.03
    Dim lBrush       As Long
    Dim lItems       As Long
    Dim lLoop        As Long
    Dim lPtr         As Long
    Dim hFntOld      As Long
    Dim lFontPtr     As Long
    Dim oItemColor   As OLE_COLOR
    Dim xTm          As TEXTMETRIC
    Dim bShowItem    As Boolean
    Dim bEnabledItem As Boolean
    Dim lSelected    As Long
    Dim bSelected    As Boolean
    Dim lHght        As Long
    Dim lWidth       As Long
    Dim lMid         As Long

    '## Check and see if we should display anything
    If mlMenuPtr = 0 Then
        Exit Sub
    ElseIf Not mbShowDisabled Then
        If moMenu(mlMenuPtr).Selected = 0 Then
            Exit Sub
        ElseIf moMenu(mlMenuPtr).Enabled = False Then
            Exit Sub
        End If
'    ElseIf momenu(mlMenuPtr).Selected = 0 Then
'        Exit Sub
    End If

    With moMenu(mlMenuPtr)
        '## Remember and disable selection if not Menu enabled
        lSelected = .Selected
        If .Enabled = False Then
            .Selected = 0
        End If

        '## Drawing Preparation
        LockControl picContainer, True
        pPrepareMemDC lHDC, lhDCU, bMemDC

        '## Fill background
        GetClientRect picContainer.hWnd, PicRect
        pFillBackground lHDC, PicRect, 0, 0

        '## Set default values
        lItems = moMenu(mlMenuPtr).MenuItem.Count

        '## Loop through each MenuItem
        For lLoop = 1 To lItems

            '## If not showing a disabled menu, then disable all items
            If .Enabled = False Then
                bEnabledItem = False
            Else
                bEnabledItem = .MenuItem(lLoop).Enabled
            End If

            '## Selected Item??
            If lLoop = .Selected Then
                lBrush = CreateSolidBrush(TranslateColor(moSelHiliteColor))
                lFontPtr = mlFontBold
                oItemColor = moSelTextColor
                bShowItem = True
                bSelected = True
            Else                                         '## Normal Item
                If bEnabledItem = False Then             '## Is the MenuItem disabled?
                    If mbShowDisabled = True Then        '## Do we show disabled Items?
                        lFontPtr = mlFontDisabled
                        oItemColor = moDisabledColor
                        lBrush = CreateSolidBrush(TranslateColor(moSeparatorColor))
                        bShowItem = True
                    End If
                Else                                     '## A Normal enabled MenuItem
                    lFontPtr = mlFontNorm
                    If mlHoverItem = lLoop And mbShowHover Then '## v1.02a
                        oItemColor = moHoverColor        '## v1.01
                    Else                                 '##
                        oItemColor = moTextColor         '##
                    End If                               '##
                    lBrush = CreateSolidBrush(TranslateColor(moSeparatorColor))
                    bShowItem = True
                End If
            End If

            '## Let's show the valid MenuItems
            If bShowItem = True Then
                lPtr = lPtr + 1
                tRectItem = pGetPositionRect(lPtr)
                If bSelected Then
                    tRectItem.Top = tRectItem.Top - 1
                    Select Case meSelHiLiteMode                         '## v1.03
                        Case [egv Normal]                               '##
                            FillRect lHDC, tRectItem, lBrush     '## Draw Selection bar
                        Case [egv Horizontal Gradient]                  '##
                            LSet tR = tRectItem                         '##
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor, _
                                                  moSelHiliteColor2, _
                                                  False                 '##
                        Case [egv Vertical Gradient]                    '##
                            LSet tR = tRectItem                         '##
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor, _
                                                  moSelHiliteColor2, _
                                                  True                  '##
                        Case [egv Tube Horizontal Gradient]             '##
                            LSet tR = tRectItem                         '##
                            lMid = (tR.Bottom - tR.Top) \ 2
                            tR.Bottom = tR.Top + lMid
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor, _
                                                  moSelHiliteColor2, _
                                                  True                  '##
                            tR.Top = tR.Bottom - 1                      '##
                            tR.Bottom = tRectItem.Bottom                '##
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor2, _
                                                  moSelHiliteColor, _
                                                  True                  '##
                        Case [egv Tube Vertical Gradient]               '##
                            LSet tR = tRectItem                         '##
                            lMid = (tR.Right - tR.Left) \ 2             '##
                            tR.Right = tR.Left + lMid                   '##
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor, _
                                                  moSelHiliteColor2, _
                                                  False                 '##
                            tR.Left = tR.Right - 1                      '##
                            tR.Right = tRectItem.Right                  '##
                            DrawGraduatedBackdrop lHDC, _
                                                  tR, _
                                                  moSelHiliteColor2, _
                                                  moSelHiliteColor, _
                                                  False                 '##
                    End Select                                          '##
                Else
                    If mbShowSeparators Then
                        tRectItem.Top = tRectItem.Bottom - 1
                        FillRect lHDC, tRectItem, lBrush '## Draw Gridline
                    End If
                End If
                DeleteObject lBrush                      '## Clean up
                .MenuItem(lLoop).pDisplayNDX = lPtr      '## Remember display position
    
                '## Set Text region to clip oversized texts
                tRectItem.Top = tRectItem.Bottom - (mlTextHeight * 2)
                tRectItem.Left = tRectItem.Left + (tRectItem.Left \ 2)
                tRectItem.Right = tRectItem.Right - 2

                '## Move to text position
                MoveToEx lHDC, tRectItem.Left, tRectItem.Top, lpPoint   '## Position for text
    
                '## Draw text
                hFntOld = SelectObject(lHDC, mlFnt(lFontPtr))
                SetTextColor lHDC, TranslateColor(oItemColor)
                DrawText .MenuItem(lLoop).Desc, lHDC, tRectItem, mclDRAWTEXTPARAM
    
                If bSelected Then
                    If mbGotFocus Then
                        If mbShowFocusRect Then
                            lHght = pGetItemHeight(lFontPtr)
                            lWidth = pGetItemWidth(lFontPtr, lLoop)
                            If lWidth > tRectItem.Right - tRectItem.Left Then
                                lWidth = tRectItem.Right - tRectItem.Left - 1
                            End If
                            tRectItem.Top = tRectItem.Top '+ 2
                            tRectItem.Bottom = tRectItem.Top + lHght '- 2
                            tRectItem.Right = tRectItem.Left + lWidth
                            InflateRect tRectItem, 3, 2 ',1
                            DrawFocusRect lHDC, tRectItem
                        End If
                    End If
                End If
                bSelected = False
                bShowItem = False
            Else
                .MenuItem(lLoop).pDisplayNDX = 0         '## Reset display pointer if not selected
            End If
        Next
    End With

    '## Display memDC & clean up
    pMemDCToDC lhDCU, lHDC, bMemDC, PicRect
    LockControl picContainer, False
    moMenu(mlMenuPtr).Selected = lSelected

End Sub

Private Sub pFillBackground(ByVal lHDC As Long, _
                            ByRef tR As RECT, _
                            ByVal lOffsetX As Long, _
                            ByVal lOffsetY As Long)

    Dim hBr As Long

'    If (mbBitmap) Then
'        TileArea lHDC, _
'                 tR.Left, tR.Top, tR.Right - tR.Left, tR.Bottom - tR.Top, _
'                 mhDCSrc, _
'                 mlBitmapW, mlBitmapH, _
'                 lOffsetX, lOffsetY
'    Else
        hBr = CreateSolidBrush(TranslateColor(moBackColor))
        FillRect lHDC, tR, hBr
        DeleteObject hBr
'    End If

End Sub

Private Sub pMemDCToDC(ByVal lhDCU As Long, ByVal lHDC As Long, ByVal bMemDC As Boolean, ByRef tR As RECT)
   If bMemDC Then
      With tR
          BitBlt lhDCU, .Left, .Top, .Right - .Left, .Bottom - .Top, lHDC, 0, 0, vbSrcCopy
      End With
   End If
End Sub

Private Sub pPrepareMemDC(ByRef lHDC As Long, ByRef lhDCU As Long, ByRef bMemDC As Boolean)
   
   lhDCU = picContainer.hdc
   If Not mcMemDC Is Nothing Then
      mcMemDC.Width = picContainer.ScaleWidth \ Screen.TwipsPerPixelY
      mcMemDC.Height = picContainer.ScaleHeight \ Screen.TwipsPerPixelX
      lHDC = mcMemDC.hdc
   End If
   If lHDC = 0 Then
      lHDC = lhDCU
   Else
      bMemDC = True
   End If
   SetBkColor lHDC, TranslateColor(moBackColor)
   SetBkMode lHDC, TRANSPARENT
   SetTextColor lHDC, TranslateColor(moTextColor)

End Sub

Private Function pAddFontIfRequired(ByVal oFont As StdFont) As Long

    Dim iFnt As Long
    Dim tULF As LOGFONT

   For iFnt = 1 To mlFontCount
      If (oFont.Name = moFnt(iFnt).Name) And (oFont.Bold = moFnt(iFnt).Bold) And (oFont.Italic = moFnt(iFnt).Italic) And (oFont.Underline = moFnt(iFnt).Underline) And (oFont.Size = moFnt(iFnt).Size) And (oFont.Strikethrough = moFnt(iFnt).Strikethrough) Then
         pAddFontIfRequired = iFnt
         Exit Function
      End If
   Next

   mlFontCount = mlFontCount + 1
   ReDim Preserve moFnt(1 To mlFontCount) As StdFont
   ReDim Preserve mlFnt(1 To mlFontCount) As Long
   Set moFnt(mlFontCount) = New StdFont

   With moFnt(mlFontCount)
      .Name = oFont.Name
      .Size = oFont.Size
      .Bold = oFont.Bold
      .Italic = oFont.Italic
      .Underline = oFont.Underline
      .Strikethrough = oFont.Strikethrough
   End With

   OLEFontToLogFont moFnt(mlFontCount), picContainer.hdc, tULF
   mlFnt(mlFontCount) = CreateFontIndirect(tULF)
   pAddFontIfRequired = mlFontCount

End Function
