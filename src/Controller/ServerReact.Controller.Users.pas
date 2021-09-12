unit ServerReact.Controller.Users;

interface

uses
  Horse,
  System.JSON,
  ServerReact.Model.DAOGeneric,
  ServerReact.Model.Entidades.USER;

procedure Registry(App : THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry(App : THorse);
begin
  App.Get('/users', Get);
  App.Post('/users', Insert);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
    FDAO := TDAOGeneric<TUSER>.New;
    Res.Send<TJsonArray>(FDAO.Find);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
  FDAO := TDAOGeneric<TUSER>.New;
  Res.Send<TJSONObject>(FDAO.Insert(Req.Body<TJSONObject>));
end;

end.
