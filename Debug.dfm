object frmDebug: TfrmDebug
  Left = 320
  Top = 120
  BorderIcons = [biSystemMenu]
  Caption = 'Debug'
  ClientHeight = 200
  ClientWidth = 400
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
  object Splitter1: TSplitter
    Left = 0
    Top = 127
    Width = 400
    Height = 4
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 129
  end
  object lvwList: THideListView
    Left = 0
    Top = 131
    Width = 400
    Height = 69
    Align = alClient
    Columns = <>
    TabOrder = 0
    SortOrder = soAscending
    WrapAround = False
    DefaultSortOrder = soAscending
  end
  object lstDebug: THideListBox
    Left = 0
    Top = 0
    Width = 400
    Height = 127
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 18
    TabOrder = 1
  end
end
