unit EditNameList;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.ComCtrls, HideListView, Vcl.StdCtrls, TB2Item, SpTBXItem,
  Vcl.Menus, Vcl.ExtCtrls, VCL.Clipbrd;

type
  TfrmEditNameList = class(TForm)
    lvwList: THideListView;
    btnOK: TButton;
    btnCancel: TButton;
    popLvw: TSpTBXPopupMenu;
    popDelete: TSpTBXItem;
    panEditItem: TPanel;
    Label1: TLabel;
    edtBefore: TEdit;
    Label2: TLabel;
    edtAfter: TEdit;
    btnEditOK: TButton;
    btnEditCancel: TButton;
    Shape1: TShape;
    popEdit: TSpTBXItem;
    Label3: TLabel;
    popCopyDALS: TSpTBXItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure popDeleteClick(Sender: TObject);
    procedure lvwListDblClick(Sender: TObject);
    procedure btnEditOKClick(Sender: TObject);
    procedure btnEditCancelClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure lvwListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvwListColumnClick(Sender: TObject; Column: TListColumn);
    procedure popCopyDALSClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _LoadNameList;
    procedure _SaveNameList;
    procedure _EditItem;
  public
    { Public 宣言 }
  end;

var
  frmEditNameList: TfrmEditNameList;

implementation

{$R *.dfm}

uses
  HideUtils,
  Main,
  dp;

procedure TfrmEditNameList.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditNameList.btnEditCancelClick(Sender: TObject);
begin
  panEditItem.Visible := False;
  lvwList.Enabled := True;
  btnOK.Enabled := True;
  btnCancel.Enabled := True;
end;

procedure TfrmEditNameList.btnEditOKClick(Sender: TObject);
begin
  lvwList.Selected.SubItems[0] := Trim(edtAfter.Text);
  panEditItem.Visible := False;
  lvwList.Enabled := True;
  btnOK.Enabled := True;
  btnCancel.Enabled := True;
end;

procedure TfrmEditNameList.btnOKClick(Sender: TObject);
begin
  _SaveNameList;
  Close;
end;

procedure TfrmEditNameList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _SaveSettings;
  Release;
  frmEditNameList := nil;   //フォーム名に変更する
end;

procedure TfrmEditNameList.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
  _LoadNameList;
end;

procedure TfrmEditNameList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmEditNameList.lvwListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  lvwList.ColumnClickEx(Column, True);
end;

procedure TfrmEditNameList.lvwListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  DefaultDraw := True;
  lvwList.SetListitemBackgroundColor(Item, $00FEFAF8, False, DefaultDraw);
  with lvwList.Canvas do
  begin
    if cdsHot in State then
    begin
      Brush.Color := clHover;
      Brush.Style := bsSolid;
      Font.Style  := [fsUnderline];
      Font.Color  := clRed;
    end;
  end;
end;

procedure TfrmEditNameList.lvwListDblClick(Sender: TObject);
begin
  _EditItem;
end;

procedure TfrmEditNameList.popCopyDALSClick(Sender: TObject);
var
  item : TListItem;
begin
  item := lvwList.Selected;
  if item <> nil then
    Clipboard.AsText := item.SubItems[0];
end;

procedure TfrmEditNameList.popDeleteClick(Sender: TObject);
begin
  lvwList.DeleteAllSelectedItems;
end;

procedure TfrmEditNameList.popEditClick(Sender: TObject);
begin
  _EditItem;
end;

procedure TfrmEditNameList._EditItem;
var
  item : TListItem;
begin
  item := lvwList.Selected;
  if item <> nil then
  begin
    lvwList.Enabled := False;
    btnOK.Enabled := False;
    btnCancel.Enabled := False;
    edtBefore.Text := item.Caption;
    edtAfter.Text := item.SubItems[0];
    panEditItem.Visible := True;
  end;
end;

procedure TfrmEditNameList._LoadNameList;
var
  sl : TStringList;
  item : TListItem;
  i : Integer;
  s1, s2 : String;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(av.sFILE_CONVERTLIST, TEncoding.UTF8);
    for i := 0 to sl.Count-1 do
    begin
      if Pos('=', sl[i]) > 0 then
      begin
        SplitStringsToAandB(sl[i], '=', s1, s2);
        item := lvwList.Items.Add;
        item.Caption := s1;
        item.SubItems.Add(s2);
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfrmEditNameList._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindowPosition(Self.Name, Self);
    lvwList.Column[0].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    lvwList.Column[1].Width := ini.ReadInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    Self.Font.Name := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size := ini.ReadInteger('General', 'FontSize', 10);
  finally
    ini.Free;
  end;
end;

procedure TfrmEditNameList._SaveNameList;
var
  ini : TMemIniFile;
  item : TListItem;
  i : Integer;
begin
  ini := TMemIniFile.Create(av.sFILE_CONVERTLIST, TEncoding.UTF8);
  try
    ini.EraseSection('Name');
    ini.Encoding := TEncoding.UTF8;
    for i := 0 to lvwList.Items.Count-1 do
    begin
      item := lvwList.Items[i];
      ini.WriteString('Name', item.Caption, item.SubItems[0]);
    end;
  finally
    ini.UpdateFile;
    ini.Free;
  end;
end;

procedure TfrmEditNameList._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindowPosition(Self.Name, Self);
    ini.WriteInteger(Self.Name, 'lvwList.Column[0].Width', lvwList.Column[0].Width);
    ini.WriteInteger(Self.Name, 'lvwList.Column[1].Width', lvwList.Column[1].Width);
    ini.WriteString('General', 'FontName', Self.Font.Name);
    ini.WriteInteger('General', 'FontSize', Self.Font.Size);
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

end.
