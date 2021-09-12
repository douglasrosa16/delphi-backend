program ServerReact;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  System.JSON,
  ServerReact.Model.Connection in 'src\model\ServerReact.Model.Connection.pas',
  ServerReact.Model.Entidades.USER in 'src\model\Entidades\ServerReact.Model.Entidades.USER.pas',
  ServerReact.Model.DAOGeneric in 'src\model\ServerReact.Model.DAOGeneric.pas';

var
  App : THorse;

begin
  App := THorse.Create(9000);

  App.Use(Jhonson);

  THorse.Get('/ping',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  begin
    Res.Send('pong');
  end);

  THorse.Get('/users',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  var
    FDAO : iDAOGeneric<TUSER>;
  begin
    ServerReact.Model.Connection.Connected;
    FDAO := TDAOGeneric<TUSER>.New;
    Res.Send<TJsonArray>(FDAO.Find);
  end);

  App.Start;
end.
