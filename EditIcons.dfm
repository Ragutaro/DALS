object frmEditIcons: TfrmEditIcons
  Left = 313
  Top = 211
  BorderIcons = [biSystemMenu]
  Caption = #12450#12452#12467#12531#12398#35373#23450#65381#32232#38598
  ClientHeight = 264
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 18
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 678
    Height = 264
    ActivePage = tabNew
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 382
    ExplicitHeight = 261
    object tabEdit: TTabSheet
      Caption = #12450#12452#12467#12531#12522#12473#12488#12398#32232#38598#12539#21066#38500
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object splVert: TSplitter
        Left = 191
        Top = 0
        Width = 4
        Height = 231
        ExplicitLeft = 137
        ExplicitHeight = 228
      end
      object lvwList: THideListView
        Left = 0
        Top = 0
        Width = 191
        Height = 231
        Align = alLeft
        Columns = <
          item
            Caption = #35373#23450#20013#12398#12450#12452#12467#12531
            Width = 100
          end
          item
            Alignment = taCenter
            Caption = 'Index'
            Width = 25
          end
          item
            Alignment = taCenter
            Caption = #38542#23652
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        PopupMenu = popTVW
        SmallImages = frmMain.pngTreeView
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lvwListColumnClick
        OnCustomDrawItem = lvwListCustomDrawItem
        OnMouseDown = lvwListMouseDown
        SortOrder = soAscending
        WrapAround = False
        DefaultSortOrder = soAscending
      end
      object Panel1: TPanel
        Left = 195
        Top = 0
        Width = 475
        Height = 231
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel1'
        Color = clWindow
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          475
          231)
        object lvwIcons: THideListView
          Left = 0
          Top = 0
          Width = 475
          Height = 194
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Columns = <>
          LargeImages = frmMain.pngTreeView
          ReadOnly = True
          PopupMenu = popLVW
          TabOrder = 0
          OnCustomDrawItem = lvwIconsCustomDrawItem
          OnDblClick = lvwIconsDblClick
          SortOrder = soAscending
          WrapAround = False
          DefaultSortOrder = soAscending
        end
        object btnEditCancel: TButton
          Left = 394
          Top = 203
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #12461#12515#12531#12475#12523
          TabOrder = 2
          OnClick = btnEditCancelClick
        end
        object btnEditOK: TButton
          Left = 310
          Top = 203
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 1
          OnClick = btnEditOKClick
        end
      end
      object cmbEditLevel: THideComboBox
        Left = 92
        Top = 34
        Width = 85
        Height = 26
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 2
        Visible = False
        OnChange = cmbEditLevelChange
        Items.Strings = (
          #21046#38480#12394#12375'(=0)'
          #12473#12509#12540#12484#31278#30446'(=1)'
          #22823#20250#21517'(=2)'
          #12481#12540#12512#21517'(=3)')
      end
    end
    object tabNew: TTabSheet
      Caption = #12450#12452#12467#12531#12398#35373#23450
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        670
        231)
      object Label1: TLabel
        Left = 2
        Top = 205
        Width = 101
        Height = 18
        Anchors = [akLeft, akBottom]
        Caption = #35373#23450#12377#12427#12486#12461#12473#12488':'
        ExplicitTop = 202
      end
      object Label2: TLabel
        Left = 290
        Top = 205
        Width = 77
        Height = 18
        Anchors = [akLeft, akBottom]
        Caption = #35373#23450#12377#12427#38542#23652':'
        ExplicitTop = 202
      end
      object lvwNew: THideListView
        Left = 0
        Top = 0
        Width = 670
        Height = 196
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <>
        LargeImages = frmMain.pngTreeView
        ReadOnly = True
        PopupMenu = popLVW
        TabOrder = 0
        OnCustomDrawItem = lvwNewCustomDrawItem
        OnDblClick = lvwNewDblClick
        SortOrder = soAscending
        WrapAround = False
        DefaultSortOrder = soAscending
      end
      object btnNewCancel: TButton
        Left = 592
        Top = 203
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #38281#12376#12427
        TabOrder = 2
        OnClick = btnNewCancelClick
      end
      object edtNode: TEdit
        Left = 106
        Top = 202
        Width = 171
        Height = 26
        Anchors = [akLeft, akBottom]
        TabOrder = 1
      end
      object cmbLevel: TComboBox
        Left = 378
        Top = 202
        Width = 165
        Height = 26
        Style = csDropDownList
        Anchors = [akLeft, akBottom]
        TabOrder = 3
        Items.Strings = (
          #21046#38480#12394#12375'(=0)'
          #12473#12509#12540#12484#31278#30446'(=1)'
          #22823#20250#21517'(=2)'
          #12481#12540#12512#21517'(=3)')
      end
      object StaticText1: TStaticText
        Left = 3
        Top = 172
        Width = 244
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #8251#12480#12502#12523#12463#12522#12483#12463#12391#12450#12452#12467#12531#12434#22793#26356#12375#12414#12377#12290
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clSilver
        Font.Height = -12
        Font.Name = #12513#12452#12522#12458
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  object popTVW: TSpTBXPopupMenu
    Images = frmMain.pngToolbar
    Left = 38
    Top = 123
    object popDelete: TSpTBXItem
      Caption = #36984#25246#12450#12452#12486#12512#12434#21066#38500'...'
      ImageIndex = 5
      OnClick = popDeleteClick
    end
  end
  object popLVW: TSpTBXPopupMenu
    Images = frmMain.pngToolbar
    Left = 227
    Top = 47
    object popReloadIcons: TSpTBXItem
      Caption = #12450#12452#12467#12531#12398#20877#35501#12415#36796#12415
      ImageIndex = 2
      OnClick = popReloadIconsClick
    end
  end
end
