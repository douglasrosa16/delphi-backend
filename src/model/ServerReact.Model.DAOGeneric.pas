unit ServerReact.Model.DAOGeneric;

interface

uses
  System.JSON,
  REST.Json,
  SimpleInterface,
  SimpleDAO,
  SimpleAttributes,
  SimpleQueryFiredac,
  Data.DB,
  ServerReact.Model.Connection,
  DataSetConverter4D,
  DataSetConverter4D.Impl,
  DataSetConverter4D.Helper,
  DataSetConverter4D.Util;

  type
    iDAOGeneric<T: class> = interface['{E719A822-4B08-43D1-8DF4-799C51A5AE62}']
    function Find: TJsonArray; overload;
    function Find (const aID: string): TJsonObject; overload;
    function Insert (const aJsonObject: TJSONObject): TJsonObject;
    function Update (const aJsonObject : TJsonObject) : TJsonObject;
    function Delete (aField : String; aValue: String) : TJsonObject;
    end;

    TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)
    private
      FConn : iSimpleQuery;
      FDAO : iSimpleDAO<T>;
      FDataSource : TDataSource;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iDAOGeneric<T>;
      function Find: TJsonArray; overload;
      function Find (const aID: string): TJsonObject; overload;
      function Insert (const aJsonObject: TJSONObject): TJsonObject;
      function Update (const aJsonObject : TJsonObject) : TJsonObject;
      function Delete (aField : String; aValue: String) : TJsonObject;
    end;
implementation

uses
  System.SysUtils;

{ TDAOGeneirc<T> }



constructor TDAOGeneric<T>.Create;
begin
  FDataSource := TDataSource.Create(nil);
  ServerReact.Model.Connection.Connected;
  FConn := TSimpleQueryFiredac.New(ServerReact.Model.Connection.FConn);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
end;

function TDAOGeneric<T>.Delete(aField, aValue: String): TJsonObject;
begin
  FDAO.Delete(aField, aValue);
  Result := FDataSource.DataSet.AsJSONObject;
end;

destructor TDAOGeneric<T>.Destroy;
begin
  FDataSource.Free;
  ServerReact.Model.Connection.Disconnected;
  inherited;
end;

function TDAOGeneric<T>.Find(const aID: string): TJsonObject;
begin
  FDAO.Find(StrToInt(aID));
  Result := FDataSource.DataSet.AsJSONObject;
end;

function TDAOGeneric<T>.Find: TJsonArray;
begin
  FDAO.Find;
  Result := FDataSource.DataSet.AsJSONArray;
end;

class function TDAOGeneric<T>.New: iDAOGeneric<T>;
begin
  Result := Self.Create;
end;

function TDAOGeneric<T>.Insert(const aJsonObject: TJSONObject): TJsonObject;
begin
  FDAO.Insert(TJson.JsonToObject<T>(aJsonObject));
  Result := FDataSource.DataSet.AsJSONObject;
end;

function TDAOGeneric<T>.Update(const aJsonObject: TJsonObject): TJsonObject;
begin
  FDAO.Update(TJson.JsonToObject<T>(aJsonObject));
  Result := FDataSource.DataSet.AsJSONObject;
end;

end.
