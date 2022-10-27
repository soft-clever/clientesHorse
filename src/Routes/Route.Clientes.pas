unit Route.Clientes;

interface

uses
  Horse;

procedure Registry(App: THorse);

implementation

uses
  ListAllClientes, ClienteById, UpdateCliente, DeleteCliente;


procedure Registry(App: THorse);
begin
  App.Get('/clientes', ListAllClientes.GetController.handle);
  App.Get('/clientes/:id', ClienteById.GetController.handle);
  App.Put('/clientes/:id', UpdateCliente.GetController.handle);
  App.Delete('/clientes/:id', DeleteCliente.GetController.handle);
end;


end.
