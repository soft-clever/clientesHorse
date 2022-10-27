unit Models.Entities.Cliente;

interface

uses
  SimpleAttributes, SimpleDAO;

type

  [Tabela('cliente')]
  TCliente = class
  private
    FId: Integer;
    FCodigo: String;
    FNome: String;
    FSobrenome: String;
    FCpf: String;

    procedure SetId(const Value: Integer);
    function GetId: Integer;

    procedure SetCodigo(const Value: String);
    function GetCodigo: String;

    procedure SetNome(const Value: String);
    function GetNome: String;

    procedure SetSobrenome(const Value: String);
    function GetSobrenome: String;

    procedure SetCpf(const Value: String);
    function GetCpf: String;

  public
    constructor Create;

    destructor Destroy; override;

    procedure Limpar;

    [Campo('Id'), PK]
    property Id: Integer read GetId write SetId;

    [Campo('Codigo')]
    property Codigo: String read GetCodigo write SetCodigo;

    [Campo('Nome')]
    property Nome: String read GetNome write SetNome;

    [Campo('Sobrenome')]
    property Sobrenome: String read GetSobrenome write SetSobrenome;

    [Campo('CPF')]
    property Cpf: String read GetCpf write SetCpf;

  end;

implementation

constructor TCliente.Create;
begin
  Limpar;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

function TCliente.GetId: Integer;
begin
  Result := FId;
end;

procedure TCliente.SetCodigo(const Value: String);
begin
  FCodigo := Value;
end;

function TCliente.GetCodigo: String;
begin
  Result := FCodigo;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

function TCliente.GetNome: String;
begin
  Result := FNome;
end;

procedure TCliente.SetSobrenome(const Value: String);
begin
  FSobrenome := Value;
end;

function TCliente.GetSobrenome: String;
begin
  Result := FSobrenome;
end;

procedure TCliente.SetCpf(const Value: String);
begin
  FCpf := Value;
end;

function TCliente.GetCpf: String;
begin
  Result := FCpf;
end;

procedure TCliente.Limpar;
begin
  Self.Id := 0;
  Self.Codigo := '';
  Self.Nome := '';
  Self.Sobrenome := '';
  Self.Cpf := '';
end;

end.
