program prjMultires;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMain in 'frmMain.pas' {Form27};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm27, Form27);
  Application.Run;
end.
