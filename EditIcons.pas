unit EditIcons;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.ComCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  PngImageList, HideListView, Vcl.StdCtrls, TB2Item, SpTBXItem, Vcl.Menus,
  HideComboBox;

type
  TfrmEditIcons = class(TForm)
    PageControl: TPageControl;
    tabEdit: TTabSheet;
    tabNew: TTabSheet;
    lvwList: THideListView;
    Panel1: TPanel;
    lvwIcons: THideListView;
    splVert: TSplitter;
    lvwNew: THideListView;
    Label1: TLabel;
    popTVW: TSpTBXPopupMenu;
    popDelete: TSpTBXItem;
    btnEditCancel: TButton;
    btnEditOK: TButton;
    btnNewCancel: TButton;
    popLVW: TSpTBXPopupMenu;
    popReloadIcons: TSpTBXItem;
    edtNode: TEdit;
    Label2: TLabel;
    cmbLevel: TComboBox;
    cmbEditLevel: THideComboBox;
    StaticText1: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lvwIconsDblClick(Sender: TObject);
    procedure popDeleteClick(Sender: TObject);
    procedure btnEditCancelClick(Sender: TObject);
    procedure btnEditOKClick(Sender: TObject);
    procedure btnNewCancelClick(Sender: TObject);
    procedure lvwNewDblClick(Sender: TObject);
    procedure lvwListColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvwListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvwIconsCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvwNewCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure popReloadIconsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvwListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmbEditLevelChange(Sender: TObject);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _LoadIconsToListView;
    procedure _LoadIconsFromIndex;
    procedure _SaveEditIcons;
    procedure _SaveNewIcon;
  public
    { Public 宣言 }
  end;

var
  frmEditIcons: TfrmEditIcons;

implementation

{$R *.dfm}

uses
  HideUtils,
  Main,
  dp;

procedure TfrmEditIcons.btnEditCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditIcons.btnEditOKClick(Sender: TObject);
begin
  _SaveEditIcons;
  Close;
end;

procedure TfrmEditIcons.btnNewCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditIcons.cmbEditLevelChange(Sender: TObject);
var
  item : TListItem;
begin
  item := lvwList.Selected;
  if item <> nil then
  begin
    item.SubItems[1] := IntToStr(cmbEditLevel.ItemIndex);
    cmbEditLevel.Visible := False;
    lvwList.Enabled := True;
  end;
end;

procedure TfrmEditIcons.FormActivate(Sender: TObject);
var
  n : TTreeNode;
begin
  n := frmMain.tvwSports.Selected;
  if n <> nil then
  begin
    edtNode.Text := n.Text;
    cmbLevel.ItemIndex := frmMain.tvwSports.GetNodeLevel(n);
  end;
end;

procedure TfrmEditIcons.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _SaveSettings;
  Release;
  frmEditIcons := nil;   //フォーム名に変更する
end;

procedure TfrmEditIcons.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
  _LoadIconsToListView;
  _LoadIconsFromIndex;
end;

procedure TfrmEditIcons.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmEditIcons.lvwIconsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvwIcons.SetHoverStyle(State, DefaultDraw);
end;

procedure TfrmEditIcons.lvwIconsDblClick(Sender: TObject);
var
  item : TListItem;
begin
  item := lvwIcons.Selected;
  if item <> nil then
  begin
    if item.ImageIndex <> 0 then
    begin
    	lvwList.Selected.ImageIndex := item.ImageIndex;
      lvwList.Selected.SubItems[0] := IntToStr(item.ImageIndex);
    end;
  end;
end;

procedure TfrmEditIcons.lvwListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  Case Column.Index of
    0 : lvwList.ColumnClickEx(Column, True);
    1 : lvwList.ColumnClickEx(Column, False);
    2 : lvwList.ColumnClickEx(Column, False);
  end;
end;

procedure TfrmEditIcons.lvwListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvwList.SetHoverStyle(State, DefaultDraw);
end;

procedure TfrmEditIcons.lvwListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  item : TListItem;
  iLeft : Integer;
begin
  item :=lvwList.GetItemAt(x, y);
  if item <> nil then
  begin
    iLeft := lvwList.Column[0].Width + lvwList.Column[1].Width;
    if x > iLeft then
    begin
      cmbEditLevel.Left := iLeft+1;
      cmbEditLevel.Top := item.Top+2;
      cmbEditLevel.Width := lvwList.Column[2].Width+1;
      cmbEditLevel.ItemIndex := StrToInt(item.SubItems[1]);
      cmbEditLevel.Visible := True;
      lvwList.Enabled := False;
      cmbEditLevel.DroppedDown := True;
    end
    else
    begin
      cmbEditLevel.Visible := False;
      lvwList.Enabled := True;
    end;
  end;
end;

procedure TfrmEditIcons.lvwNewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvwNew.SetHoverStyle(State, DefaultDraw);
end;

procedure TfrmEditIcons.lvwNewDblClick(Sender: TObject);
begin
  _SaveNewIcon;
end;

procedure TfrmEditIcons.popDeleteClick(Sender: TObject);
begin
  if MessageDlg('削除します。よろしいですか?', '削除の確認', mtConfirmation, [mbYes, mbNo]) = mrYes then
    lvwList.DeleteAllSelectedItems;
end;

procedure TfrmEditIcons.popReloadIconsClick(Sender: TObject);
var
  i : Integer;
  sFile : String;
begin
  frmMain.pngTreeView.Clear;
  for i := 0 to 500 do
  begin
    sFile := Format('%simages\%d.png', [GetApplicationPath, i]);
    if FileExists(sFile) then
      frmMain.pngTreeView.PngImages.Add.PngImage.LoadFromFile(sFile)
    else
    begin
    	sFile := Format('%simages\%d.png', [GetApplicationPath, i-1]);
      frmMain.pngTreeView.PngImages.Add.PngImage.LoadFromFile(sFile);
      Break;
    end;
  end;
  _LoadIconsToListView;
end;

procedure TfrmEditIcons._LoadIconsFromIndex;
var
  item : TListItem;
  sl : TStringList;
  i : Integer;
  s1, s2, sIndex, sLevel : String;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(av.sFILE_ICONINDEX, TEncoding.UTF8);
    for i := 0 to sl.Count-1 do
    begin
      if Pos('=', sl[i]) > 0 then
      begin
        SplitStringsToAandB(sl[i], '=', s1, s2);
        SplitStringsToAandB(s2, ',', sIndex, sLevel);
        item := lvwList.Items.Add;
        item.Caption := s1;
        item.SubItems.Add(sIndex);
        item.SubItems.Add(sLevel);
        item.ImageIndex := StrToInt(sIndex);
      end;
    end;
  finally
    sl.Free;
  end;
  lvwList.SelectFirstItem;
end;

procedure TfrmEditIcons._LoadIconsToListView;
var
  item : TListItem;
  i : Integer;
begin
  lvwIcons.Items.BeginUpdate;
  lvwIcons.Items.Clear;
  lvwNew.Items.BeginUpdate;
  lvwNew.Items.Clear;
  try
    for i := 0 to frmMain.pngTreeView.Count-1 do
    begin
      item := lvwIcons.Items.Add;
      item.Caption := IntToStr(i);
      item.ImageIndex := i;
      item := lvwNew.Items.Add;
      item.Caption := IntToStr(i);
      item.ImageIndex := i;
    end;
  finally
    lvwIcons.Items.EndUpdate;
    lvwNew.Items.EndUpdate;
  end;
end;

procedure TfrmEditIcons._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindowPosition(Self.Name, Self);
    lvwList.Width := ini.ReadInteger(Self.Name, 'lvwList.Width', lvwList.Width);
    lvwList.Column[0].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    lvwList.Column[1].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    lvwList.Column[2].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[2].Width', lvwList.Column[2].Width);
    Self.Font.Name := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size := ini.ReadInteger('General', 'FontSize', 10);
  finally
    ini.Free;
  end;
  lvwIcons.IconOptions.AutoArrange := True;
  lvwNew.IconOptions.AutoArrange := True;
end;

procedure TfrmEditIcons._SaveEditIcons;
var
  item : TListItem;
  sl : TStringList;
  i : Integer;
begin
  sl := TStringList.Create;
  try
    sl.Add('[Index]');
    for i := 0 to lvwList.Items.Count-1 do
    begin
    	item := lvwList.Items[i];
      sl.Add(Format('%s=%s,%s', [item.Caption, item.SubItems[0], item.SubItems[1]]));
    end;
    sl.SaveToFile(av.sFILE_ICONINDEX, TEncoding.UTF8);
  finally
    sl.Free;
  end;
end;

procedure TfrmEditIcons._SaveNewIcon;
var
  n : TTreeNode;
  item : TListItem;
  sl : TStringList;
  idx : Integer;
begin
  n := frmMain.tvwSports.Selected;
  item := lvwNew.Selected;
  if (n <> nil) and (item <> nil) then
  begin
    if ((n.ImageIndex = 0) and (item.ImageIndex = 0)) or
       ((n.ImageIndex <> 0) and (item.ImageIndex <> 0)) then
    begin
      idx := item.ImageIndex;
      //編集後のテキストがNode.Textに含まれている場合のみ、
      //TreeViewのアイコンを変更する
      if ContainsText(n.Text, Trim(edtNode.Text)) then
      begin
      	n.ImageIndex := idx;
        n.SelectedIndex := idx;
      end;
      sl := TStringList.Create;
      try
        sl.LoadFromFile(av.sFILE_ICONINDEX, TEncoding.UTF8);
        sl.Add(Format('%s=%d,%d', [Trim(edtNode.Text), idx, cmbLevel.ItemIndex]));
        sl.SaveToFile(av.sFILE_ICONINDEX, TEncoding.UTF8);
      finally
        sl.Free;
      end;
    end;
  end;
end;

procedure TfrmEditIcons._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindowPosition(Self.Name, Self);
    ini.WriteInteger(Self.Name, 'lvwList.Width', lvwList.Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[2].Width', lvwList.Column[2].Width);
    ini.WriteString('General', 'FontName', Self.Font.Name);
    ini.WriteInteger('General', 'FontSize', Self.Font.Size);
  finally
    ini.UpdateFile;
    ini.Free;
  end;
end;

end.
