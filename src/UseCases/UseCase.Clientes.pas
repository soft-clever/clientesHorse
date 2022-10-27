unit UseCase.Clientes;

interface

uses
  Models.Entities.Cliente, System.Generics.Collections, System.JSON,
  Models.DaoGeneric;

Type
  iClienteUseCase = interface
  ['{3991d99d-526a-421f-b5d2-9e82d412d5b4}']
  function ListarClientes(limit: Integer=20; page: Integer=5): TObjectList<TCliente>;
  function ClienteByID(idCliente: String): TCliente;
  function CreateCliente(json: TJSONObject): TCliente;
  function UpdateCliente(idCliente: String; json: TJsonObject): TCliente;
  procedure DeleteCliente(idCliente: String);
  end;

  TClienteUseCase = class(TInterfacedObject, iClienteUseCase)
  private
    FDAOClientes: iDAOGeneric<TCliente>;
  public
    constructor Create(Value: iDAOGeneric<TCliente>);
    function ListarClientes(limit: Integer=20; page: Integer=5): TObjectList<TCliente>;
    function ClienteByID(idCliente: String): TCliente;
    function CreateCliente(json: TJSONObject): TCliente;
    function UpdateCliente(idCliente: String; json: TJsonObject): TCliente;
    procedure DeleteCliente(idCliente: String);
  end;

implementation

uses
  REST.Json;

function TClienteUseCase.ListarClientes(limit: Integer=20; page: Integer=5): TObjectList<TCliente>;
begin
  result := TObjectList<TCliente>.Create();
  FDAOClientes.Find(result, limit, page);
end;

function TClienteUseCase.ClienteByID(idCliente: String): TCliente;
begin
  result := TCliente.Create;
  FDAOClientes.Find(idCliente, result);
end;

constructor TClienteUseCase.Create(Value: iDAOGeneric<TCliente>);
begin
  FDAOClientes := Value
end;

function TClienteUseCase.CreateCliente(json: TJSONObject): TCliente;
begin
  result := TJSon.JsonToObject<TCliente>(json);
  FDAOClientes.Insert(result);
end;

function TClienteUseCase.UpdateCliente(idCliente: String; json: TJsonObject): TCliente;
begin
  FDAOClientes.Find(idCliente, result);
  result := TJSon.JsonToObject<TCliente>(json);
  FDAOClientes.Update(result);
end;

procedure TClienteUseCase.DeleteCliente(idCliente: String);
var
  cliente: TCliente;
begin
  FDAOClientes.Find(idCliente, cliente);
  FDAOClientes.Delete(cliente);
end;

end.
