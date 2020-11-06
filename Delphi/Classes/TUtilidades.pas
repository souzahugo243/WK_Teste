unit TUtilidades;
{
  Inicio       Autor  Motivo / Assunto
  05/11/2020   Hugo   Classe criada para ajudar com algumas validacoes e
                      localizações de dados.
}
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_ModeloConsulta1, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, System.UITypes, Datasnap.DBClient;

 type
 {}
    TUtilidadesDia = class(TObject)

    private
    { Declarações Privadas }

    public
    { Declarações Públicas }
     function  localizaNomeCliente(const ACodigoCliente : Real): String;
     function  localizaNomeProduto(const ACodigoProduto : Real): String;
     function  GravaPedido(const ANumeroPedido, ACodigoCliente, AValorTotal: Real; const ADataSet : TClientDataSet): Boolean;
     function  DeletaArvorePedido(const ANumeroPedido: Real): Boolean;
    end;

implementation

uses
   DataModuleConexao;
{ TUtilidadesDia }

function TUtilidadesDia.DeletaArvorePedido(const ANumeroPedido: Real): Boolean;
begin
   Result := False;
   if not DTM_Conexao.Conexao.InTransaction then
    DTM_Conexao.Conexao.StartTransaction;
  try

   with TFDQuery.Create(Nil) do
   begin
    try
     Connection := DTM_Conexao.Conexao;
     SQL.Add('DELETE FROM PEDIDOS_PRODUTOS WHERE NUMERO_PEDIDO = :PEDIDO ');
     ParamByName('PEDIDO').AsFloat := ANumeroPedido;
     ExecSQL;
     Result := True;
    finally
     Free;
    end;
   end;
   Result := False;
   with TFDQuery.Create(Nil) do
   begin
    try
     Connection := DTM_Conexao.Conexao;
     SQL.Add('DELETE FROM DADOS_GERAIS_PEDIDO WHERE NUMERO_PEDIDO = :PEDIDO ');
     ParamByName('PEDIDO').AsFloat := ANumeroPedido;
     ExecSQL;
     Result := True;
    finally
     Free;
    end;
   end;

   DTM_Conexao.Conexao.Commit;
  except
  on E: Exception do
    begin
      DTM_Conexao.Conexao.Rollback;
      ShowMessage('Ocorreu um Erro Ao Excluir os dados do Pedido: ' + E.Message );
    Abort;
    end;
  end;
end;

function TUtilidadesDia.GravaPedido(const ANumeroPedido, ACodigoCliente,
  AValorTotal: Real; const ADataSet : TClientDataSet): Boolean;
begin
  try
   Result := False;
   if not DTM_Conexao.Conexao.InTransaction then
    DTM_Conexao.Conexao.StartTransaction;

    with TFDQuery.Create(nil) do
    begin
     try
      Connection := DTM_Conexao.Conexao;
      SQL.Add(' INSERT INTO DADOS_GERAIS_PEDIDO(NUMERO_PEDIDO,    ' +
              '                                 CODIGO_CLIENTE,   ' +
              '                                 VALOR_TOTAL)      ' +
              '                          VALUES(:NUMERO_PEDIDO,   ' +
              '                                 :CODIGO_CLIENTE,  ' +
              '                                 :VALOR_TOTAL)     ' );
      ParamByName('NUMERO_PEDIDO').AsFloat  := ANumeroPedido;
      ParamByName('CODIGO_CLIENTE').AsFloat := ACodigoCliente;
      ParamByName('VALOR_TOTAL').AsFloat    := AValorTotal;
      ExecSQL;
      Result := True;
     finally
      Free;
     end;
    end;
    Result := False;
    ADataSet.First;
    while not (ADataSet.Eof) do
    begin
     with TFDQuery.Create(nil) do
     begin
     try
      Connection := DTM_Conexao.Conexao;
      SQL.Add(' INSERT INTO PEDIDOS_PRODUTOS(NUMERO_PEDIDO,     ' +
              '                              CODIGO_PRODUTO,    ' +
              '                              QUANTIDADE,        ' +
              '                              VALOR_UNITARIO,    ' +
              '                              VALOR_TOTAL)       ' +
              '                       VALUES(:NUMERO_PEDIDO,    ' +
              '                              :CODIGO_PRODUTO,   ' +
              '                              :QUANTIDADE,       ' +
              '                              :VALOR_UNITARIO,   ' +
              '                              :VALOR_TOTAL)      ' );
      ParamByName('NUMERO_PEDIDO').AsFloat  := ANumeroPedido;
      ParamByName('CODIGO_PRODUTO').AsFloat := ADataSet.FieldByName('CodigoProduto').AsInteger;;
      ParamByName('QUANTIDADE').AsInteger   := ADataSet.FieldByName('QUANTIDADE').AsInteger;
      ParamByName('VALOR_UNITARIO').AsFloat := ADataSet.FieldByName('Valor_Unitario').AsFloat;
      ParamByName('VALOR_TOTAL').AsFloat    := ADataSet.FieldByName('Valor_Total').AsFloat;
      ExecSQL;
      Result := True;
      finally
      Free;
      end;

     ADataSet.Next;
     end;
    end;

  DTM_Conexao.Conexao.Commit;
  except
  on E: Exception do
    begin
      DTM_Conexao.Conexao.Rollback;
      ShowMessage('Ocorreu um Erro Ao Gravar o Pedido: ' + E.Message );
    Abort;
    end;
  end;
end;

function TUtilidadesDia.localizaNomeCliente(const ACodigoCliente: Real): String;
begin
 Result := EmptyStr;
 with TFDQuery.Create(Nil) do
 begin
   try
    Connection := DTM_Conexao.Conexao;
    SQL.Add(' SELECT NOME             ' +
            '   FROM CLIENTES         ' +
            '  WHERE CODIGO = :CODIGO ');
    ParamByName('CODIGO').AsFloat := ACodigoCliente;
    Open;
    Result := Fields[0].AsString;
   finally
    Free;
   end;
 end;
end;

function TUtilidadesDia.localizaNomeProduto(const ACodigoProduto: Real): String;
begin
 Result := EmptyStr;
 with TFDQuery.Create(Nil) do
 begin
   try
    Connection := DTM_Conexao.Conexao;
    SQL.Add(' SELECT DESCRICAO        ' +
            '   FROM PRODUTOS         ' +
            '  WHERE CODIGO = :CODIGO ');
    ParamByName('CODIGO').AsFloat := ACodigoProduto;
    Open;
    Result := Fields[0].AsString;
   finally
    Free;
   end;
 end;
end;

end.
