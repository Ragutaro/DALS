object frmEditFavorites: TfrmEditFavorites
  Left = 329
  Top = 362
  BorderIcons = [biSystemMenu]
  Caption = #12362#27671#12395#20837#12426#12398#32232#38598
  ClientHeight = 149
  ClientWidth = 338
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
    338
    149)
  PixelsPerInch = 96
  TextHeight = 18
  object lstList: THideListBox
    Left = 0
    Top = 0
    Width = 294
    Height = 149
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 18
    TabOrder = 0
  end
  object SpTBXToolWindow1: TSpTBXToolWindow
    Left = 300
    Top = 4
    Width = 34
    Height = 63
    Caption = 'SpTBXToolWindow1'
    Anchors = [akTop, akRight]
    TabOrder = 1
    ClientAreaHeight = 63
    ClientAreaWidth = 34
    object SpTBXToolbar1: TSpTBXToolbar
      Left = 0
      Top = 0
      Width = 34
      Height = 63
      Align = alClient
      BorderStyle = bsNone
      CloseButton = False
      FullSize = True
      Images = frmMain.pngToolbar
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      Caption = 'SpTBXToolbar1'
      Customizable = False
      MenuBar = True
      object btnDelete: TSpTBXItem
        Caption = #21066#38500
        Hint = #21066#38500
        ImageIndex = 5
        OnClick = btnDeleteClick
      end
      object btnSave: TSpTBXItem
        Caption = #20445#23384
        Hint = #20445#23384
        ImageIndex = 6
        OnClick = btnSaveClick
      end
    end
  end
  object SpTBXToolWindow2: TSpTBXToolWindow
    Left = 300
    Top = 80
    Width = 34
    Height = 61
    Caption = 'SpTBXToolWindow1'
    Anchors = [akRight, akBottom]
    TabOrder = 2
    ClientAreaHeight = 61
    ClientAreaWidth = 34
    object SpTBXToolbar2: TSpTBXToolbar
      Left = 0
      Top = 0
      Width = 34
      Height = 61
      Align = alClient
      BorderStyle = bsNone
      CloseButton = False
      FullSize = True
      Images = frmMain.pngToolbar
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      Caption = 'SpTBXToolbar1'
      Customizable = False
      MenuBar = True
      object btnUp: TSpTBXItem
        Caption = #19978#12370#12427
        Hint = #19978#12370#12427
        ImageIndex = 7
        OnClick = btnUpClick
      end
      object btnDown: TSpTBXItem
        Caption = #19979#12370#12427
        Hint = #19979#12370#12427
        ImageIndex = 8
        OnClick = btnDownClick
      end
    end
  end
end
