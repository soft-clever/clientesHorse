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
  Controller.Cliente in 'src\Controller\Controller.Cliente.pas',
  Models.Entities.Cliente in 'src\Models\Entities\Models.Entities.Cliente.pas',
  Connection.DbConnection in 'src\Connection\Connection.DbConnection.pas',
  Models.DaoGeneric in 'src\Models\Models.DaoGeneric.pas',
  Report.Clientes in 'src\Reports\Report.Clientes.pas' {frmRelatoriosClientes: TFrame},
  Service.Utils in 'src\Services\Service.Utils.pas',
  Route.Clientes in 'src\Routes\Route.Clientes.pas',
  UseCase.Clientes in 'src\UseCases\UseCase.Clientes.pas',
  UseCase.Report in 'src\UseCases\UseCase.Report.pas',
  ListAllClientes.UseCase in 'src\UseCases\ListAllClientes\ListAllClientes.UseCase.pas',
  ListAllClientes.Controller in 'src\UseCases\ListAllClientes\ListAllClientes.Controller.pas',
  ListAllClientes in 'src\UseCases\ListAllClientes\ListAllClientes.pas',
  ClienteById.UseCase in 'src\UseCases\ClienteByID\ClienteById.UseCase.pas',
  ClienteById.Controller in 'src\UseCases\ClienteByID\ClienteById.Controller.pas',
  ClienteById in 'src\UseCases\ClienteByID\ClienteById.pas',
  UpdateCliente.Controller in 'src\UseCases\UpdateCliente\UpdateCliente.Controller.pas',
  UpdateCliente in 'src\UseCases\UpdateCliente\UpdateCliente.pas',
  UpdateCliente.UseCase in 'src\UseCases\UpdateCliente\UpdateCliente.UseCase.pas';

var
  App: THorse;
  DaoClientes: iDAOGeneric<TCliente>;
  ClienteUseCase: iClienteUseCase;
  ClienteController: iClienteController;
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
        .Name('fgom-dev')
        .URL('https://www.github.com/fgom-dev')
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
