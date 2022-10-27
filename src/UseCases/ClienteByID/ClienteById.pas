unit ClienteById;

interface

uses
  ClienteById.Controller;

function GetController: TClienteByIdController;

implementation

uses
  Models.DaoGeneric, Models.Entities.Cliente, ClienteById.UseCase;

function GetController: TClienteByIdController;
var
  DaoClientes: iDAOGeneric<TCliente>;
  ListAllClientesUseCase: iClienteByIdUseCase;
begin
  DaoClientes := TDAOGeneric<TCliente>.Create;
  ListAllClientesUseCase := TClienteByIdUseCase.Create(DaoClientes);
  result := TClienteByIdController.Create(ListAllClientesUseCase);
end;

end.
