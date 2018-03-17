object frmEditNameList: TfrmEditNameList
  Left = 331
  Top = 164
  BorderIcons = [biSystemMenu]
  Caption = #34920#35352#12398#32232#38598#12539#21066#38500
  ClientHeight = 258
  ClientWidth = 515
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
    515
    258)
  PixelsPerInch = 96
  TextHeight = 18
  object lvwList: THideListView
    Left = 0
    Top = 0
    Width = 515
    Height = 215
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'DAZN'#12398#34920#35352
        Width = 200
      end
      item
        Caption = 'DALS'#12391#12398#34920#35352
        Width = 200
      end>
    HideSelection = False
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = popLvw
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvwListColumnClick
    OnCustomDrawItem = lvwListCustomDrawItem
    OnDblClick = lvwListDblClick
    SortOrder = soAscending
    WrapAround = False
    DefaultSortOrder = soAscending
    HoverColor = 16774117
    HoverFontColor = clTeal
    UnevenColor = 16710392
  end
  object btnOK: TButton
    Left = 346
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 432
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object panEditItem: TPanel
    Left = 110
    Top = 37
    Width = 400
    Height = 174
    Anchors = [akRight, akBottom]
    TabOrder = 3
    Visible = False
    object Label1: TLabel
      Left = 22
      Top = 28
      Width = 75
      Height = 18
      Caption = 'DAZN'#12398#34920#35352':'
    end
    object Label2: TLabel
      Left = 22
      Top = 70
      Width = 85
      Height = 18
      Caption = 'DALS'#12391#12398#34920#35352':'
    end
    object Shape1: TShape
      Left = 14
      Top = 128
      Width = 373
      Height = 1
    end
    object Label3: TLabel
      Left = 121
      Top = 99
      Width = 180
      Height = 18
      Caption = #8251#22793#26356#12399#12289#27425#22238#21462#24471#26178#12363#12425#26377#21177#12290
    end
    object edtBefore: TEdit
      Left = 120
      Top = 26
      Width = 269
      Height = 26
      Enabled = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object edtAfter: TEdit
      Left = 121
      Top = 67
      Width = 268
      Height = 26
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btnEditOK: TButton
      Left = 120
      Top = 140
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 2
      OnClick = btnEditOKClick
    end
    object btnEditCancel: TButton
      Left = 204
      Top = 140
      Width = 75
      Height = 25
      Caption = #12461#12515#12531#12475#12523
      TabOrder = 3
      OnClick = btnEditCancelClick
    end
  end
  object popLvw: TSpTBXPopupMenu
    Images = frmMain.pngToolbar
    Left = 42
    Top = 40
    object popCopyDALS: TSpTBXItem
      Caption = 'DALS'#12391#12398#34920#35352#12434#12467#12500#12540
      ImageIndex = 16
      OnClick = popCopyDALSClick
    end
    object popEdit: TSpTBXItem
      Caption = #32232#38598'...'
      ImageIndex = 13
      OnClick = popEditClick
    end
    object popDelete: TSpTBXItem
      Caption = #36984#25246#12450#12452#12486#12512#12434#21066#38500'...'
      ImageIndex = 5
      OnClick = popDeleteClick
    end
  end
end
