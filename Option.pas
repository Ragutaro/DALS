unit Option;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.StdCtrls, SpTBXEditors, SpTBXExtEditors, Vcl.ExtCtrls,
  HideEdit;

type
  TfrmOption = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    chkEnableSNTP: TCheckBox;
    edtSNTP: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cmbFont: TSpTBXFontComboBox;
    edtFontSize: TEdit;
    edtTimeout: TEdit;
    edtSound: TButtonedEdit;
    edtInform: TEdit;
    edtDelTime: TEdit;
    edtGetData: THideEditW;
    OpenDialog: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtSoundRightButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private 宣言 }
    procedure _LoadSettings;
    procedure _SaveSettings;
  public
    { Public 宣言 }
  end;

var
  frmOption: TfrmOption;

implementation

{$R *.dfm}

uses
  HideUtils,
  Main,
  dp;

procedure TfrmOption.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOption.btnOKClick(Sender: TObject);
begin
  _SaveSettings;
  Close;
end;

procedure TfrmOption.edtSoundRightButtonClick(Sender: TObject);
begin
  OpenDialog.InitialDir := 'C:\Windows\Media';
  OpenDialog.Filter := 'WAVファイル|*.wav';
  if OpenDialog.Execute then
    edtSound.Text := OpenDialog.FileName;
end;

procedure TfrmOption.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
  frmOption := nil;   //フォーム名に変更する
end;

procedure TfrmOption.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self, '');
  _LoadSettings;
  Self.ClientHeight := 447;
end;

procedure TfrmOption.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmOption._LoadSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.ReadWindow(Self.Name, Self);
    chkEnableSNTP.Checked := ini.ReadBool('SNTP', 'Enabled', True);
    edtSNTP.Text          := ini.ReadString('SNTP', 'HostName', 'ntp.jst.mfeed.ad.jp');
    cmbFont.Text          := ini.ReadString('General', 'FontName', 'メイリオ');
    edtFontSize.Text      := ini.ReadString('General', 'FontSize', '10');
    edtGetData.Text       := ini.ReadString('General', 'DownloadTime', '09:00;20:00;');
    edtInform.Text        := ini.ReadString('General', 'InformTime', '10');
    edtDelTime.Text       := ini.ReadString('General', 'DeletionTime', '10');
    edtSound.Text         := ini.ReadString('General', 'Sound', 'C:\Windows\Media\Ring04.wav');
    edtTimeout.Text       := IntToStr(ini.ReadInteger(Self.Name, 'timFailed.Interval', 20000) div 1000);
    Self.Font.Name        := cmbFont.Text;
    Self.Font.Size        := StrToInt(edtFontSize.Text);
  finally
    ini.Free;
  end;
end;

procedure TfrmOption._SaveSettings;
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create(GetIniFileName, TEncoding.Unicode);
  try
    ini.WriteBool('SNTP', 'Enabled', chkEnableSNTP.Checked);
    ini.WriteString('SNTP', 'HostName', edtSNTP.Text);
    ini.WriteString('General', 'FontName', cmbFont.Text);
    ini.WriteString('General', 'FontSize', edtFontSize.Text);
    ini.WriteString('General', 'DownloadTime', Trim(edtGetData.Text));
    ini.WriteString('General', 'InformTime', edtInform.Text);
    ini.WriteString('General', 'DeletionTime', edtDelTime.Text);
    ini.WriteString('General', 'Sound', edtSound.Text);
    ini.WriteWindow(Self.Name, Self);
    ini.WriteInteger(Self.Name, 'timFailed.Interval', StrToIntDef(edtTimeout.Text, 0) * 1000);
    frmMain.Font.Name := cmbFont.Text;
    frmMain.Font.Size := StrToInt(edtFontSize.Text);
    av.sDownloadTime := Trim(edtGetData.Text);
    av.iInformTime := StrToIntDef(edtInform.Text, 10);
    av.iDeletionTime := -2 - StrToIntDef(edtDelTime.Text, 10);
    frmMain.timFailed.Interval := StrToIntDef(edtTimeout.Text, 0) * 1000;
  finally
    ini.UpdateFile;
    ini.Free;
  end;
end;

end.
