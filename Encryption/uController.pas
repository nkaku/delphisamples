unit uController;

interface

uses
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/api')]
  TMyController = class(TMVCController) 
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);

    [MVCPath('/login/($Password)')]
    [MVCHTTPMethod([httpGET])]
    procedure Login(Password: string);

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, System.Classes,
  System.IOUtils, LbCipher, LbClass;

procedure TMyController.Index;
begin
  //use Context property to access to the HTTP request and response
  Render('Hello DelphiMVCFramework World');
end;

procedure TMyController.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TMyController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TMyController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TMyController.Login(Password: string);
var
  lb3ds1 : TLb3DES;
begin
  lb3ds1 := TLb3DES.Create(nil);
  Render(lb3ds1.DecryptString(Password));
  lb3ds1.Free;
end;

end.
