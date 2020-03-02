program prjEncrypt;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainF in 'MainF.pas' {Form25};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm25, Form25);
  Application.Run;
end.
