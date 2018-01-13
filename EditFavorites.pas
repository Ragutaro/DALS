unit EditFavorites;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.StdCtrls, HideListBox, TB2Item, SpTBXItem, TB2Toolbar,
  TB2Dock;

type
  TfrmEditFavorites = class(TForm)
    lstList: THideListBox;
    SpTBXToolWindow1: TSpTBXToolWindow;
    SpTBXToolbar1: TSpTBXToolbar;
    btnDelete: TSpTBXItem;
    btnSave: TSpTBXItem;
    SpTBXToolWindow2: TSpTBXToolWindow;
    SpTBXToolbar2: TSpTBXToolbar;
    btnUp: TSpTBXItem;
    btnDown: TSpTBXItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _LoadFavorites;
    procedure _SaveFavorites;
  public
    { Public 宣言 }
  end;

var
  frmEditFavorites: TfrmEditFavorites;

implementation

{$R *.dfm}

uses
  HideUtils,
  Main,
  dp;

procedure TfrmEditFavorites.btnDeleteClick(Sender: TObject);
begin
  lstList.DeleteSelected;
end;

procedure TfrmEditFavorites.btnDownClick(Sender: TObject);
begin
  lstList.DownListItem;
end;

procedure TfrmEditFavorites.btnSaveClick(Sender: TObject);
begin
  _SaveFavorites;
  Close;
end;

procedure TfrmEditFavorites.btnUpClick(Sender: TObject);
begin
  lstList.UpListItem;
end;

procedure TfrmEditFavorites.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _SaveSettings;
  Release;
  frmEditFavorites := nil;   //フォーム名に変更する
end;

procedure TfrmEditFavorites.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
  _LoadFavorites;
end;

procedure TfrmEditFavorites.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmEditFavorites._LoadFavorites;
var
  ini : TMemIniFile;
  sl : TStringList;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  sl := TStringList.Create;
  try
    sl.CommaText := ini.ReadString('frmMain', 'Favorites', '');
    lstList.Items.AddStrings(sl);
  finally
    ini.Free;
    sl.Free;
  end;
end;

procedure TfrmEditFavorites._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindowPosition(Self.Name, Self);
    Self.Font.Name := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size := ini.ReadInteger('General', 'FontSize', 10);
  finally
    ini.Free;
  end;
end;

procedure TfrmEditFavorites._SaveFavorites;
var
  ini : TMemIniFile;
  s : String;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    s := lstList.Items.CommaText;
    ini.WriteString('frmMain', 'Favorites', s);
  finally
    ini.UpdateFile;
    ini.Free;
  end;
end;

procedure TfrmEditFavorites._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindowPosition(Self.Name, Self);
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

end.
