unit ListAllClientes.UseCase;

interface

uses
  Models.DaoGeneric, Models.Entities.Cliente, System.Generics.Collections;

type

  TListAllClientesUseCase = class
  private
    FDAOClientes: iDAOGeneric<TCliente>;
  public
    constructor Create(Value: iDAOGeneric<TCliente>);
    function execute(limit: Integer=20; page: Integer=1): TObjectList<TCliente>;
  published
    { published declarations }
  end;

implementation

{ TListAllClientesUseCase }

constructor TListAllClientesUseCase.Create(Value: iDAOGeneric<TCliente>);
begin
  FDAOClientes := Value;
end;

function TListAllClientesUseCase.execute(limit: Integer=20; page: Integer=1): TObjectList<TCliente>;
begin
  result := TObjectList<TCliente>.Create();
  FDAOClientes.Find(result, limit, page);
end;

end.
