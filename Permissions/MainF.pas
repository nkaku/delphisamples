unit MainF;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Actions, FMX.ActnList,
  FMX.StdActns, FMX.MediaLibrary.Actions, FMX.Objects, System.Permissions;

type
  TForm25 = class(TForm)
    btn1: TButton;
    actlst1: TActionList;
    act1: TTakePhotoFromLibraryAction;
    btn2: TButton;
    act2: TTakePhotoFromCameraAction;
    img1: TImage;
    procedure act1DidFinishTaking(Image: TBitmap);
    procedure act2DidFinishTaking(Image: TBitmap);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    AllowCamera,
    AllowReadStorage,
    AllowWriteStorage     : string;
    procedure CameraPermissionResults(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure LibraryPermissionResults(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

{$R *.fmx}

uses
  FMX.DialogService

  {$IFDEF ANDROID}
  , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.Jni.Os
  {$ENDIF}
  ;

procedure TForm25.CameraPermissionResults(Sender: TObject; const APermissions: TArray<string>;
    const AGrantResults: TArray<TPermissionStatus>);
begin
  if Length(AGrantResults) = 3 then
    if  (AGrantResults[0] = TPermissionStatus.Granted) and
        (AGrantResults[1] = TPermissionStatus.Granted) and
        (AGrantResults[2] = TPermissionStatus.Granted) then
      act2.Execute
    else
      TDialogService.ShowMessage('Cannot access camera.');
end;

procedure TForm25.LibraryPermissionResults(Sender: TObject; const APermissions: TArray<string>;
    const AGrantResults: TArray<TPermissionStatus>);
begin
  if Length(AGrantResults) = 2 then
    if  (AGrantResults[0] = TPermissionStatus.Granted) and
        (AGrantResults[1] = TPermissionStatus.Granted) then
      act1.Execute
    else
      TDialogService.ShowMessage('Cannot access library.');
end;

procedure TForm25.act1DidFinishTaking(Image: TBitmap);
begin
  img1.Bitmap.Assign(Image);
end;

procedure TForm25.act2DidFinishTaking(Image: TBitmap);
begin
  img1.Bitmap.Assign(Image);
end;

procedure TForm25.btn1Click(Sender: TObject);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions(
    [
      AllowReadStorage,
      AllowWriteStorage
    ],
    LibraryPermissionResults);
  {$ENDIF}
end;

procedure TForm25.btn2Click(Sender: TObject);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions(
    [
      AllowCamera,
      AllowReadStorage,
      AllowWriteStorage
    ],
    CameraPermissionResults);
  {$ENDIF}
end;

procedure TForm25.FormActivate(Sender: TObject);
begin
  {$IFDEF ANDROID}
  AllowCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  AllowReadStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  AllowWriteStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  {$ENDIF}
end;

end.