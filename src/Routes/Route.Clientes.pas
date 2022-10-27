unit Route.Clientes;

interface

uses
  Horse;

procedure Registry(App: THorse);

implementation

uses
  ListAllClientes, ClienteById, CreateCliente, UpdateCliente;


procedure Registry(App: THorse);
begin
  App.Get('/clientes', ListAllClientes.GetController.handle);
  App.Get('/clientes/:id', ClienteById.GetController.handle);
  App.Post('/clientes', CreateCliente.getController.handle);
  App.Put('/clientes/:id', UpdateCliente.GetController.handle);
end;


end.
