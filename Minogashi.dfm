object frmMinogashi: TfrmMinogashi
  Left = 341
  Top = 612
  BorderIcons = [biSystemMenu]
  Caption = #35211#36867#12375#37197#20449
  ClientHeight = 191
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 18
  object lvwList: THideListView
    Left = 0
    Top = 34
    Width = 322
    Height = 157
    Align = alClient
    Columns = <
      item
        Caption = #35430#21512#38283#22987#26178#38291
      end
      item
        Caption = #22823#20250#21517
      end
      item
        Caption = #23550#25126#12459#12540#12489
      end
      item
        Caption = #23455#27841#12539#35299#35500
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    GroupHeaderImages = frmMain.pngTreeView
    GroupView = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvwListColumnClick
    OnCustomDrawItem = lvwListCustomDrawItem
    OnCreateItemClass = lvwListCreateItemClass
    SortOrder = soAscending
    WrapAround = False
    DefaultSortOrder = soAscending
    HoverColor = 16774117
    HoverFontColor = clTeal
    UnevenColor = 16710392
  end
  object SpTBXDock: TSpTBXDock
    Left = 0
    Top = 0
    Width = 322
    Height = 34
    object tbxToolbar: TSpTBXToolWindow
      Left = 0
      Top = 0
      Caption = 'tbxToolbar'
      BorderStyle = bsNone
      DockMode = dmCannotFloat
      DockPos = 0
      TabOrder = 0
      ClientAreaHeight = 30
      ClientAreaWidth = 451
      object HideLabel1: THideLabel
        Left = 6
        Top = 6
        Width = 29
        Height = 18
        Autosize = False
        Caption = #26908#32034':'
        Transparent = True
      end
      object edtSearch: TEdit
        Left = 41
        Top = 1
        Width = 164
        Height = 26
        TabOrder = 0
        OnKeyPress = edtSearchKeyPress
        OnKeyUp = edtSearchKeyUp
      end
    end
  end
end
