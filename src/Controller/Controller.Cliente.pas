unit Controller.Cliente;

interface

uses
  Horse,
  IdHashMessageDigest,
  Horse.OctetStream,
  REST.Json,
  System.Generics.Collections,
  Report.Clientes,
  GBSwagger.Model.Interfaces, UseCase.Clientes;

Type
  iClienteController = interface
    ['{9ed2c8a9-7aca-41ad-be02-ad066de01a2d}']
    procedure RegistrySwagger(var Swagger: IGBSwagger);
    procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Relatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Registry(App: THorse; var Swagger: IGBSwagger);
  end;

  TClienteController = class(TInterfacedObject, iClienteController)
  private
    FClienteUseCase: iClienteUseCase;

    procedure RegistrySwagger(var Swagger: IGBSwagger);

    procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Relatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  public
    constructor Create(Value: iClienteUseCase);
    procedure Registry(App: THorse; var Swagger: IGBSwagger);
  end;

implementation

uses Models.Entities.Cliente, System.JSON, Service.Utils, UseCase.Report,
  System.Classes;

procedure TClienteController.Registry(App: THorse; var Swagger: IGBSwagger);
begin
  App.Get('/clientes', Get);
  App.Get('/clientes/relatorio', Relatorio);
  App.Get('/clientes/:id', GetID);
  App.Post('/clientes', Insert);
  App.Put('/clientes/:id', Update);
  App.Delete('/clientes/:id', Delete);

  RegistrySwagger(Swagger);
end;

procedure TClienteController.RegistrySwagger(var Swagger: IGBSwagger);
begin
  Swagger
    .Path('clientes')
      .Tag('Clientes')
      .GET('Listar clientes')
        .AddResponse(200, 'Lista de usuários').Schema(TCliente).IsArray(True).&End
      .&End
      .POST('Criar um novo usuário')
        .AddParamBody('Dados do usuário').Required(True).Schema(TCliente).&End
        .AddResponse(201).Schema(TCliente).&End
        .AddResponse(400).&End
      .&End
    .&End;
end;

procedure TClienteController.Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  util: TUtils;
  clientes: TObjectList<TCliente>;
  limit, page: Integer;
begin
  limit := Req.Query.Field('limit').AsInteger;
  page := Req.Query.Field('page').AsInteger;
  clientes := FClienteUseCase.ListarClientes(limit, page);
  Res.Send<TJSonArray>(util.ObjectListToJsonArray<TCliente>(clientes));
  clientes.Free;
end;

procedure TClienteController.GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  util: TUtils;
  cliente: TCliente;
  idCliente: String;
begin
  idCliente := Req.Params.Items['id'];
  cliente := FClienteUseCase.ClienteByID(idCliente);
  Res.Send<TJSONObject>(TJson.ObjectToJsonObject(cliente)).Status(200);
  cliente.Free;
end;

procedure TClienteController.Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  cliente: TCliente;
begin
  cliente := FClienteUseCase.CreateCliente(Req.Body<TJsonObject>);
  try
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(cliente));
  except

  end;
end;

procedure TClienteController.Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  idCliente: string;
  cliente: TCliente;
begin
  idCliente := Req.Params.Items['id'];
  cliente := FClienteUseCase.UpdateCliente(idCliente, Req.Body<TJsonObject>);
  Res.Send<TJSONObject>(TJson.ObjectToJsonObject(cliente)).Status(200);
end;

constructor TClienteController.Create(Value: iClienteUseCase);
begin
  FClienteUseCase := Value;
end;

procedure TClienteController.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  idCliente: string;
  cliente: TCliente;
begin
  idCliente := Req.Params.Items['id'];

  FClienteUseCase.DeleteCliente(idCliente);

  Res.Status(200);
end;

procedure TClienteController.Relatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  stream.LoadFromFile(GerarRelatorio);

  Res.Send<TFileReturn>(TFileReturn.Create('relatorio.pdf', stream));
end;

end.
