object frmNewName: TfrmNewName
  Left = 328
  Top = 216
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #34920#35352#12398#22793#26356
  ClientHeight = 160
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object btnOK: TButton
    Left = 183
    Top = 124
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 264
    Top = 124
    Width = 75
    Height = 25
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 355
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 16
      Width = 65
      Height = 18
      Caption = #29694#22312#12398#34920#31034':'
    end
    object Label2: TLabel
      Left = 20
      Top = 48
      Width = 65
      Height = 18
      Caption = #26032#12375#12356#34920#31034':'
    end
    object edtNew: TEdit
      Left = 96
      Top = 45
      Width = 243
      Height = 26
      TabOrder = 0
    end
    object edtCurrent: TEdit
      Left = 96
      Top = 13
      Width = 243
      Height = 26
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object StaticText1: TStaticText
      Left = 98
      Top = 82
      Width = 232
      Height = 22
      Caption = #8251#22793#26356#12399#12289#27425#22238#12398#12487#12540#12479#21462#24471#26178#12363#12425#26377#21177#12290
      TabOrder = 2
    end
  end
end
