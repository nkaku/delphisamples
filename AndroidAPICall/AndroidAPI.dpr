program AndroidAPI;

uses
  System.StartUpCopy,
  FMX.Forms,
  SampleForm in 'SampleForm.pas' {Form25};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm25, Form25);
  Application.Run;
end.
