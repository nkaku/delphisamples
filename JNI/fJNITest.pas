unit fJNITest;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm26 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    edt2: TEdit;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form26: TForm26;

implementation

{$R *.fmx}

uses
  android.JNI.UseAsJAR,
  androidapi.Helpers;

procedure TForm26.btn1Click(Sender: TObject);
begin
  TJUseAsJAR.JavaClass.echoPlease(StringToJString(edt1.Text));
end;

end.
