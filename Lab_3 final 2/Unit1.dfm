object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RSA'
  ClientHeight = 432
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbP: TLabel
    Left = 18
    Top = 19
    Width = 72
    Height = 16
    Caption = #1042#1074#1077#1076#1080#1090#1077' p:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbQ: TLabel
    Left = 18
    Top = 59
    Width = 72
    Height = 16
    Caption = #1042#1074#1077#1076#1080#1090#1077' q:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbR: TLabel
    Left = 314
    Top = 19
    Width = 25
    Height = 16
    Caption = 'r = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbEuler: TLabel
    Left = 291
    Top = 59
    Width = 48
    Height = 16
    Caption = #966'(r) = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbD: TLabel
    Left = 18
    Top = 99
    Width = 72
    Height = 16
    Caption = #1042#1074#1077#1076#1080#1090#1077' d:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbE: TLabel
    Left = 312
    Top = 99
    Width = 27
    Height = 16
    Caption = 'e = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbPublicKey: TLabel
    Left = 490
    Top = 19
    Width = 114
    Height = 16
    Caption = #1054#1090#1082#1088#1099#1090#1099#1081' '#1082#1083#1102#1095':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbPrivateKey: TLabel
    Left = 490
    Top = 59
    Width = 114
    Height = 16
    Caption = #1047#1072#1082#1088#1099#1090#1099#1081' '#1082#1083#1102#1095':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbM: TLabel
    Left = 68
    Top = 206
    Width = 30
    Height = 16
    Caption = 'm = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbS: TLabel
    Left = 71
    Top = 244
    Width = 27
    Height = 16
    Caption = 'S = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbM2: TLabel
    Left = 345
    Top = 206
    Width = 30
    Height = 16
    Caption = 'm'#39' ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object edtP: TEdit
    Left = 112
    Top = 16
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtPKeyPress
  end
  object btConfirm: TButton
    Left = 112
    Top = 144
    Width = 121
    Height = 33
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btConfirmClick
  end
  object edtQ: TEdit
    Left = 112
    Top = 56
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnKeyPress = edtQKeyPress
  end
  object edtR: TEdit
    Left = 345
    Top = 16
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtEuler: TEdit
    Left = 345
    Top = 56
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtD: TEdit
    Left = 112
    Top = 96
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnKeyPress = edtDKeyPress
  end
  object edtE: TEdit
    Left = 345
    Top = 96
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object edtPublicKey: TEdit
    Left = 610
    Top = 16
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object edtPrivateKey: TEdit
    Left = 610
    Top = 56
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object btnSignature: TButton
    Left = 345
    Top = 144
    Width = 121
    Height = 33
    Caption = #1055#1086#1076#1087#1080#1089#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnSignatureClick
  end
  object edtM: TEdit
    Left = 112
    Top = 203
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Visible = False
  end
  object edtS: TEdit
    Left = 112
    Top = 241
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object btnCheck: TButton
    Left = 490
    Top = 144
    Width = 121
    Height = 33
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = btnCheckClick
  end
  object edtM2: TEdit
    Left = 381
    Top = 203
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object mmRes: TMemo
    Left = 345
    Top = 233
    Width = 266
    Height = 89
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    Visible = False
  end
  object OpenDialog: TOpenDialog
    Left = 496
    Top = 96
  end
  object SaveDialog1: TSaveDialog
    Left = 544
    Top = 96
  end
end
