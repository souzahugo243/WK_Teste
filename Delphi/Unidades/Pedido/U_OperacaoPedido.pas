unit U_OperacaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TF_OperacaoPedido = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Q_Dados: TFDQuery;
    DS_Dados: TDataSource;
    Label4: TLabel;
    EDT_NumeroPedido: TEdit;
    BTN_Localizar: TSpeedButton;
    Label3: TLabel;
    LBL_Cliente: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    BTN_Excluir: TSpeedButton;
    procedure BTN_LocalizarClick(Sender: TObject);
    procedure EDT_NumeroPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BTN_ExcluirClick(Sender: TObject);
  private
    { Private declarations }
    function  verificaExistenciaPedido(const ACodigoPedido: Real): Boolean;
  public
    { Public declarations }
  end;

var
  F_OperacaoPedido: TF_OperacaoPedido;

implementation

uses
  DataModuleConexao, TUtilidades;
{$R *.dfm}

procedure TF_OperacaoPedido.BTN_ExcluirClick(Sender: TObject);
var LUtilidades : TUtilidadesDia;
begin
  if MessageDlg('Deseja Apagar o Pedido e os Itens do Pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
   if Trim(EDT_NumeroPedido.Text) <> EmptyStr then
   begin
     if verificaExistenciaPedido(StrToFloat(EDT_NumeroPedido.Text)) then
     begin
     Q_Dados.Close;
     Q_Dados.ParamByName('NUMERO_PEDIDO').AsFloat := StrToFloat(EDT_NumeroPedido.Text);
     Q_Dados.Open;

      if LUtilidades.DeletaArvorePedido(StrToFloat(EDT_NumeroPedido.Text)) then
      begin
       MessageDlg('Exluido com Sucesso, Para ter certeza Tente Localizar Novamente!',
                 mtInformation, [mbOk], 0);
       Q_Dados.Close;
       Q_Dados.ParamByName('NUMERO_PEDIDO').AsFloat := StrToFloat(EDT_NumeroPedido.Text);
       Q_Dados.Open;
      end
      else
      begin
       MessageDlg('N�o foi Exluido com Sucesso, verifique!',
                 mtInformation, [mbOk], 0);
       Abort;
      end;

     end
     else
     begin
      ShowMessage('Pedido N�o Localizado, Verifique!');
      Abort;
     end;

   end
   else
   begin
    ShowMessage('Preencha o N�mero do Pedido Antes!');
    Abort;
   end;
  end;
end;

procedure TF_OperacaoPedido.BTN_LocalizarClick(Sender: TObject);
begin
 if Trim(EDT_NumeroPedido.Text) <> EmptyStr then
 begin
   if verificaExistenciaPedido(StrToFloat(EDT_NumeroPedido.Text)) then
   begin
   Q_Dados.Close;
   Q_Dados.ParamByName('NUMERO_PEDIDO').AsFloat := StrToFloat(EDT_NumeroPedido.Text);
   Q_Dados.Open;
   end
   else
   begin
    ShowMessage('Pedido N�o Localizado, Verifique!');
    Abort;
   end;
 end;

end;

procedure TF_OperacaoPedido.EDT_NumeroPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', ',','.',Chr(8)]) then
    Key := #0;
end;

procedure TF_OperacaoPedido.FormShow(Sender: TObject);
begin
 EDT_NumeroPedido.SetFocus;
end;

function TF_OperacaoPedido.verificaExistenciaPedido(
  const ACodigoPedido: Real): Boolean;
begin
 Result := False;
 with TFDQuery.Create(Nil) do
 begin
   try
    Connection := DTM_Conexao.Conexao;
    SQL.Add(' SELECT 1 FROM DADOS_GERAIS_PEDIDO WHERE NUMERO_PEDIDO = :PEDIDO ');
    ParamByName('PEDIDO').AsFloat := ACodigoPedido;
    Open;
    if not isEmpty then
     Result := True;
   finally
    Free;
   end;
 end;
end;

end.
