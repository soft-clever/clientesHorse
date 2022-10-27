unit UseCase.Report;

interface

function GerarRelatorio: String;

implementation

uses
  Models.DaoGeneric, Models.Entities.Cliente, System.Generics.Collections,
  Report.Clientes, Service.Utils;

function GerarRelatorio: String;
var
  FDAO: iDAOGeneric<TCliente>;
  clientes: TObjectList<TCliente>;
  report: TfrmRelatoriosClientes;
  util: TUtils;
begin
  FDAO := TDAOGeneric<TCliente>.New;

  clientes := TObjectList<TCliente>.Create();

  FDAO.Find(clientes);

  report := TfrmRelatoriosClientes.Create(nil, util.ObjectListToJsonArray<TCliente>(clientes));
  result := report.GetReport;
end;

end.
