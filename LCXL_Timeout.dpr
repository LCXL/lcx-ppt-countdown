program LCXL_Timeout;

uses
  Forms,
  untMain in 'untMain.pas' {frmMain},
  untSet in 'untSet.pas' {frmSet},
  untIni in 'untIni.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PPT¼ÆÊ±±í';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
