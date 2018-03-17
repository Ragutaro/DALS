object frmOption: TfrmOption
  Left = 324
  Top = 150
  BorderStyle = bsDialog
  Caption = #12458#12503#12471#12519#12531#35373#23450
  ClientHeight = 431
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    384
    431)
  PixelsPerInch = 96
  TextHeight = 18
  object Label4: TLabel
    Left = 14
    Top = 260
    Width = 207
    Height = 18
    Caption = #30058#32068#34920#21462#24471#26178#12398#12479#12452#12512#12450#12454#12488#26178#38291'('#31186'):'
  end
  object Label5: TLabel
    Left = 14
    Top = 362
    Width = 41
    Height = 18
    Caption = #36890#30693#38899':'
  end
  object Label6: TLabel
    Left = 14
    Top = 294
    Width = 231
    Height = 18
    Caption = #12481#12455#12483#12463#12375#12383#30058#32068#12398#38283#22987#21069#12395#30693#12425#12379#12427'('#20998'):'
  end
  object Label7: TLabel
    Left = 14
    Top = 327
    Width = 243
    Height = 18
    Caption = #12521#12452#12502#37197#20449#32066#20102#24460#12395#12522#12473#12488#12395#27531#12377#26178#38291'('#26178#38291'):'
  end
  object Label8: TLabel
    Left = 14
    Top = 228
    Width = 125
    Height = 18
    Caption = #30058#32068#34920#12434#21462#24471#12377#12427#26178#38291':'
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 8
    Width = 370
    Height = 93
    Caption = #26178#21051#21512#12431#12379
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 53
      Width = 77
      Height = 18
      Caption = 'NTP'#12507#12473#12488#21517':'
    end
    object chkEnableSNTP: TCheckBox
      Left = 16
      Top = 24
      Width = 183
      Height = 17
      Caption = #26178#21051#21512#12431#12379#12434#26377#21177#12395#12377#12427#12290
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object edtSNTP: TEdit
      Left = 99
      Top = 50
      Width = 260
      Height = 26
      TabOrder = 1
      Text = 'ntp.jst.mfeed.ad.jp'
    end
  end
  object btnOK: TButton
    Left = 117
    Top = 398
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'OK'
    TabOrder = 7
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 200
    Top = 398
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 8
    OnClick = btnCancelClick
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 110
    Width = 370
    Height = 103
    Caption = #12501#12457#12531#12488
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 28
      Width = 65
      Height = 18
      Caption = #12501#12457#12531#12488#21517':'
    end
    object Label3: TLabel
      Left = 16
      Top = 60
      Width = 63
      Height = 18
      Caption = #12469#12452#12474'(pt):'
    end
    object cmbFont: TSpTBXFontComboBox
      Left = 99
      Top = 22
      Width = 260
      Height = 26
      ItemHeight = 23
      TabOrder = 0
    end
    object edtFontSize: TEdit
      Left = 99
      Top = 60
      Width = 52
      Height = 26
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 1
      Text = '10'
    end
  end
  object edtTimeout: TEdit
    Left = 329
    Top = 257
    Width = 47
    Height = 26
    Alignment = taCenter
    HideSelection = False
    NumbersOnly = True
    TabOrder = 3
    Text = '20'
  end
  object edtSound: TButtonedEdit
    Left = 68
    Top = 359
    Width = 308
    Height = 26
    Images = frmMain.pngListView
    RightButton.HotImageIndex = 3
    RightButton.ImageIndex = 2
    RightButton.PressedImageIndex = 3
    RightButton.Visible = True
    TabOrder = 6
    OnRightButtonClick = edtSoundRightButtonClick
  end
  object edtInform: TEdit
    Left = 329
    Top = 291
    Width = 47
    Height = 26
    Alignment = taCenter
    HideSelection = False
    NumbersOnly = True
    TabOrder = 4
    Text = '10'
  end
  object edtDelTime: TEdit
    Left = 329
    Top = 324
    Width = 47
    Height = 26
    Alignment = taCenter
    HideSelection = False
    NumbersOnly = True
    TabOrder = 5
    Text = '10'
  end
  object edtGetData: THideEditW
    Left = 154
    Top = 225
    Width = 222
    Height = 26
    Hint = #20837#21147#21487#33021':0123456789:;'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '09:00;20:00;'
    UAlignment = taLeftJustify
    UEnableChar = '0123456789:;'
  end
  object OpenDialog: TOpenDialog
    Left = 324
    Top = 166
  end
end
