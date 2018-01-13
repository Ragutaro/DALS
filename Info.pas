unit Info;
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.StrUtils, IniFilesDX, System.IOUtils, System.Types,
  Vcl.Filectrl, Vcl.StdCtrls;

type
  TfrmInfo = class(TForm)
    btnOK: TButton;
    staInfo: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  frmInfo: TfrmInfo;

implementation

{$R *.dfm}

uses
  HideUtils,
  mmsystem,
  Main,
  dp;

procedure TfrmInfo.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
  frmInfo := nil;   //フォーム名に変更する
end;

procedure TfrmInfo.FormCreate(Sender: TObject);
begin
  DisableVclStyles(Self);
  sndPlaySoundW(PWideChar(av.sSound), SND_ASYNC);
end;

end.
