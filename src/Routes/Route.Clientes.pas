unit Route.Clientes;

interface

uses
  Horse;

procedure Registry(App: THorse);

implementation

uses
<<<<<<< HEAD
  ListAllClientes, ClienteById, CreateCliente;
=======
  ListAllClientes, ClienteById, UpdateCliente;
>>>>>>> 3d58321d19bb7904852e38ac192023550fe160c2


procedure Registry(App: THorse);
begin
  App.Get('/clientes', ListAllClientes.GetController.handle);
  App.Get('/clientes/:id', ClienteById.GetController.handle);
<<<<<<< HEAD
  App.Post('/clientes', CreateCliente.getController.handle);
=======
  App.Put('/clientes/:id', UpdateCliente.GetController.handle);
>>>>>>> 3d58321d19bb7904852e38ac192023550fe160c2
end;


end.
