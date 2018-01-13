program DAZNLS;

uses
  FastMM4,
  Windows,
  Messages,
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  Info in 'Info.pas' {frmInfo},
  untVersion in 'untVersion.pas' {frmVersion},
  Minogashi in 'Minogashi.pas' {frmMinogashi},
  SearchUtils in '..\_Component\SearchUtils.pas',
  EditFavorites in 'EditFavorites.pas' {frmEditFavorites},
  Option in 'Option.pas' {frmOption},
  NewName in 'NewName.pas' {frmNewName},
  EditNameList in 'EditNameList.pas' {frmEditNameList},
  EditIcons in 'EditIcons.pas' {frmEditIcons},
  Debug in 'Debug.pas' {frmDebug};

{$R *.res}

const
 MutexName = '{has_dals}';

var
  hWnd, hDelphi : THandle;
begin
  hWnd := FindWindowW('TfrmMain', 'DAZN Live Schedule');
  hDelphi := FindWindowW('TAppBuilder', nil);
  if (hWnd <> 0) and (hDelphi = 0) then
  begin
    SendMessage(hWnd, WM_SYSCOMMAND, SC_RESTORE, 0);
    SetForegroundWindow(hWnd);
  end
  else
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end;
end.
