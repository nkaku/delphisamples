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

    [MVCPath('/upload')]
    [MVCHTTPMethod([httpPOST])]
    procedure Upload;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(id: Integer);

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer(id: Integer);

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: Integer);

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, System.Classes,
  System.IOUtils;

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

//Sample CRUD Actions for a "Customer" entity
procedure TMyController.GetCustomers;
begin
  //todo: render a list of customers
end;

procedure TMyController.GetCustomer(id: Integer);
begin
  //todo: render the customer by id
end;

procedure TMyController.CreateCustomer;

begin
  //todo: create a new customer
end;

procedure TMyController.UpdateCustomer(id: Integer);
begin
  //todo: update customer by id
end;

procedure TMyController.Upload;
var
  lFName: string;
  I: Integer;
  lFile: TFileStream;
  UploadData: string;
begin

  for I := 0 to Context.Request.RawWebRequest.Files.Count - 1 do
  begin
    lFName := String(Context.Request.Files[I].FileName);
    lFName := TPath.GetFileName(lFName.Trim(['"']));
    if not TPath.HasValidFileNameChars(lFName, false) then
      raise EMVCException.Create
        (lFName + ' is not a valid filename for the hosting OS');
    Log('Uploading ' + lFName);
    lFile := TFile.Create(TPath.Combine('F:\Work\VIMOVYAA\PeterWilliams\Test\StreamSaving\Win32\Debug\files', lFName));
    try
      lFile.CopyFrom(Context.Request.Files[I].Stream, 0);
    finally
      lFile.free;
    end;
  end;

end;

{
procedure TMyController.Upload;
  function Hex16ToString(str: string): string;
  var
    i: Integer;
    code: string;
  begin
    Result := '';
    i := 1;
    while i < Length(str) do begin
      code := Copy(str, i, 4);
      Result := Result + Chr(StrToInt('$' + code));
      Inc(i, 4);
    end;
  end;

var
  MS1,
  MS2: TStringStream;

begin

  MS1 := TStringStream.Create('a', TEncoding.ANSI);
  MS1.Clear;
  MS1.WriteString(Context.Request.Body);

  MS2 := TStringStream.Create('a', TEncoding.ANSI);
  MS2.Clear;
  MS2.WriteString(Hex16ToString(MS1.DataString));
  MS2.SaveToFile('got.jpg');

  MS1.Free;
  MS2.Free;


end;
}

procedure TMyController.DeleteCustomer(id: Integer);
begin
  //todo: delete customer by id
end;



end.
