unit NewName;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmNewName = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNew: TEdit;
    edtCurrent: TEdit;
    StaticText1: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
    procedure _Execute;
  public
    { Public 宣言 }
  end;

var
  frmNewName: TfrmNewName;

implementation

{$R *.dfm}

uses
  HideUtils,
  Main,
  dp;

procedure TfrmNewName.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNewName.btnOKClick(Sender: TObject);
begin
  _Execute;
  Close;
end;

procedure TfrmNewName.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _SaveSettings;
  Release;
  frmNewName := nil;   //フォーム名に変更する
end;

procedure TfrmNewName.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
end;

procedure TfrmNewName._Execute;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(av.sFILE_CONVERTLIST, TEncoding.UTF8);
  try
    ini.WriteString('Name', edtCurrent.Text, edtNew.Text);
  finally
    ini.UpdateFile;
    ini.Free;
  end;
end;

procedure TfrmNewName._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindow(Self.Name, Self);
    Self.Font.Name := ini.ReadString('General', 'FontName', 'メイリオ');
    Self.Font.Size := ini.ReadInteger('General', 'FontSize', 10);
  finally
    ini.Free;
  end;
end;

procedure TfrmNewName._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteWindow(Self.Name, Self);
    ini.WriteString('General', 'FontName', Self.Font.Name);
    ini.WriteInteger('General', 'FontSize', Self.Font.Size);
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

end.
