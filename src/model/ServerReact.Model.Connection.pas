unit ServerReact.Model.Connection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

var
  FConn : TFDConnection;

function Connected: TFDConnection;
procedure Disconnected;

implementation

function Connected: TFDConnection;
begin
  FConn := TFDConnection.Create(nil);
  FConn.Params.DriverID := 'MySQL';
  FConn.Params.Database := 'dbreact';
  FConn.Params.UserName := 'root';
  FConn.Params.Password := '';
  FConn.Params.Add('Port=3306');
  FConn.Params.Add('Server=localhost');
  FConn.Connected;
  Result := FConn;
end;

procedure Disconnected;
begin
  if Assigned(FConn) then
  begin
    FConn.Connected := False;
    FConn.Free;
  end;
end;

end.
