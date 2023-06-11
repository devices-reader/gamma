inherited frmConsole: TfrmConsole
  Left = 244
  Top = 227
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1086#1085#1089#1086#1083#1100
  ClientHeight = 231
  ClientWidth = 437
  FormStyle = fsStayOnTop
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 443
  ExplicitHeight = 262
  PixelsPerInch = 120
  TextHeight = 19
  object lblSystem: TLabel
    Left = 10
    Top = 178
    Width = 115
    Height = 19
    Caption = #1089#1080#1089#1090#1077#1084#1072' '#1082#1086#1084#1072#1085#1076
  end
  object memDisplay: TMemo
    Left = 10
    Top = 12
    Width = 287
    Height = 68
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      '0123456789ABCDEF'
      '0123456789ABCDEF')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object btbGetDisplay: TBitBtn
    Left = 10
    Top = 90
    Width = 287
    Height = 30
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1076#1080#1089#1087#1083#1077#1103
    TabOrder = 18
    OnClick = btbGetDisplayClick
  end
  object btbKey1: TBitBtn
    Left = 312
    Top = 12
    Width = 38
    Height = 38
    Caption = '1'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnClick = btbKey1Click
  end
  object btbKey2: TBitBtn
    Left = 350
    Top = 12
    Width = 38
    Height = 38
    Caption = '2'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnClick = btbKey2Click
  end
  object btbKey3: TBitBtn
    Left = 388
    Top = 12
    Width = 38
    Height = 38
    Caption = '3'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnClick = btbKey3Click
  end
  object btbKey4: TBitBtn
    Left = 312
    Top = 50
    Width = 38
    Height = 38
    Caption = '4'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 4
    OnClick = btbKey4Click
  end
  object btbKey5: TBitBtn
    Left = 350
    Top = 50
    Width = 38
    Height = 38
    Caption = '5'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    OnClick = btbKey5Click
  end
  object btbKey6: TBitBtn
    Left = 388
    Top = 50
    Width = 38
    Height = 38
    Caption = '6'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    OnClick = btbKey6Click
  end
  object btbKey7: TBitBtn
    Left = 312
    Top = 88
    Width = 38
    Height = 38
    Caption = '7'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
    OnClick = btbKey7Click
  end
  object btbkey8: TBitBtn
    Left = 350
    Top = 88
    Width = 38
    Height = 38
    Caption = '8'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 8
    OnClick = btbkey8Click
  end
  object btbKey9: TBitBtn
    Left = 388
    Top = 88
    Width = 38
    Height = 38
    Caption = '9'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 9
    OnClick = btbKey9Click
  end
  object btbKeyMinus: TBitBtn
    Left = 312
    Top = 126
    Width = 38
    Height = 38
    Caption = '-'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 10
    OnClick = btbKeyMinusClick
  end
  object btbKey0: TBitBtn
    Left = 350
    Top = 126
    Width = 38
    Height = 38
    Caption = '0'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 11
    OnClick = btbKey0Click
  end
  object btbKeyPoint: TBitBtn
    Left = 388
    Top = 126
    Width = 38
    Height = 38
    Caption = '.'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 12
    OnClick = btbKeyPointClick
  end
  object btbKeyProgram: TBitBtn
    Left = 312
    Top = 164
    Width = 38
    Height = 38
    Caption = 'P'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 13
    OnClick = btbKeyProgramClick
  end
  object btbKeyEnter: TBitBtn
    Left = 350
    Top = 164
    Width = 76
    Height = 38
    Caption = #1042#1074#1086#1076
    ParentShowHint = False
    ShowHint = False
    TabOrder = 14
    OnClick = btbKeyEnterClick
  end
  object edtConsole: TEdit
    Left = 220
    Top = 135
    Width = 56
    Height = 27
    TabOrder = 16
    Text = '500'
  end
  object updConsole: TUpDown
    Left = 276
    Top = 135
    Width = 20
    Height = 27
    Associate = edtConsole
    Min = 50
    Max = 5000
    Increment = 100
    Position = 500
    TabOrder = 17
    Thousands = False
  end
  object chbConsole: TCheckBox
    Left = 10
    Top = 140
    Width = 191
    Height = 20
    Caption = #1095#1080#1090#1072#1090#1100' '#1087#1077#1088#1080#1086#1076#1080#1095#1077#1089#1082#1080
    TabOrder = 15
  end
  object cmbSystem: TComboBox
    Left = 220
    Top = 173
    Width = 77
    Height = 27
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 19
    Text = 'CRC'
    Items.Strings = (
      'Esc'
      'CRC')
  end
  object stbConsole: TStatusBar
    Left = 0
    Top = 212
    Width = 437
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
  end
  object timConsole: TTimer
    Enabled = False
    OnTimer = timConsoleTimer
    Left = 192
  end
end
