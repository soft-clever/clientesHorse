unit Connection.DbConnection;

interface

uses
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  System.Generics.Collections;

var
  FDriver : TFDPhysMySQLDriverLink;
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(Index : Integer);

implementation

function Connected : Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);
  FConnList.Items[Result].Params.DriverID := 'MySQL';
  FConnList.Items[Result].Params.Database := 'teste_horse';
  FConnList.Items[Result].Params.UserName := 'softclever';
  FConnList.Items[Result].Params.Password := 'soft@1973';
  FConnList.Items[Result].Params.Values['Server'] := 'localhost';
  FConnList.Items[Result].Params.Values['Port'] := '3306';
  FConnList.Items[Result].Connected;
end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
  FConnList.TrimExcess;
end;

end.
