unit SampleForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Toast
  {$IFDEF ANDROID}
  ,Androidapi.Helpers
  ,Androidapi.JNI.JavaTypes
  ,Androidapi.JNI.Provider
  ,Androidapi.JNI.App
  ,Androidapi.JNI.OS
  ,Androidapi.JNIBridge
  {$ENDIF}
  ;

type
  TForm25 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    fmxtst1: TFMXToast;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
{$IFDEF ANDROID}
    function GetPhoneTimeOut: Integer;
    procedure Buzz(Interval: Integer);
{$ENDIF}
  end;

var
  Form25: TForm25;

implementation

{$R *.fmx}

procedure TForm25.btn1Click(Sender: TObject);
begin
  fmxtst1.ToastMessage := 'abc';
  fmxtst1.Delay := 10;
  fmxtst1.Show(Self);
end;

{$IFDEF ANDROID}
procedure TForm25.Buzz(Interval: Integer);
var
  VibratorObj: JObject;
  Vibrator: JVibrator;
begin
  VibratorObj := SharedActivity.getSystemService(TJActivity.JavaClass.VIBRATOR_SERVICE);
  Vibrator := TJVibrator.Wrap((VibratorObj as ILocalObject).GetObjectID);
  Vibrator.vibrate(1000);
end;

function TForm25.GetPhoneTimeOut: Integer;
begin
  Result := JStringToString(TJSettings_System.JavaClass.SCREEN_OFF_TIMEOUT).ToInteger;
end;
{$ENDIF}

end.
