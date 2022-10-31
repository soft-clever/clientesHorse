program clientesHorse;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.GBSwagger,
  Horse.Jhonson,
  Horse.CORS,
  Horse.OctetStream,
  System.SysUtils,
  Connection.DbConnection in 'src\Connection\Connection.DbConnection.pas',
  Models.Entities.Cliente in 'src\Modules\Clientes\Models\Entities\Models.Entities.Cliente.pas',
  Route.Clientes in 'src\Modules\Clientes\Routes\Route.Clientes.pas',
  ClienteById.Controller in 'src\Modules\Clientes\UseCases\Clientes\ClienteByID\ClienteById.Controller.pas',
  ClienteById in 'src\Modules\Clientes\UseCases\Clientes\ClienteByID\ClienteById.pas',
  ClienteById.UseCase in 'src\Modules\Clientes\UseCases\Clientes\ClienteByID\ClienteById.UseCase.pas',
  CreateCliente.Controller in 'src\Modules\Clientes\UseCases\Clientes\CreateCliente\CreateCliente.Controller.pas',
  CreateCliente in 'src\Modules\Clientes\UseCases\Clientes\CreateCliente\CreateCliente.pas',
  CreateCliente.UseCase in 'src\Modules\Clientes\UseCases\Clientes\CreateCliente\CreateCliente.UseCase.pas',
  DeleteCliente.Controller in 'src\Modules\Clientes\UseCases\Clientes\DeleteCliente\DeleteCliente.Controller.pas',
  DeleteCliente in 'src\Modules\Clientes\UseCases\Clientes\DeleteCliente\DeleteCliente.pas',
  DeleteCliente.UseCase in 'src\Modules\Clientes\UseCases\Clientes\DeleteCliente\DeleteCliente.UseCase.pas',
  ListAllClientes.Controller in 'src\Modules\Clientes\UseCases\Clientes\ListAllClientes\ListAllClientes.Controller.pas',
  ListAllClientes in 'src\Modules\Clientes\UseCases\Clientes\ListAllClientes\ListAllClientes.pas',
  ListAllClientes.UseCase in 'src\Modules\Clientes\UseCases\Clientes\ListAllClientes\ListAllClientes.UseCase.pas',
  UpdateCliente.Controller in 'src\Modules\Clientes\UseCases\Clientes\UpdateCliente\UpdateCliente.Controller.pas',
  UpdateCliente in 'src\Modules\Clientes\UseCases\Clientes\UpdateCliente\UpdateCliente.pas',
  UpdateCliente.UseCase in 'src\Modules\Clientes\UseCases\Clientes\UpdateCliente\UpdateCliente.UseCase.pas',
  Service.Utils in 'src\Services\Service.Utils.pas',
  Models.DaoGeneric in 'src\Connection\Models.DaoGeneric.pas',
  Endereco.Entity in 'src\Modules\Clientes\Models\Entities\Endereco.Entity.pas';

var
  App: THorse;
begin
  ReportMemoryLeaksOnShutdown := True;

  App := THorse.Create();
  App.Port := 9000;
  App.Use(HorseSwagger);
  App.Use(JHonson);
  App.Use(OctetStream);

  Swagger
    .Info
      .Title('API de Cadastro de Clientes')
      .Description('Realiza operações CRUD')
      .Contact
        .Name('Soft Clever')
        .URL('https://www.github.com/soft-clever')
      .&End
    .&End;

  Route.CLientes.Registry(App);

  App.Listen(
    procedure(Horse: THorse)
    begin
      Writeln('Server is runing on port ' + THorse.Port.ToString);
      Write('Press return to stop...');
      ReadLn;
      App.StopListen;
    end
  );
end.
