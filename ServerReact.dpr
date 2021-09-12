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
  ServerReact.Model.DAOGeneric in 'src\model\ServerReact.Model.DAOGeneric.pas',
  ServerReact.Controller.Users in 'src\Controller\ServerReact.Controller.Users.pas';

var
  App : THorse;

begin
  App := THorse.Create(9000);

  App.Use(Jhonson);
  //Controller de Entidades
  ServerReact.Controller.USERS.Registry(App);

  App.Start;
end.
