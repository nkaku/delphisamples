program prjJNITest;

uses
  System.StartUpCopy,
  FMX.Forms,
  fJNITest in 'fJNITest.pas' {Form26},
  android.JNI.UseAsJAR in 'android.JNI.UseAsJAR.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm26, Form26);
  Application.Run;
end.
