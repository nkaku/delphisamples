unit unitDBStuff;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

procedure CreateGlobalDBConnection;

procedure CreateGlobalQuery;

procedure DestroyAllDBSTuff;

var
  GlobalConnection: TFDConnection;
  GlobalQuery: TFDQuery;

implementation

uses
  System.SysUtils;

procedure DestroyAllDBSTuff;
begin
  if Assigned(GlobalQuery) then
  begin
    GlobalQuery.Close;
    GlobalQuery.Free;
  end;

  if Assigned(GlobalConnection) then
  begin
    GlobalConnection.Connected := False;
    GlobalConnection.Free;
  end;
end;

procedure CreateGlobalDBConnection;
begin
  GlobalConnection := TFDConnection.Create(nil);
  GlobalConnection.Params.AddPair('Database', 'peterwilliams');
  GlobalConnection.Params.AddPair('DriverID', 'MySQL');
  GlobalConnection.Params.AddPair('User_Name', 'root');
  GlobalConnection.LoginPrompt := False;
  GlobalConnection.Connected := True;
end;

procedure CreateGlobalQuery;
begin
  if not Assigned(GlobalConnection) then
    raise Exception.Create('Global connection not found.');


  GlobalQuery := TFDQuery.Create(nil);
  GlobalQuery.Connection := GlobalConnection;
end;

initialization
  CreateGlobalDBConnection;
  CreateGlobalQuery;


finalization
  DestroyAllDBSTuff;

end.
