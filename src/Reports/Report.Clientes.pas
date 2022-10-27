unit Report.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass,
  Models.Entities.Cliente, System.JSON, DataSetConverter4D.Impl, Datasnap.DBClient,
  Data.DB, frxExportBaseDialog, frxExportPDF, frxTableObject;

type
  TfrmRelatoriosClientes = class(TFrame)
    report: TfrxReport;
    dataSet: TfrxUserDataSet;
    frxPDFExport: TfrxPDFExport;
    constructor Create(AOwner: TComponent; data: TJSONArray); overload;
    procedure dataSetGetValue(const VarName: string; var Value: Variant);
    function GetReport: String;
    procedure dataSetCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure dataSetFirst(Sender: TObject);
    procedure dataSetNext(Sender: TObject);
    procedure dataSetPrior(Sender: TObject);
    private
      FData: TClientDataSet;
  end;

implementation

{$R *.dfm}

constructor TfrmRelatoriosClientes.Create(AOwner: TComponent; data: TJSONArray);
begin
  inherited Create(AOwner);
  FData := TClientDataSet.Create(nil);
  Fdata.FieldDefs.Add('id', ftInteger);
  Fdata.FieldDefs.Add('codigo', ftString, 255);
  Fdata.FieldDefs.Add('nome', ftString, 255);
  Fdata.FieldDefs.Add('sobrenome', ftString, 255);
  Fdata.FieldDefs.Add('cpf', ftString, 255);
  FData.CreateDataSet;
  TConverter.New.JSON.Source(data).ToDataSet(FData);
end;

procedure TfrmRelatoriosClientes.dataSetCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof := FData.Eof;
end;

procedure TfrmRelatoriosClientes.dataSetFirst(Sender: TObject);
begin
  FData.First;
end;

procedure TfrmRelatoriosClientes.dataSetGetValue(const VarName: string;
  var Value: Variant);
begin
  if VarName = 'Id' then
    Value := FData.FieldByName('Id').AsString;
  if VarName = 'Codigo' then
    Value := FData.FieldByName('Codigo').AsString;
  if VarName = 'Nome' then
    Value := FData.FieldByName('Nome').AsString;
  if VarName = 'Sobrenome' then
    Value := FData.FieldByName('Sobrenome').AsString;
  if VarName = 'Cpf' then
    Value := FData.FieldByName('Cpf').AsString;
end;

procedure TfrmRelatoriosClientes.dataSetNext(Sender: TObject);
begin
  FData.Next;
end;

procedure TfrmRelatoriosClientes.dataSetPrior(Sender: TObject);
begin
  FData.Prior;
end;

function TfrmRelatoriosClientes.GetReport: String;
begin
  report.PrintOptions.ShowDialog := False;
  report.ShowProgress := False;
  frxPDFExport.ShowDialog := False;
  frxPDFExport.ShowProgress := False;
  report.LoadFromFile('C:\Projetos\clientes\testeReport.fr3');
  frxPDFExport.FileName := ExtractFilePath(Application.ExeName) + '\RelatorioTeste.pdf';
  report.PrepareReport();
  report.Export(frxPDFExport);
  result := frxPDFExport.FileName;
end;

end.
