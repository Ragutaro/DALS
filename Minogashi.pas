unit Minogashi;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.ComCtrls, HideListView, Vcl.StdCtrls, HideLabel, TB2Dock,
  SpTBXItem, WinAPI.imm, HideTreeView;

type
  TListItemEx = class(TListItem)
  public
    iItemIndexInGroup : Integer;
  end;

  TfrmMinogashi = class(TForm)
    lvwList: THideListView;
    SpTBXDock: TSpTBXDock;
    tbxToolbar: TSpTBXToolWindow;
    HideLabel1: THideLabel;
    edtSearch: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lvwListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvwListColumnClick(Sender: TObject; Column: TListColumn);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure lvwListCreateItemClass(Sender: TCustomListView;
      var ItemClass: TListItemClass);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _LoadMinogashi(const sSubStr: String);
  public
    { Public 宣言 }
  end;

var
  frmMinogashi: TfrmMinogashi;

implementation

{$R *.dfm}

uses
  Main,
  HideUtils,
  SearchUtils,
  dp;

type
  TGroupCount = record
  private
    ItemCount : Integer;
  end;

var
  gc : array of TGroupCount;

procedure TfrmMinogashi.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    Char(VK_RETURN) :
      begin
        Key := Char(0);
        _LoadMinogashi(Trim(edtSearch.Text));
      end;
  end;
end;

procedure TfrmMinogashi.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  hI: HIMC;
begin
  hI := ImmGetContext(Handle);
  try
    if (edtSearch.Text = '') and (Not ImmGetOpenStatus(hI)) then
    _LoadMinogashi('');
  finally
    ImmReleaseContext(Handle, hI);
  end;
end;

procedure TfrmMinogashi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _SaveSettings;
  Release;
  frmMinogashi := nil;   //フォーム名に変更する
end;

procedure TfrmMinogashi.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
  _LoadMinogashi('');
end;

procedure TfrmMinogashi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmMinogashi.lvwListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  lvwList.ColumnClickEx(Column, True);
end;

procedure TfrmMinogashi.lvwListCreateItemClass(Sender: TCustomListView;
  var ItemClass: TListItemClass);
begin
  ItemClass := TListItemEx;
end;

procedure TfrmMinogashi.lvwListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  DefaultDraw := True;
  with lvwList.Canvas do
  begin
    Brush.Style := bsSolid;
    if cdsHot in State then
    begin
      Brush.Style := bsSolid;
      Brush.Color := clHover;
      Font.Style  := [fsUnderline];
      Font.Color  := clRed;
    end;
  end;
end;

procedure TfrmMinogashi._LoadMinogashi(const sSubStr: String);
var
  ini, iniCat : TMemIniFile;
  sl, sm : TStringList;
  slGroup : TStringList;
  gr : TListGroup;
  item : TListItemEx;
  i : Integer;
  sTmp, s1, s2 : String;
  bExpanded : Boolean;
  n : TTreeNode;
begin
  ini := TMemIniFile.Create(av.sFILE_ICONINDEX, TEncoding.UTF8);
  iniCat := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  sl := TStringList.Create;
  sm := TStringList.Create;
  slGroup := TStringList.Create;
  lvwList.Items.BeginUpdate;
  lvwList.Items.Clear;
  lvwList.Groups.BeginUpdate;
  lvwList.Groups.Clear;
  SetLength(gc, 0);
  try
    sl.LoadFromFile(av.sFILE_MINOGASHI, TEncoding.UTF8);
    //まずは、配信期限が過ぎた番組を削除する
    for i := sl.Count-1 downto 0 do
    begin
      sTmp := LeftStr(sl[i], 10);
      if IncMonth(StrToDate(sTmp), 1) < Now then
        sl.Delete(i);
    end;
    sl.SaveToFile(av.sFILE_MINOGASHI, TEncoding.UTF8);

    //グループのリストを作成する - スポーツ名
    for i := 0 to sl.Count-1 do
    begin
      sm.CommaText := sl[i];
      if slGroup.IndexOf(sm[3]) = -1 then
        slGroup.Add(sm[3]);
    end;
    slGroup.Sort;
    //グループヘッダーを作成する
    for i := 0 to slGroup.Count-1 do
    begin
      bExpanded := iniCat.ReadBool('Category', slGroup[i], True);
      gr := lvwList.Groups.Add;
      gr.Header := slGroup[i];
      if bExpanded then
        gr.State := [lgsNormal, lgsCollapsible]
      else
        gr.State := [lgsCollapsed, lgsCollapsible];
      gr.GroupID := i;
      n := frmMain.tvwSports.GetChildNode(frmMain.tvwSports.Items[0], slGroup[i]);
      if n <> nil then
        gr.TitleImage := n.ImageIndex
      else
      begin
        sTmp := ini.ReadString('index', slGroup[i], '4,1');
        SplitStringsToAandB(sTmp, ',', s1, s2);
        gr.TitleImage := StrToInt(s1);
      end;
    end;
    //グループ所属のアイテム数を保存する構造体を設定する
    SetLength(gc, slGroup.Count);
    //アイテムを追加していく
    for i := 0 to sl.Count-1 do
    begin
      if SearchStrings(sl[i], sSubStr, True, True) then
      begin
        sm.CommaText := sl[i];
        item := TListItemEx(lvwList.Items.Add);
        item.Caption := Format('%s(%s) %s', [sm[0], sm[1], sm[2]]);
        item.SubItems.Add(sm[4]);
        item.SubItems.Add(sm[5]);
        item.SubItems.Add(sm[6]);
        item.GroupID := slGroup.IndexOf(sm[3]);
        gc[item.GroupID].ItemCount := gc[item.GroupID].ItemCount + 1;
      end;
    end;
    //グループのアイテム数を設定する
    for i := 0 to Length(gc)-1 do
    begin
      lvwList.Groups[i].Subtitle := '見逃し配信数:' + IntToStr(gc[i].ItemCount);
    end;
  finally
    ini.Free;
    iniCat.Free;
    sl.Free;
    sm.Free;
    slGroup.Free;
    lvwList.Groups.EndUpdate;
    lvwList.Items.EndUpdate;
  end;
end;

procedure TfrmMinogashi._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindowPosition(Self.Name, Self);
    lvwList.Column[0].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[0].Width', 100);
    lvwList.Column[1].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[1].Width', 100);
    lvwList.Column[2].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[2].Width', 100);
    lvwList.Column[3].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[3].Width', 100);
    tbxToolbar.DockPos      := ini.ReadInteger(Self.Name, 'tbxToolbar.DockPos', tbxToolbar.DockPos);
    tbxToolbar.DockRow      := ini.ReadInteger(Self.Name, 'tbxToolbar.DockRow', tbxToolbar.DockRow);
    Self.Font.Name          := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size          := ini.ReadInteger('General', 'FontSize', 10);
  finally
    ini.Free;
  end;
end;

procedure TfrmMinogashi._SaveSettings;
var
  ini : TMemIniFile;
  i : Integer;
  bExpanded : Boolean;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindowPosition(Self.Name, Self);
    ini.WriteInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[2].Width', lvwList.Column[2].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[3].Width', lvwList.Column[3].Width);
    ini.WriteInteger(Self.Name, 'tbxToolbar.DockPos', tbxToolbar.DockPos);
    ini.WriteInteger(Self.Name, 'tbxToolbar.DockRow', tbxToolbar.DockRow);
    for i := 0 to lvwList.Groups.Count-1 do
    begin
      if lgsCollapsed in lvwList.Groups[i].State then
        bExpanded := False
      else
        bExpanded := True;
      ini.WriteBool('Category', lvwList.Groups[i].Header, bExpanded);
    end;
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

end.
