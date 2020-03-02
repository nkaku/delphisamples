unit controllerListingTypes;

interface

uses
  MVCFramework, MVCFramework.Commons;

type
  [MVCPath('/listingtypes/')]
  TListingTypeController = class(TMVCController)
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);

    [MVCPath('/getAllRecords')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAllRecords;

    [MVCPath('/insertListingType')]
    [MVCHTTPMethod([httpPOST])]
    procedure InsertListingType;




  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, unitDBStuff, SynVirtualDataSet,
  System.JSON;

procedure TListingTypeController.Index;
begin
  //use Context property to access to the HTTP request and response
  Render('In listing types method');
end;

procedure TListingTypeController.InsertListingType;
var
  Data: string;
  JO: TJSONObject;
  V1,
  V2: string;
begin
  Data := Context.Request.Headers['JSONData'];
  JO := TJSONObject.ParseJSONValue(Data) as TJSONObject;
  V1 := JO.Values['LISTINGTYPE'].Value;
  V2 := JO.Values['REMARKS'].Value;

  GlobalQuery.Close;
  GlobalQuery.SQL.Text := 'insert into plistingtype (LISTINGTYPE, REMARKS) values ('
                          + QuotedStr(V1) + ',' + QuotedStr(V2) + ')';
  GlobalQuery.ExecSQL;

end;

procedure TListingTypeController.GetAllRecords;
begin
  GlobalQuery.Close;
  GlobalQuery.SQL.Text := 'select * from plistingtype';
  GlobalQuery.Open;

  Render(DataSetToJSON(GlobalQuery));
end;

procedure TListingTypeController.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TListingTypeController.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TListingTypeController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;



end.
