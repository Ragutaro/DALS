unit Main;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  HideListView, TB2Item, SpTBXItem, TB2Dock, TB2Toolbar, HideLabel, HideComboBox, Vcl.AppEvnts,
  HideTreeView, PngImageList, System.ImageList, Vcl.ImgList, Vcl.Menus, PngImage, Winapi.Imm,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdSNTP, MSXML, ComObj, ActiveX;

type
  TListItemEx = class(TListItem)
  public
    sFullDateTime : String;
  end;
  TfrmMain = class(TForm)
    panLeft: TPanel;
    splVert: TSplitter;
    panRight: TPanel;
    lvwList: THideListView;
    timOnAir: TTimer;
    panInfo: TPanel;
    TrayIcon1: TTrayIcon;
    tvwSports: THideTreeView;
    pngListView: TPngImageList;
    pngToolbar: TPngImageList;
    pngTreeView: TPngImageList;
    popTreeView: TSpTBXPopupMenu;
    popSetFavorite: TSpTBXItem;
    pngList: TPngImageList;
    popReload: TSpTBXItem;
    SpTBXDock1: TSpTBXDock;
    tbxToolbar1: TSpTBXToolbar;
    tbrGetData: TSpTBXItem;
    tbxToolbar2: TSpTBXToolWindow;
    HideLabel1: THideLabel;
    edtSearch: TEdit;
    tbxToolbar3: TSpTBXToolWindow;
    lblItemCount: TLabel;
    tbrVersion: TSpTBXItem;
    ApplicationEvents: TApplicationEvents;
    tbrMinogashi: TSpTBXItem;
    lblUpdated: TLabel;
    popFavorite: TSpTBXPopupMenu;
    tbrFavorites: TSpTBXItem;
    SpTBXItem1: TSpTBXItem;
    tbrEditFavorites: TSpTBXItem;
    popSyncTime: TSpTBXItem;
    sntp: TIdSNTP;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbrOption: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    timFailed: TTimer;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    popRename: TSpTBXItem;
    tbrEditName: TSpTBXItem;
    tbrChangeName: TSpTBXItem;
    popSetIcon: TSpTBXItem;
    tbrSetIcon: TSpTBXItem;
    tbrEditIcons: TSpTBXItem;
    pngHeader: TPngImageList;
    tbrShowDAZN: TSpTBXItem;
    tbrDebug: TSpTBXItem;
    popLVW: TSpTBXPopupMenu;
    popLvwCheckDelete: TSpTBXItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lvwListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvwListDblClick(Sender: TObject);
    procedure timOnAirTimer(Sender: TObject);
    procedure lvwListCreateItemClass(Sender: TCustomListView;
      var ItemClass: TListItemClass);
    procedure tbrGetDataClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure tvwSportsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvwSportsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure popSetFavoriteClick(Sender: TObject);
    procedure popReloadClick(Sender: TObject);
    procedure tbrVersionClick(Sender: TObject);
    procedure tvwSportsClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure ApplicationEventsRestore(Sender: TObject);
    procedure tbrMinogashiClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbrFavoritesClick(Sender: TObject);
    procedure popFavoritePopup(Sender: TObject);
    procedure tbrEditFavoritesClick(Sender: TObject);
    procedure popSyncTimeClick(Sender: TObject);
    procedure tbrOptionClick(Sender: TObject);
    procedure popTreeViewPopup(Sender: TObject);
    procedure timFailedTimer(Sender: TObject);
    procedure popRenameClick(Sender: TObject);
    procedure tbrChangeNameClick(Sender: TObject);
    procedure tbrEditNameClick(Sender: TObject);
    procedure popSetIconClick(Sender: TObject);
    procedure tbrSetIconClick(Sender: TObject);
    procedure tbrEditIconsClick(Sender: TObject);
    procedure tbrShowDAZNClick(Sender: TObject);
    procedure tbrDebugClick(Sender: TObject);
    procedure lvwListClick(Sender: TObject);
    procedure popLvwCheckDeleteClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _CreateTimeTable(s: String);
    procedure _CheckIsOnAir;
    procedure _SaveCheckList(item: TListItem);
    procedure _LoadCheckList;
    procedure _CreateTreeView;
    procedure _LoadFromFile;
    procedure _CreateSportsImages;
    function _SetImageIndex(sDate, sWeekname: String): Integer;
    procedure _SearchGame(SubStr: String);
    procedure _SelectFavorite(Sender: TObject);
    procedure _SyncTime;
//    procedure _SaveDownlodedHtml(s: String);
    procedure _ChangeToolbarStatus;
    procedure _DPStr(sMessage: String);
    procedure _SaveTreeViewStatus;
    procedure _LoadTreeViewStatus;
    procedure _LoadTreeViewIcons;
    procedure _DeleteNoChildNodes;
    function _DownloadData(sl: TStringList): Boolean;
  public
    { Public 宣言 }
  end;

  TApplicationValues = record
    sFILE_LIVESCHEDULE, sFILE_CHECKLIST, sFILE_TREEVIEW, sFILE_MINOGASHI, sFILE_CONVERTLIST : String;
    sFILE_ICONINDEX, sFavorite, sCurrentText, sCurrentParentText : String;
    sSNTPHost, sSound, sDownloadTime : String;
    bSNTPEnabled, bDebugMode : Boolean;
    iInformTime, iDeletionTime : Integer;
  end;

var
  frmMain: TfrmMain;
  av : TApplicationValues;
  SL_CHECKLIST : TStringList;

implementation

{$R *.dfm}

uses
  HideUtils,
  msHtml,
  DateUtils,
  Info,
  Holidays,
  untVersion,
  version,
  Minogashi,
  SearchUtils,
  EditFavorites,
  Option,
  NewName,
  EditNameList,
  EditIcons,
  Debug,
  dp;

const
  ICO_ROOT = 0;
  ICO_COMPE = 2;
  ICO_TEAM = 3;

procedure TfrmMain.ApplicationEventsMinimize(Sender: TObject);
begin
//  TrayIcon1.Visible := True;
//  Self.Visible := False;
  TrayIcon1.Visible := True;
  Hide;
  Self.WindowState := wsMinimized;
end;

procedure TfrmMain.ApplicationEventsRestore(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Self.Visible := True;
  BringToFront;
end;

procedure TfrmMain.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    Char(VK_RETURN) :
      begin
        Key := Char(0);
        _SearchGame(Trim(edtSearch.Text));
      end;
  end;
end;

procedure TfrmMain.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  hI: HIMC;
begin
  hI := ImmGetContext(Handle);
  try
    if (edtSearch.Text = '') and (Not ImmGetOpenStatus(hI)) then
      _SearchGame('');
  finally
    ImmReleaseContext(Handle, hI);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SL_CHECKLIST.Free;
  _SaveSettings;
  Release;
  frmMain := nil;   //フォーム名に変更する
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  if DebugHook <> 0 then
    Self.Caption := 'Debug Mode - DALS(Win64)';
  DisableVclStyles(Self, '');
  _LoadSettings;
  SL_CHECKLIST := TStringList.Create;
  Application.ProcessMessages;
  if FileExists(av.sFILE_CHECKLIST) then
    SL_CHECKLIST.LoadFromFile(av.sFILE_CHECKLIST, TEncoding.UTF8);
  _CreateSportsImages;
  _LoadFromFile;
  _CheckIsOnAir;
  _LoadCheckList;
  _ChangeToolbarStatus;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    char(VK_ESCAPE) :
      begin
        Key := char(0);
        Application.Minimize;
      end;
  end;
end;

procedure TfrmMain.lvwListClick(Sender: TObject);
var
  item : TListItem;
begin
  if av.bDebugMode then
  begin
    item := lvwList.Selected;
    if item <> nil then
    begin
      _DPStr('Caption:' + Item.Caption);
      _DPStr('SubItem[0]:' + Item.SubItems[0]);
      _DPStr('SubItem[1]:' + Item.SubItems[1]);
      _DPStr('SubItem[2]:' + Item.SubItems[2]);
      _DPStr('SubItem[3]:' + Item.SubItems[3]);
      _DPStr('FullTime:' + TListItemEx(Item).sFullDateTime);
      _DPStr('ImageIndex:' + IntToStr(Item.ImageIndex));
      _DPStr('GroupIndex:' + IntToStr(Item.GroupID));
      _DPStr('GroupImageIndex:' + IntToStr(lvwList.Groups[Item.GroupID].TitleImage));
      _DPStr('---- Output ----');
      frmDebug.lstDebug.SelectLastItem;
    end;
  end;
end;

procedure TfrmMain.lvwListCreateItemClass(Sender: TCustomListView;
  var ItemClass: TListItemClass);
begin
  ItemClass := TListItemEx;
end;

procedure TfrmMain.lvwListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with lvwList.Canvas do
  begin
    lvwList.ColorizeLines(Item, State,DefaultDraw);
    Brush.Style := bsSolid;
    //放送中と視聴予約の背景を変更する
    Case Item.ImageIndex of
      0 : Brush.Color := $00E6FFFA;
      1 : Brush.Color := $00F7F7FF;
      4 :
        begin
          Font.Color :=  $00C7C7C7;
        	Brush.Color := $00FAFAFA;
        end;
    end;
  end;
end;

procedure TfrmMain.lvwListDblClick(Sender: TObject);
var
  item : TListItem;
begin
  item := lvwList.Selected;
  if item = nil then Exit;

  if (item.ImageIndex <> 1) and (item.ImageIndex <> 4) then
  begin
  	item.ImageIndex := IfThen((item.ImageIndex = 0), -1, 0);
    _SaveCheckList(item);
    SL_CHECKLIST.SaveToFile(av.sFILE_CHECKLIST, TEncoding.UTF8);
  end;
end;

procedure TfrmMain.popFavoritePopup(Sender: TObject);
var
  item : TSpTBXItem;
  ini : TMemIniFile;
  sl : TStringList;
  i : Integer;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  sl := TStringList.Create;
  try
    popFavorite.Items.Clear;
    sl.CommaText := ini.ReadString(Self.Name, 'Favorites', '');
    for i := 0 to sl.Count-1 do
    begin
      item := TSpTBXItem.Create(popFavorite);
      item.Caption := sl[i];
      item.OnClick := _SelectFavorite;
      item.FontSettings.Name := Self.Font.Name;
      popFavorite.Items.Add(item);
    end;
  finally
    ini.Free;
    sl.Free;
  end;
end;

procedure TfrmMain.popLvwCheckDeleteClick(Sender: TObject);
var
  item : TListItem;
  i : Integer;
begin
  for i := 0 to lvwList.Items.Count-1 do
  begin
    item := lvwList.Items[i];
    if item.Selected and ContainsInteger([-1, 0], item.ImageIndex) then
    begin
    	item.ImageIndex := IfThen((item.ImageIndex = 0), -1, 0);
      _SaveCheckList(item);
    end;
  end;
  SL_CHECKLIST.SaveToFile(av.sFILE_CHECKLIST, TEncoding.UTF8);
end;

procedure TfrmMain.popReloadClick(Sender: TObject);
var
  sl : TStringList;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(GetApplicationPath + 'Datas\DownlodedHtml.txt', TEncoding.UTF8);
    _CreateTimeTable(sl.Text);
    _CreateTreeView;
    _LoadFromFile;
    _ChangeToolbarStatus;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.popRenameClick(Sender: TObject);
var
  n : TTreeNode;
begin
  n := tvwSports.Selected;
  if n <> nil then
  begin
    Application.CreateForm(TfrmNewName, frmNewName);
    frmNewName.edtCurrent.Text := n.Text;
    frmNewName.edtNew.Text := n.Text;
    frmNewName.ClientHeight := 160;
    frmNewName.edtNew.SelectAll;
    frmNewName.Show;
  end;
end;

procedure TfrmMain.popSetFavoriteClick(Sender: TObject);
var
  n : TTreeNode;
  ini : TMemIniFile;
  sl : TStringList;
  s : String;
begin
  n := tvwSports.Selected;
  if n <> nil then
  begin
    sl := TStringList.Create;
    ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
    try
      sl.CommaText := ini.ReadString(Self.Name, 'Favorites', '');
      sl.Add(n.Text);
      s := sl.CommaText;
      ini.WriteString(Self.Name, 'Favorites',s);
    finally
      ini.UpdateFile;
      ini.Free;
      sl.Free;
    end;
  end;
end;

procedure TfrmMain.popSetIconClick(Sender: TObject);
begin
  Application.CreateForm(TfrmEditIcons, frmEditIcons);
  frmEditIcons.PageControl.Pages[0].TabVisible := False;
  frmEditIcons.Show;
end;

procedure TfrmMain.popSyncTimeClick(Sender: TObject);
begin
  _SyncTime;
end;

procedure TfrmMain.popTreeViewPopup(Sender: TObject);
begin
  popReload.FontSettings.Name := Self.Font.Name;
  popSetFavorite.FontSettings.Name := Self.Font.Name;
  popSyncTime.FontSettings.Name := Self.Font.Name;

  popSetFavorite.Visible := True;
  popRename.Visible := True;
  popReload.Visible := True;
  popSyncTime.Visible := True;
  popSetIcon.Visible := True;
  Case tvwSports.Selected.ImageIndex of
    0 : //DAZN
      begin
        popSetFavorite.Visible := False;
        popRename.Visible := False;
        popSetIcon.Visible := False;
      end;
  end;
end;

procedure TfrmMain.tbrChangeNameClick(Sender: TObject);
begin
  popRenameClick(nil);
end;

procedure TfrmMain.tbrDebugClick(Sender: TObject);
begin
  Application.CreateForm(TfrmDebug, frmDebug);
  frmDebug.Show;
end;

procedure TfrmMain.tbrEditFavoritesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmEditFavorites, frmEditFavorites);
  frmEditFavorites.Show;
end;

procedure TfrmMain.tbrEditIconsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmEditIcons, frmEditIcons);
  frmEditIcons.PageControl.Pages[1].TabVisible := False;
  frmEditIcons.Show;
end;

procedure TfrmMain.tbrEditNameClick(Sender: TObject);
begin
  Application.CreateForm(TfrmEditNameList, frmEditNameList);
  frmEditNameList.Show;
end;

procedure TfrmMain.tbrFavoritesClick(Sender: TObject);
var
  pt : TPoint;
begin
  pt := Mouse.CursorPos;
  popFavorite.Popup(pt.X, pt.Y);
end;

procedure TfrmMain.tbrGetDataClick(Sender: TObject);
var
  sl : TStringList;
  n : TTreeNode;
begin
  if av.bSNTPEnabled then
    _SyncTime;

  with panInfo do
  begin
    Top := (Self.Height div 2) - 30;
    Left := (Self.Width div 2) - 150;
    Caption := 'DAZNに接続中...';
    Visible := True;
    Application.ProcessMessages;
  end;
  _SaveTreeViewStatus;
  timFailed.Enabled := True;

  sl := TStringList.Create;
  try
//    if DownloadHttpToStringList('https://flyingsc.github.io/dazn-schedule/', sl, TEncoding.UTF8) then
    if _DownloadData(sl) then
    begin
//      _SaveDownlodedHtml(sl.Text);
//      sl.LoadFromFile(GetApplicationPath + 'Datas\DownlodedHtml.txt', TEncoding.UTF8);
      _CreateTimeTable(sl.Text);
      _CreateTreeView;
      _LoadFromFile;
      _CheckIsOnAir;
      _LoadCheckList;
      _ChangeToolbarStatus;
      _DeleteNoChildNodes;
      n := tvwSports.Selected;
      if n.Parent <> nil then
      begin
        av.sCurrentText := n.Text;
        av.sCurrentParentText := n.Parent.Text;
      end else
        av.sCurrentParentText := '';
      lblUpdated.Caption := '更新日時:' + DateTimeToStr(Now);
    end else
    begin
    	lblUpdated.Caption := '更新失敗:' + DateTimeToStr(Now);
    end;
    panInfo.Visible := False;
    timFailed.Enabled := False;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.tbrMinogashiClick(Sender: TObject);
begin
  Application.CreateForm(TfrmMinogashi, frmMinogashi);
  frmMinogashi.Show;
end;

procedure TfrmMain.tbrOptionClick(Sender: TObject);
begin
  Application.CreateForm(TfrmOption, frmOption);
  frmOption.Show;
end;

procedure TfrmMain.tbrSetIconClick(Sender: TObject);
begin
  Application.CreateForm(TfrmEditIcons, frmEditIcons);
  frmEditIcons.PageControl.Pages[0].TabVisible := False;
  frmEditIcons.Show;
end;

procedure TfrmMain.tbrShowDAZNClick(Sender: TObject);
begin
  ShellExecuteSimple('https://flyingsc.github.io/dazn-schedule/');
end;

procedure TfrmMain.tbrVersionClick(Sender: TObject);
begin
  Application.CreateForm(TfrmVersion, frmVersion);
  frmVersion.ShowModal;
end;

procedure TfrmMain.timFailedTimer(Sender: TObject);
begin
  timFailed.Enabled := False;
  panInfo.Visible := False;
  Application.ProcessMessages;
  if panInfo.Caption = '番組表を表示中...' then
    MessageDlg('DAZNから反応がありません。しばらく時間をおいてから再度取得して下さい。',
               '番組表取得失敗', mtWarning, [mbOK])
  else if panInfo.Caption = '番組表を作成中...' then
    MessageDlg('番組表の作成に失敗しました。しばらく時間をおいてから再度取得して下さい。',
               '番組表取得失敗', mtWarning, [mbOK]);
end;

procedure TfrmMain.timOnAirTimer(Sender: TObject);
var
  s : String;
begin
  if SecondOf(Now) = 0 then
  begin
    s := FormatDateTime('HH:NN', Now);
    if ContainsText(av.sDownloadTime, s) then
      tbrGetDataClick(nil)
    else
      _CheckIsOnAir;
  end;
end;

procedure TfrmMain.TrayIcon1Click(Sender: TObject);
begin
  Show;
  Self.WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TfrmMain.tvwSportsClick(Sender: TObject);
var
  pt : TPoint;
  ht : THitTests;
begin
  GetCursorPos(pt);
  pt := tvwSports.ScreenToClient(pt);
  ht := tvwSports.GetHitTestInfoAt(pt.X, pt.Y);
  if ht * [htOnIcon, htOnLabel, htOnStateIcon] <> [] then
  begin
    _LoadFromFile;
    _ChangeToolbarStatus;
  end;
end;

procedure TfrmMain.tvwSportsCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  tvwSports.ColorizeNodes(Node, State, DefaultDraw);
end;

procedure TfrmMain.tvwSportsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  _LoadFromFile;
  _ChangeToolbarStatus;
end;

procedure TfrmMain._ChangeToolbarStatus;
var
  n : TTreeNode;
begin
  tbrGetData.Enabled := True;
  tbrVersion.Enabled := True;
  tbrMinogashi.Enabled := True;
  tbrFavorites.Enabled := True;
  tbrEditFavorites.Enabled := True;
  tbrOption.Enabled := True;
  tbrEditName.Enabled := True;
  tbrChangeName.Enabled := True;
  tbrSetIcon.Enabled := True;
  tbrEditIcons.Enabled := True;
  n := tvwSports.Selected;
  if n <> nil then
  begin
    Case tvwSports.Selected.ImageIndex of
      0 :
        begin
          tbrChangeName.Enabled := False;
          tbrSetIcon.Enabled := False;
        end;
    end;
  end;
end;

procedure TfrmMain._CheckIsOnAir;
var
  item : TListItemEx;
  i : Integer;
  sInfo, sDate : String;
  bInfo : Boolean;
  sl, sm : TStringList;
begin
  try
    bInfo := False;
    sl := TStringList.Create;
    sm := TStringList.Create;
    try
      for i := SL_CHECKLIST.Count-1 downto 0 do
      begin
        sl.CommaText := SL_CHECKLIST[i];
        if StrToDateTime(sl[4]) <= IncMinute(Now, av.iInformTime) then
        begin
          SL_CHECKLIST.Delete(i);
          sInfo := sInfo + Format('%s %s', [sl[4], sl[3]]) + #13#10;
          sDate := sDate + sl[4];
          bInfo := True;
        end;
      end;

      sl.Clear;
      for i := lvwList.Items.Count-1 downto 0 do
      begin
        item := TListItemEx(lvwList.Items[i]);
        //チェックしている番組のアイコンを変更する
        if (item.ImageIndex = 0) and ContainsText(sDate, item.sFullDateTime) then
          item.ImageIndex := -1;

        //配信開始の番組アイコンを変更する
        if item.sFullDateTime <= DateTimeToStr(IncHour(Now, -2)) then
          item.ImageIndex := 4
        else if item.sFullDateTime <= DateTimeToStr(IncMinute(Now, 10)) then
          item.ImageIndex := 1;

        //配信時間が過ぎた番組を消す
        if StrToDateTime(item.sFullDateTime) <= IncHour(Now, av.iDeletionTime) then
        begin
          sm.Clear;
          sm.Add(LeftStr(item.sFullDateTime, 10));
          sm.Add(GetWeeklyJapaneseName(StrToDate(LeftStr(item.sFullDateTime, 10)), True));
          sm.Add(Copy(item.sFullDateTime, 12, 5));
          sm.Add(item.SubItems[0]);
          sm.Add(item.SubItems[1]);
          sm.Add(item.SubItems[2]);
          sm.Add(item.SubItems[3]);
          sl.Add(sm.CommaText);
          item.Delete;
        end;
      end;

      lblItemCount.Caption := Format('配信予定数:%d件', [lvwList.Items.Count]);

      if sl.Count > 0 then
      begin
        sm.LoadFromFile(av.sFILE_MINOGASHI, TEncoding.UTF8);
        for i := sl.Count-1 downto 0 do
          sm.Add(sl[i]);
        sm.SaveToFile(av.sFILE_MINOGASHI, TEncoding.UTF8);
      end;

      if bInfo then
      begin
        SL_CHECKLIST.SaveToFile(av.sFILE_CHECKLIST, TEncoding.UTF8);
        Application.CreateForm(TfrmInfo, frmInfo);
        frmInfo.staInfo.Caption := sInfo;
        frmInfo.Show;
      end;
    finally
      sl.Free;
      sm.Free;
    end;
  except
    MessageDlg('Error : _CheckIsOnAir', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._CreateSportsImages;
var
  i : Integer;
  s : String;
begin
  pngTreeView.BeginUpdate;
  pngTreeView.Clear;
  for i := 0 to 500 do
  begin
    s := Format('%simages\%d.png', [GetApplicationPath, i]);
    if FileExists(s) then
      pngTreeView.PngImages.Add.PngImage.LoadFromFile(s)
    else
    begin
    	s := Format('%simages\%d.png', [GetApplicationPath, i-1]);
      pngTreeView.PngImages.Add.PngImage.LoadFromFile(s);
      Break;
    end;
  end;
  pngTreeView.EndUpdate;
end;

procedure TfrmMain._CreateTimeTable(s: String);
  procedure _in_SetDateAndWeekname(s: String; var sDate, sWeekname: String);
  var
    d : TDate;
  begin
    s := FormatDateTime('YYYY/', Now) + s;
    d := StrToDate(s);
    if (MonthOf(d) = 1) and (MonthOf(Now) = 12) then
      d := IncYear(d, 1);
    sDate := FormatDateTime('YYYY/MM/DD', d);
    sWeekname := GetWeeklyJapaneseName(d, True);
  end;

  function _in_SetTime(s: String): String;
  var
    t : TTime;
  begin
    Result := s;
    try
      t := StrToTime(s);
      Result := FormatDateTime('HH:NN', t);
    except
      //
    end;
  end;

  function in_SetCompetitionName(s: String): String;
  begin
    Result := s;
    if ContainsText(s, 'ワールドカップ') and ContainsText(s, '予選') then
    begin
      s := EraseSpace(s);
      Result := ReplaceText(s, 'ワールドカップ', ' ワールドカップ ');
    end;
  end;

  function in_SetSportsName(s: String): String;
  begin
    s := Trim(ReplaceTextEx(RemoveHTMLTags(s),
                            ['&nbsp;', 'Union'],
                            ['', '']));
    s := CopyStrToStr(s, ' ');
    Result := Trim(s);
  end;

var
  ini : TMemIniFile;
  sl, sm, sn, so, sp : TStringList;
  iPos, iGroupID : Integer;
  sSource, sTmp, sTime, sType, sName, sTeams, sDate, sWeekName, sAna, sGroup, s1, s2 : String;
begin
  try
    sl := TStringList.Create;
    sm := TStringList.Create;
    sn := TStringList.Create;
    so := TStringList.Create;
    sp := TStringList.Create;
    ini := TMemIniFile.Create(av.sFILE_CONVERTLIST, TEncoding.UTF8);
    try
      if FileExists(av.sFILE_MINOGASHI) then
        sp.LoadFromFile(av.sFILE_MINOGASHI, TEncoding.UTF8);

      sGroup := '';
      iGroupID := -1;
      sSource := CopyStr(s, '<table>', '</table>');
      iPos := PosText('<tr', sSource);
      repeat
        sTmp := CopyStrEx(sSource, '<tr', '</tr>', iPos);
        //日時欄
        if ContainsText(sTmp, '"date-row">') then
        begin
          sTmp := RemoveHTMLTags(sTmp);
          sTmp := CopyStrToStr(sTmp, '（');
          sTmp := ReplaceTextEx(sTmp, ['月', '日'], ['/', '']);
          sTmp := ConvertMBENtoSBENW(sTmp);
          sTmp := ExtractSelectedChar(sTmp, '0123456789/');
          _in_SetDateAndWeekname(sTmp, sDate, sWeekName);
        end
        //番組名の取得
        else if Pos('<td class="date">', sTmp) > 0 then
        begin
          SplitByString(sTmp, '</td>', sl);
          //開始時間
          sTime := _in_SetTime(RemoveHTMLTags(sl[0]));
          //スポーツ名
          sType := in_SetSportsName(RemoveHTMLTags(sl[1]));
          sType := ini.ReadString('Name', sType, sType);
          //大会名
          sName := RemoveHTMLTags(sl[2]);
          sName := StrDef(sName, '(未記録)');
          sName := in_SetCompetitionName(sName);
          sName := ini.ReadString('Name', sName, sName);
          //チーム名
          sTeams:= RemoveHTMLTags(sl[3]);
          sTeams:= Trim(ReplaceText(sTeams, ' v ', ' vs '));
          if ContainsText(sTeams, ' vs ') then
          begin
            SplitStringsToAandB(sTeams, ' vs ', s1, s2);
            s1 := ini.ReadString('Name', s1, s1);
            s2 := ini.ReadString('Name', s2, s2);
            sTeams := Format('%s vs %s', [s1, s2]);
          end;
          //実況･解説
          sAna:= Trim(ReplaceTextEx(RemoveHTMLTags(sl[4]),
                                      ['&nbsp;', '※', '　'],
                                      ['', '', '／']));

          //配信が終わっている番組は除外する
          //配信時間が過ぎた番組は消す
          if StrToDateTime(Format('%s %s', [sDate, sTime])) > IncHour(Now, -24) then
          begin
            //グループを作成
            if sGroup <> sDate then
            begin
              iGroupID := iGroupID + 1;
              sGroup := sDate;
              sm.Clear;
              sm.Add('Group');
              sm.Add(sDate);
              sm.Add(sWeekName);
              sm.Add(IntToStr(iGroupID));
              sn.Add(sm.CommaText);

              sm.Clear;
              sm.Add(sDate);
              sm.Add(sWeekName);
              sm.Add(sTime);
              sm.Add(sType);
              sm.Add(sName);
              sm.Add(sTeams);
              sm.Add(sAna);
              sm.Add(IntToStr(iGroupID));
              sn.Add(sm.CommaText);
            end
            else
            begin
              sm.Clear;
              sm.Add(sDate);
              sm.Add(sWeekName);
              sm.Add(sTime);
              sm.Add(sType);
              sm.Add(sName);
              sm.Add(sTeams);
              sm.Add(sAna);
              sm.Add(IntToStr(iGroupID));
              sn.Add(sm.CommaText);
            end;
          end
          else
          begin
            //配信時間が過ぎ、見逃し配信となった番組
            so.Clear;
            so.Add(sDate);
            so.Add(sWeekName);
            so.Add(sTime);
            so.Add(sType);
            so.Add(sName);
            so.Add(sTeams);
            so.Add(sAna);
            sTmp := so.CommaText;
            if sp.IndexOf(sTmp) = -1 then
              sp.Add(sTmp);
          end;
        end;
        iPos := PosEx('<tr', sSource, iPos+1);
      until iPos = 0;
      sn.SaveToFile(av.sFILE_LIVESCHEDULE, TEncoding.UTF8);
      sp.SaveToFile(av.sFILE_MINOGASHI, TEncoding.UTF8);
    finally
      sl.Free;
      sm.Free;
      sn.Free;
      so.Free;
      sp.Free;
      ini.Free;
    end;
  except
    MessageDlg('Error : _CreateTimeTable', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._CreateTreeView;
var
  sl, sm, sn : TStringList;
  s: String;
  i, idx, idx2 : Integer;
  nRoot, nSports, nCompe, nTeam : TTreeNode;
begin
  try
    sl := TStringList.Create;
    sm := TStringList.Create;
    sn := TStringList.Create;
    tvwSports.Items.BeginUpdate;
    tvwSports.Items.Clear;
    try
      nRoot := tvwSports.Items.Add(nil, 'DAZN');
      nRoot.ImageIndex := ICO_ROOT;
      nRoot.SelectedIndex := ICO_ROOT;
      sl.LoadFromFile(av.sFILE_LIVESCHEDULE, TEncoding.UTF8);
      for s in sl do
      begin
        sm.CommaText := s;
        //グループヘッダーの場合
        if sm[0] <> 'Group' then
        begin
          //スポーツ名を探す
          idx := -1;
          nSports := nil;
          for i:= 0 to nRoot.Count-1 do
          begin
            if SameText(nRoot.Item[i].Text, sm[3]) then
            begin
              nSports := nRoot.Item[i];
              idx := nSports.Index;
              Break;
            end;
          end;
          if idx = -1 then
          begin
            nSports := tvwSports.Items.AddChild(nRoot, sm[3]);
            nSports.ImageIndex := 4;
            nSports.SelectedIndex := nSports.ImageIndex;
            if sm[3] = av.sCurrentText then
            begin
              nSports.Selected := True;
              nSports.Parent.Expanded := True;
            end;
          end;

          //大会名を探す
          idx2 := -1;
          nCompe := nil;
          for i:= 0 to nSports.Count-1 do
          begin
            if SameText(nSports.Item[i].Text, sm[4]) then
            begin
              nCompe := nSports.Item[i];
              idx2 := nCompe.Index;
              Break;
            end;
          end;
          if idx2 = -1 then
          begin
            nCompe := tvwSports.Items.AddChild(nSports, sm[4]);
            nCompe.ImageIndex := ICO_COMPE;
            nCompe.SelectedIndex := nCompe.ImageIndex;
            if (sm[4] = av.sCurrentText) and (nCompe.Parent.Text = av.sCurrentParentText) then
            begin
              nCompe.Selected := True;
              nCompe.Parent.Expanded := True;
            end;
          end;

          //チーム名を探す
          sm[5] := ReplaceTextEx(sm[5], [' v ', ' VS ', 'vs ', ' vs'],
                                        [' vs ', ' vs ', ' vs ', ' vs ']);
          if ContainsText(sm[5], ' vs ') then
          begin
            SplitByString(sm[5], ' vs ', sn);
            sn[0] := Trim(sn[0]);
            if ContainsText(sn[0], ' : ') then
              sn[0] := RemoveLeft(CopyStrToEnd(sn[0], ' : '), 3);
            sn[1] := Trim(RemoveStringFromAtoB(sn[1], '(', ')'));
            //Home
            if tvwSports.IndexofChildNode(nCompe, sn[0]) = -1 then
            begin
              nTeam := tvwSports.Items.AddChild(nCompe, sn[0]);
              nTeam.ImageIndex := ICO_TEAM;
              nTeam.SelectedIndex := ICO_TEAM;
              if (sn[0] = av.sCurrentText) and (nTeam.Parent.Text = av.sCurrentParentText) then
              begin
                nTeam.Selected := True;
                nTeam.Parent.Expanded := True;
              end;
            end;
            //Away
            if tvwSports.IndexofChildNode(nCompe, sn[1]) = -1 then
            begin
              nTeam := tvwSports.Items.AddChild(nCompe, sn[1]);
              nTeam.ImageIndex := ICO_TEAM;
              nTeam.SelectedIndex := ICO_TEAM;
              if (sn[1] = av.sCurrentText) and (nTeam.Parent.Text = av.sCurrentParentText) then
              begin
                nTeam.Selected := True;
                nTeam.Parent.Expanded := True;
              end;
            end;
          end
          else
          begin
            if tvwSports.IndexofChildNode(nCompe, sm[5]) = -1 then
            begin
              nTeam := tvwSports.Items.AddChild(nCompe, sm[5]);
              nTeam.ImageIndex := ICO_TEAM;
              nTeam.SelectedIndex := ICO_TEAM;
            end;
          end;
        end;
      end;
      _LoadTreeViewIcons;
      _LoadTreeViewStatus;
      nRoot.Expanded := True;
      tvwSports.AlphaSort(True);
    finally
      sl.Free;
      sm.Free;
      sn.Free;
      tvwSports.Items.EndUpdate;
    end;
  except
    MessageDlg('Error : _CreateTreeView', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._LoadFromFile;
var
  gr : TListGroup;
  item : TListItemEx;
  n : TTreeNode;
  sl, sm : TStringList;
  i : Integer;
  bAdd : Boolean;
begin
  try
    sl := TStringList.Create;
    sm := TStringList.Create;
    HolidaysListCreate;
    lvwList.Items.BeginUpdate;
    lvwList.Items.Clear;
    lvwList.Groups.BeginUpdate;
    lvwList.Groups.Clear;
    pngHeader.PngImages.BeginUpdate;
    pngHeader.Destroy;
    pngHeader := TPngImageList.Create(Self);
    pngHeader.Width := 32;
    pngHeader.Height := 32;
    try
      if Not FileExists(av.sFILE_LIVESCHEDULE) then Exit;

      GetHolidays(FormatDateTime('YYYY', Now));
      GetHolidays(FormatDateTime('YYYY', IncYear(Now, 1)));

      n := tvwSports.Selected;
      sl.LoadFromFile(av.sFILE_LIVESCHEDULE, TEncoding.UTF8);
      for i := 0 to sl.Count-1 do
      begin
        if n = nil then
        begin
          n := tvwSports.Items[0];
          n.Selected := True;
          bAdd := True;
        end else
          bAdd := False;
        sm.CommaText := sl[i];
        //グループヘッダーの場合
        if sm[0] = 'Group' then
        begin
          gr := lvwList.Groups.Add;
          gr.Header := Format('%s(%s)', [sm[1], sm[2]]);
          gr.Subtitle := '配信予定';
          gr.GroupID := StrToInt(sm[3]);
          gr.TitleImage := _SetImageIndex(sm[1], sm[2]);
        end
        else
        begin
          Case tvwSports.GetSelectedNodeLevel of
            0 : bAdd := True;
            1 : if ContainsText(sm[3], n.Text) then
                    bAdd := True;
            2 : if SameText(sm[3], n.Parent.Text) and
                   SameText(sm[4], n.Text) then
                    bAdd := True;
            3 : if SameText(sm[3], n.Parent.Parent.Text) and
                   SameText(sm[4], n.Parent.Text) and
                   ContainsText(sm[5], n.Text) then
                    bAdd := True;
          end;

          if bAdd then
          begin
            //配信時間が過ぎた番組以外を表示
  //          if StrToDateTime(Format('%s %s:00', [sm[0], sm[2]])) > IncHour(Now, -24) then
            if StrToDateTime(Format('%s %s:00', [sm[0], sm[2]])) > IncHour(Now, av.iDeletionTime) then
            begin
              item := TListItemEx(lvwList.Items.Add);
              item.Caption := sm[2];
              item.SubItems.Add(sm[3]);
              item.SubItems.Add(sm[4]);
              item.SubItems.Add(sm[5]);
              item.SubItems.Add(sm[6]);
              item.sFullDateTime := Format('%s %s:00', [sm[0], sm[2]]);
              //On Air中の番組の場合
              if item.sFullDateTime <= DateTimeToStr(IncHour(Now, -2)) then
                item.ImageIndex := 4
              else if item.sFullDateTime <= DateTimeToStr(Now) then
                item.ImageIndex := 1
              else
                item.ImageIndex := -1;
              item.GroupID := StrToInt(sm[7]);
            end;
          end;
        end;
      end;
    finally
      sl.Free;
      sm.Free;
      HolidaysListFree;
      pngHeader.PngImages.EndUpdate;
      lvwList.GroupHeaderImages := pngHeader;
      lvwList.Groups.EndUpdate;
      lvwList.Items.EndUpdate;
    end;
    _LoadCheckList;
    lblItemCount.Caption := Format('配信予定数:%d件', [lvwList.Items.Count]);
    //配信番組が無い場合は、カテゴリを削除する
    if lvwList.Items.Count = 0 then
      n.Delete;

    if av.bDebugMode then
    begin
      _DPStr('Text:' + tvwSports.Selected.Text);
      _DPStr('ImageIndex:' + IntToStr(tvwSports.Selected.ImageIndex));
      _DPStr('SelectedImageIndex:' + IntToStr(tvwSports.Selected.SelectedIndex));
      _DPStr('pngHeader.PngImages.Count:' + IntToStr(pngHeader.PngImages.Count));
      _DPStr('---- Output ----');
      frmDebug.lstDebug.SelectLastItem;
      frmDebug.lvwList.Items.Clear;
      frmDebug.lvwList.LargeImages := pngHeader;
      for i := 0 to pngHeader.Count-1 do
      begin
        item := TListItemEx(frmDebug.lvwList.Items.Add);
        item.Caption := IntToStr(i);
        item.ImageIndex := i;
      end;
    end;
  except
    MessageDlg('Error : _LoadFromFile', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._LoadCheckList;
var
  item : TListItem;
  sl, sm : TStringList;
  i, j : Integer;
begin
  try
    sl := TStringList.Create;
    sm := TStringList.Create;
    try
      if FileExists(av.sFILE_CHECKLIST) then
      begin
        sl.LoadFromFile(av.sFILE_CHECKLIST, TEncoding.UTF8);
        for i := sl.Count-1 downto 0 do
        begin
          sm.CommaText := sl[i];
          for j := 0 to lvwList.Items.Count-1 do
          begin
            item := lvwList.Items[j];
            if (item.Caption = sm[0]) and
               (item.SubItems[0] = sm[1]) and
               (item.SubItems[1] = sm[2]) and
               (item.SubItems[2] = sm[3]) then
            begin
              if ContainsInteger([-1, 1, 4], item.ImageIndex) then
                item.ImageIndex := 0;
              Break;
            end;
          end;
        end;
      end;
    finally
      sl.Free;
      sm.Free;
    end;
  except
    MessageDlg('Error : _LoadCheckList', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._LoadSettings;
var
  ini : TMemIniFile;
begin
  CreateFolder(GetApplicationPath + '\datas');
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindowPosition(Self.Name, Self);
    panLeft.Width := ini.ReadInteger(Self.Name, 'panLeft.Width', panLeft.Width);
    lvwList.Column[0].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[0].Width', 100);
    lvwList.Column[1].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[1].Width', 100);
    lvwList.Column[2].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[2].Width', 100);
    lvwList.Column[3].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[3].Width', 100);
    lvwList.Column[4].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[4].Width', 100);
    tbxToolbar1.DockPos     := ini.ReadInteger(Self.Name, 'tbxToolbar1.DockPos', tbxToolbar1.DockPos);
    tbxToolbar2.DockPos     := ini.ReadInteger(Self.Name, 'tbxToolbar2.DockPos', tbxToolbar2.DockPos);
    tbxToolbar3.DockPos     := ini.ReadInteger(Self.Name, 'tbxToolbar3.DockPos', tbxToolbar3.DockPos);
    tbxToolbar1.DockRow     := ini.ReadInteger(Self.Name, 'tbxToolbar1.DockRow', tbxToolbar1.DockRow);
    tbxToolbar2.DockRow     := ini.ReadInteger(Self.Name, 'tbxToolbar2.DockRow', tbxToolbar2.DockRow);
    tbxToolbar3.DockRow     := ini.ReadInteger(Self.Name, 'tbxToolbar3.DockRow', tbxToolbar3.DockRow);
    lblUpdated.Caption      := ini.ReadString(Self.Name, 'lblUpdated.Caption', '');
    timFailed.Interval      := ini.ReadInteger(Self.Name, 'timFailed.Interval', 20000);
    av.sFavorite            := ini.ReadString(Self.Name, 'Favorite', '');
    av.sSNTPHost            := ini.ReadString('SNTP', 'HostName', 'ntp.jst.mfeed.ad.jp');
    av.bSNTPEnabled         := ini.ReadBool('SNTP', 'Enabled', True);
    Self.Font.Name          := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size          := ini.ReadInteger('General', 'FontSize', 10);
    av.iInformTime          := ini.ReadInteger('General', 'InformTime', 10);
    av.iDeletionTime        := -2 - ini.ReadInteger('General', 'DeletionTime', 10);
    av.sSound               := ini.ReadString('General', 'Sound', 'C:\Windows\Media\Ring04.wav');
    av.sDownloadTime        := ini.ReadString('General', 'DownloadTime', '09:00;20:00');
    av.bDebugMode           := False;
  finally
    ini.Free;
  end;
  av.sFILE_LIVESCHEDULE := GetApplicationPath + 'Datas\LiveSchedule.txt';
  av.sFILE_CHECKLIST    := GetApplicationPath + 'Datas\CheckList.txt';
  av.sFILE_TREEVIEW     := GetApplicationPath + 'Datas\tvwSports.txt';
  av.sFILE_MINOGASHI    := GetApplicationPath + 'Datas\Minogashi.txt';
  av.sFILE_CONVERTLIST  := GetApplicationPath + 'Datas\ConvertList.txt';
  av.sFILE_ICONINDEX    := GetApplicationPath + 'Datas\IconIndex.txt';
  if FileExists(av.sFILE_TREEVIEW) then
    tvwSports.LoadFromFileEx(av.sFILE_TREEVIEW);
end;

procedure TfrmMain._LoadTreeViewIcons;
var
  ini : TMemIniFile;
  sl : TStringList;
  n : TTreeNode;
  i, j, iLevel: Integer;
  sKey, sValue, sIndex, sLevel : String;
begin
  ini := TMemIniFile.Create(av.sFILE_ICONINDEX, TEncoding.UTF8);
  sl := TStringList.Create;
  try
    ini.ReadSectionValues('Index', sl);
    for i := 0 to sl.Count-1 do
    begin
      SplitStringsToAandB(sl[i], '=', sKey, sValue);
      SplitStringsToAandB(sValue, ',', sIndex, sLevel);
      for j := 0 to tvwSports.Items.Count-1 do
      begin
        n := tvwSports.Items[j];
        if ContainsText(n.Text, sKey) then
        begin
          iLevel := StrToInt(sLevel);
          if (iLevel = 0) or (iLevel = tvwSports.GetNodeLevel(n)) then
          begin
          n.ImageIndex := StrToInt(sIndex);
          n.SelectedIndex := n.ImageIndex;
          end;
        end;
      end;
    end;
  finally
    ini.Free;
    sl.Free;
  end;
end;

procedure TfrmMain._LoadTreeViewStatus;
var
  n : TTreeNode;
  sl, sm : TStringList;
  i, idx : Integer;
  sFile : String;
begin
  sl := TStringList.Create;
  sm := TStringList.Create;
  try
    sFile := GetApplicationPath + 'Datas\TreeViewStatus.txt';
    if FileExists(sFile) then
    begin
    	sl.LoadFromFile(sFile, TEncoding.UTF8);
      for i := 0 to tvwSports.Items.Count-1 do
      begin
        n := tvwSports.Items[i];
        idx := ContainsTextIndexInStringList(sl, n.Text);
        if idx <> -1 then
        begin
        	sm.CommaText := sl[idx];
          n.Expanded := StrToBool(sm[1]);
        end;
      end;
    end;
  finally
    sl.Free;
    sm.Free;
  end;
end;

procedure TfrmMain._DeleteNoChildNodes;
var
  n : TTreeNode;
  i : Integer;
begin
  for i := tvwSports.Items.Count-1 downto 0 do
  begin
    n := tvwSports.Items[i];
    if (tvwSports.GetNodeLevel(n) < 3) and (n.Count = 0) then
      n.Delete;
  end;
end;

function TfrmMain._DownloadData(sl: TStringList): Boolean;
var
  httpDoc: XMLHTTP;  // IXMLHTTPRequest
begin
  Result := False;
  httpDoc := CreateOleObject('MSXML2.XMLHTTP') as XMLHTTP;
  try
    httpDoc.open('GET', 'https://flyingsc.github.io/dazn-schedule/', False, EmptyParam, EmptyParam);
    httpDoc.send('');
    if (httpDoc.readyState = 4) and (httpDoc.status = 200) then
    begin
    	sl.Text := httpDoc.responseText;
      sl.SaveToFile(GetApplicationPath + 'Datas\DownlodedHtml.txt', TEncoding.UTF8);
      Result := True;
    end;
  finally
    httpDoc := nil;
  end;
end;

procedure TfrmMain._DPStr(sMessage: String);
begin
  frmDebug.lstDebug.Items.Add(Format('%s - %s', [DateTimeToStr(Now), sMessage]));
end;

procedure TfrmMain._SaveCheckList(item: TListItem);
var
  sl : TStringList;
  idx : Integer;
begin
  sl := TStringList.Create;
  try
    Case item.ImageIndex of
      -1 : //削除する
        begin
          sl.Clear;
          sl.Add(item.Caption);
          sl.Add(item.SubItems[0]);
          sl.Add(item.SubItems[1]);
          sl.Add(item.SubItems[2]);
          sl.Add(TListItemEx(item).sFullDateTime);
          idx := ContainsTextIndexInStringList(SL_CHECKLIST, sl.CommaText);
          SL_CHECKLIST.Delete(idx);
        end;
      0 : //追加する
        begin
          sl.Clear;
          sl.Add(item.Caption);
          sl.Add(item.SubItems[0]);
          sl.Add(item.SubItems[1]);
          sl.Add(item.SubItems[2]);
          sl.Add(TListItemEx(item).sFullDateTime);
          SL_CHECKLIST.Add(sl.CommaText);
        end;
      1 : //現在配信中
        begin
          //Nothing to do
        end;
    end;
  finally
    sl.Free;
  end;
end;

//procedure TfrmMain._SaveDownlodedHtml(s: String);
//var
//  sl : TStringList;
//begin
//  try
//    sl := TStringList.Create;
//    try
//      sl.Text := s;
//      sl.SaveToFile(GetApplicationPath + 'Datas\DownlodedHtml.txt', TEncoding.UTF8);
//    finally
//      sl.Free;
//    end;
//  except
//    MessageDlg('Error : _SaveDownloadedHtml', '', mtWarning, [mbOK]);
//  end;
//end;

procedure TfrmMain._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindowPosition(Self.Name, Self);
    ini.WriteInteger(Self.Name, 'panLeft.Width', panLeft.Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[2].Width', lvwList.Column[2].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[3].Width', lvwList.Column[3].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[4].Width', lvwList.Column[4].Width);
    ini.WriteInteger(Self.Name, 'tbxToolbar1.DockPos', tbxToolbar1.DockPos);
    ini.WriteInteger(Self.Name, 'tbxToolbar2.DockPos', tbxToolbar2.DockPos);
    ini.WriteInteger(Self.Name, 'tbxToolbar3.DockPos', tbxToolbar3.DockPos);
    ini.WriteInteger(Self.Name, 'tbxToolbar1.DockRow', tbxToolbar1.DockRow);
    ini.WriteInteger(Self.Name, 'tbxToolbar2.DockRow', tbxToolbar2.DockRow);
    ini.WriteInteger(Self.Name, 'tbxToolbar3.DockRow', tbxToolbar3.DockRow);
    ini.WriteString (Self.Name, 'lblUpdated.Caption', lblUpdated.Caption);
    ini.WriteInteger(Self.Name, 'timFailed.Interval', timFailed.Interval);
    ini.WriteString ('SNTP', 'HostName', av.sSNTPHost);
    ini.WriteBool('SNTP', 'Enabled', av.bSNTPEnabled);
    ini.WriteString('General', 'FontName', Self.Font.Name);
    ini.WriteInteger('General', 'FontSize', Self.Font.Size);
    ini.WriteInteger('General', 'InformTime', av.iInformTime);
    ini.WriteString('General', 'Sound', av.sSound);
    ini.WriteString('General', 'DownloadTime', av.sDownloadTime);
  finally
    ini.UpdateFile;
    ini.Free;
  end;
  tvwSports.SaveToFileEx(av.sFILE_TREEVIEW);
end;

procedure TfrmMain._SaveTreeViewStatus;
var
  n : TTreeNode;
  sl, sm : TStringList;
  i : Integer;
begin
  try
    sl := TStringList.Create;
    sm := TStringList.Create;
    try
      for i := 0 to tvwSports.Items.Count-1 do
      begin
        n := tvwSports.Items[i];
        sm.Clear;
        sm.Add(n.Text);
        sm.Add(BoolToStr(n.Expanded));
        sl.Add(sm.CommaText);
      end;
      sl.SaveToFile(GetApplicationPath + 'Datas\TreeViewStatus.txt', TEncoding.UTF8);
    finally
      sl.Free;
      sm.Free;
    end;
  except
    MessageDlg('Error : _SaveTreeViewStatus', '', mtWarning, [mbOK]);
  end;
end;

procedure TfrmMain._SearchGame(SubStr: String);
var
  gr : TListGroup;
  item : TListItemEx;
  n : TTreeNode;
  sl, sm, slGroup : TStringList;
  i : Integer;
  sTmp : String;
begin
  sl := TStringList.Create;
  sm := TStringList.Create;
  slGroup := TStringList.Create;
  lvwList.Items.BeginUpdate;
  lvwList.Items.Clear;
  lvwList.Groups.BeginUpdate;
  lvwList.Groups.Clear;
  pngHeader.PngImages.BeginUpdate;
  pngHeader.Destroy;
  pngHeader := TPngImageList.Create(Self);
  pngHeader.Width := 32;
  pngHeader.Height := 32;
  try
    HolidaysListCreate;
    GetHolidays(FormatDateTime('YYYY', Now));
    GetHolidays(FormatDateTime('YYYY', IncYear(Now, 1)));

    sl.LoadFromFile(av.sFILE_LIVESCHEDULE, TEncoding.UTF8);
    //グループヘッダーの作成
    for i := 0 to sl.Count-1 do
    begin
      sm.CommaText := sl[i];
      if sm[0] = 'Group' then
      begin
        sTmp := Format('%s(%s)', [sm[1], sm[2]]);
        if slGroup.IndexOf(sTmp) = -1 then
        begin
        	slGroup.Add(sTmp);
          gr := lvwList.Groups.Add;
          gr.Header := sTmp;
          gr.Subtitle := '配信予定';
          gr.GroupID := StrToInt(sm[3]);
          gr.TitleImage := _SetImageIndex(sm[1], sm[2]);
        end;
      end
      else
      begin
        n := tvwSports.Selected;
        Case tvwSports.GetSelectedNodeLevel of
          //スポーツ
          1 : SubStr := Format('%s %s', [n.Text, SubStr]);
          //大会名
          2 : SubStr := Format('%s %s %s', [n.Parent.Text, n.Text, SubStr]);
          //チーム名
          3 : SubStr := Format('%s %s %s %s', [n.Parent.Parent.Text, n.Parent.Text, n.Text, SubStr]);
        end;
        if SearchStrings(sl[i], SubStr, True, True) then
        begin
          //配信時間が過ぎた番組以外を表示
          if StrToDateTime(Format('%s %s:00', [sm[0], sm[2]])) > IncHour(Now, -2) then
          begin
            item := TListItemEx(lvwList.Items.Add);
            item.Caption := sm[2];
            item.SubItems.Add(sm[3]);
            item.SubItems.Add(sm[4]);
            item.SubItems.Add(sm[5]);
            item.SubItems.Add(sm[6]);
            item.sFullDateTime := Format('%s %s:00', [sm[0], sm[2]]);
            //On Air中の番組の場合
            if item.sFullDateTime <= DateTimeToStr(Now) then
              item.ImageIndex := 1
            else
              item.ImageIndex := -1;
            item.GroupID := StrToInt(sm[7]);
          end;
        end;
      end;
    end;
  finally
    sl.Free;
    sm.Free;
    HolidaysListFree;
    slGroup.Free;
    pngHeader.PngImages.EndUpdate;
    lvwList.GroupHeaderImages := pngHeader;
    lvwList.Groups.EndUpdate;
    lvwList.Items.EndUpdate;
  end;
  _LoadCheckList;
  lblItemCount.Caption := Format('配信予定数:%d件', [lvwList.Items.Count]);
end;

procedure TfrmMain._SelectFavorite(Sender: TObject);
var
//  n : TTreeNode;
//  i : Integer;
  sSubStr : String;
begin
  sSubStr := TSpTBXItem(Sender).Caption;
//  for i := 0 to tvwSports.Items.Count-1 do
//  begin
//    n := tvwSports.Items[i];
//    if SameText(sSubStr, n.Text) then
//    begin
//      n.Selected := True;
//      Break;
//    end;
//  end;
  _SearchGame(sSubStr);
//  _LoadFromFile;
  _ChangeToolbarStatus;
end;

function TfrmMain._SetImageIndex(sDate, sWeekname: String): Integer;
var
  png : TPngImage;
  idx : Integer;
  cFont : TColor;
  sDay : String;
begin
  sDay := IntToStr(DayOf(StrToDate(sDate)));
  if sWeekname = '土' then
  begin
  	idx := 1;
    cFont := $00AF6F3E;
  end
  else if sWeekname = '日' then
  begin
  	idx := 2;
    cFont := $000000EC;
  end
  else
  begin
  	idx := 0;
    cFont := $00616161;
  end;
  //祝祭日の場合
  if IsHoliday(sDate) then
  begin
  	idx := 2;
    cFont := $000000EC;
  end;

  png := TPngImage.Create;
  try
    png.Assign(pngList.PngImages.Items[idx].PngImage);
    with png.Canvas do
    begin
      Brush.Style := bsClear;
      Font.Name := 'Tahoma';
      //曜日の描画
      Font.Size := 7;
      Font.Color := clWhite;
      TextOut(16-(TextWidth(sWeekname) div 2), 0, sWeekname);
      //日付
      Font.Size := 11;
      Font.Color := cFont;
      TextOut(16-(TextWidth(sDay) div 2), 12, sDay);
    end;
    pngHeader.PngImages.Add.PngImage := png;
    Result := pngHeader.Count-1;
  finally
    png.Free;
  end;
end;

procedure TfrmMain._SyncTime;
var
  ini : TMemIniFile;
begin
  try
    sntp.Host := av.sSNTPHost;
    sntp.Connect;
    if sntp.Connected then
    begin
      sntp.SyncTime;
      ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
      try
        ini.WriteDateTime('SNTP', 'LastSyncTime', sntp.DateTime);
      finally
        ini.UpdateFile;
        ini.Free;
      end;
    end
    else
      MessageDlg('時刻の同期が出来ませんでした。', '', mtWarning, [mbOK]);
  except
    MessageDlg('Error : _SyncTime', '', mtWarning, [mbOK]);
  end;
end;

end.
