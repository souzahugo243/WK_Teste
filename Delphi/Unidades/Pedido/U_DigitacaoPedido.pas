unit U_DigitacaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, Datasnap.DBClient;

type
  TF_DigitacaoPedido = class(TForm)
    PNL_Header: TPanel;
    PNL_Footer: TPanel;
    DBG_Produtos: TDBGrid;
    Q_Produtos: TFDQuery;
    DS_Produtos: TDataSource;
    PNL_DadosPedido: TPanel;
    Panel1: TPanel;
    LBL_Cliente: TLabel;
    EDT_Nome: TEdit;
    Label1: TLabel;
    EDT_Cidade: TEdit;
    Label2: TLabel;
    EDT_UF: TEdit;
    Label3: TLabel;
    EDT_Codigo: TEdit;
    Label4: TLabel;
    EDT_NumeroPedido: TEdit;
    PNL_Valores: TPanel;
    PNL_Botoes: TPanel;
    BTN_IncluirProduto: TSpeedButton;
    BTN_AlterarProduto: TSpeedButton;
    BTN_ExcluirProduto: TSpeedButton;
    EDT_TotalPedido: TEdit;
    Label5: TLabel;
    Label8: TLabel;
    EDT_Quantidade: TEdit;
    CDS_Produtos: TClientDataSet;
    CDS_ProdutosCodigoProduto: TFloatField;
    CDS_ProdutosDescricaoProduto: TStringField;
    CDS_ProdutosQuantidade: TIntegerField;
    CDS_ProdutosValor_Unitario: TFloatField;
    CDS_ProdutosValor_Total: TFloatField;
    EDT_Carrinho: TEdit;
    Label6: TLabel;
    BTN_GravarPedido: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Q_ProdutosBeforeOpen(DataSet: TDataSet);
    procedure Q_ProdutosAfterOpen(DataSet: TDataSet);
    procedure BTN_IncluirProdutoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDS_ProdutosAfterPost(DataSet: TDataSet);
    procedure DBG_ProdutosDblClick(Sender: TObject);
    procedure BTN_AlterarProdutoClick(Sender: TObject);
    procedure BTN_ExcluirProdutoClick(Sender: TObject);
    procedure CDS_ProdutosAfterDelete(DataSet: TDataSet);
    procedure BTN_GravarPedidoClick(Sender: TObject);
  private
    FCodigoCliente: Real;
    procedure SetCodigoCliente(const Value: Real);
   { Private declarations }
    procedure PreencheDadosPedido;
    procedure PreencheDadosCliente(const ACodigoCliente : Real);

    procedure atualizaRodape;
  public
    { Public declarations }
    property CodigoCliente: Real read FCodigoCliente write SetCodigoCliente;
  end;

var
  F_DigitacaoPedido: TF_DigitacaoPedido;

implementation

uses
  DataModuleConexao, TUtilidades, U_ProdutoDetalhe;
{$R *.dfm}

{ TF_DigitacaoPedido }

procedure TF_DigitacaoPedido.atualizaRodape;
var LTotalItens  : Real;
    I, LProdutos : Integer;
begin
  LTotalItens   := 0;
  LProdutos     := 0;

  CDS_Produtos.First;
  while not (CDS_Produtos.eof) do
  begin
  LTotalItens := LTotalItens + CDS_ProdutosValor_Total.AsFloat;
  LProdutos   := LProdutos   + CDS_ProdutosQuantidade.AsInteger;
  CDS_Produtos.Next;
  end;
  EDT_Quantidade.Text  := IntToStr(CDS_Produtos.RecordCount);
  EDT_Carrinho.Text    := IntToStr(LProdutos);
  EDT_TotalPedido.Text := FormatFloat('#,,0.00', LTotalItens);
end;

procedure TF_DigitacaoPedido.BTN_AlterarProdutoClick(Sender: TObject);
begin
 if CDS_Produtos.IsEmpty then
 begin
   MessageDlg('Opera��o n�o permitida, insira Produtos', mtInformation, [mbOk], 0);
   Abort;
 end else
 begin
   DBG_ProdutosDblClick(BTN_AlterarProduto);
 end;
end;

procedure TF_DigitacaoPedido.BTN_ExcluirProdutoClick(Sender: TObject);
begin
 if CDS_Produtos.IsEmpty then
 begin
   MessageDlg('Opera��o n�o permitida, insira Produtos', mtInformation, [mbOk], 0);
   Abort;
 end else
 begin
   DBG_ProdutosDblClick(BTN_ExcluirProduto);
 end;
end;

procedure TF_DigitacaoPedido.BTN_GravarPedidoClick(Sender: TObject);
var LUtilidades : TUtilidadesDia;
begin
 if CDS_Produtos.IsEmpty then
 begin
  MessageDlg('N�o pode Finalizar, digite itens no pedido', mtError, [mbOk], 0);
  Abort;
 end;

 if LUtilidades.GravaPedido(StrToFloatDef(EDT_NumeroPedido.Text,0),
                         CodigoCliente,
                         StrToFloatDef(EDT_TotalPedido.Text,0),
                         CDS_Produtos) then
 begin
   MessageDlg('Pedido Gerado com Sucesso!', mtInformation, [mbOk], 0);
   Self.Close;
 end else
 begin
   MessageDlg('Pedido Apresenta Falha!', mtInformation, [mbOk], 0);
   Abort;
 end;

end;

procedure TF_DigitacaoPedido.BTN_IncluirProdutoClick(Sender: TObject);
var LProdutoDetalhe : TF_ProdutoDetalhe;
begin
 try
  LProdutoDetalhe                 := TF_ProdutoDetalhe.Create(Self);
  LProdutoDetalhe.EDT_Pedido.Text := EDT_NumeroPedido.Text;
  LProdutoDetalhe.Caption         := 'Incluir Produto';
  LProdutoDetalhe.CodigoCliente   := CodigoCliente;
  LProdutoDetalhe.ShowModal;
 finally
  { Atualizando Dados dos Itens do Pedido }
  if LProdutoDetalhe.ModalResult = mrYes then
  begin
   CDS_Produtos.Insert;
   CDS_ProdutosCodigoProduto.AsFloat     := StrToFloatDef(LProdutoDetalhe.EDT_CodigoProduto.Text, 0);
   CDS_ProdutosDescricaoProduto.AsString := LProdutoDetalhe.TXT_Produto.Caption;
   CDS_ProdutosQuantidade.AsInteger      := StrToIntDef(LProdutoDetalhe.EDT_Quantidade.Text, 0);
   CDS_ProdutosValor_Unitario.AsFloat    := StrToFloatDef(LProdutoDetalhe.EDT_Unitario.Text, 0);
   CDS_ProdutosValor_Total.AsFloat       := StrToFloatDef(LProdutoDetalhe.EDT_Total.Text, 0);

   CDS_Produtos.Post;
  end;
  FreeAndNil(LProdutoDetalhe);
 end;
end;

procedure TF_DigitacaoPedido.CDS_ProdutosAfterDelete(DataSet: TDataSet);
begin
  atualizaRodape;
end;

procedure TF_DigitacaoPedido.CDS_ProdutosAfterPost(DataSet: TDataSet);
begin
  atualizaRodape;
end;

procedure TF_DigitacaoPedido.DBG_ProdutosDblClick(Sender: TObject);
var LProdutoDetalhe : TF_ProdutoDetalhe;
begin

 if Sender = BTN_AlterarProduto then
 begin
   try
    LProdutoDetalhe                 := TF_ProdutoDetalhe.Create(Self);
    LProdutoDetalhe.EDT_Pedido.Text := EDT_NumeroPedido.Text;
    LProdutoDetalhe.Caption         := 'Alterar Produto';
    LProdutoDetalhe.CodigoCliente   := CodigoCliente;

    LProdutoDetalhe.EDT_CodigoProduto.Text := FloatToStr(CDS_ProdutosCodigoProduto.AsFloat);
    LProdutoDetalhe.TXT_Produto.Caption    := CDS_ProdutosDescricaoProduto.AsString;
    LProdutoDetalhe.EDT_Quantidade.Text    := IntToStr(CDS_ProdutosQuantidade.AsInteger);
    LProdutoDetalhe.EDT_Unitario.Text      := FloatToStr(CDS_ProdutosValor_Unitario.AsFloat);
    LProdutoDetalhe.EDT_Total.Text         := FloatToStr(CDS_ProdutosValor_Total.AsFloat);

    LProdutoDetalhe.ShowModal;
   finally
    { Atualizando Dados dos Itens do Pedido }
    if LProdutoDetalhe.ModalResult = mrYes then
    begin
     CDS_Produtos.Edit;
     CDS_ProdutosQuantidade.AsInteger      := StrToIntDef(LProdutoDetalhe.EDT_Quantidade.Text, 0);
     CDS_ProdutosValor_Unitario.AsFloat    := StrToFloatDef(LProdutoDetalhe.EDT_Unitario.Text, 0);
     CDS_ProdutosValor_Total.AsFloat       := StrToFloatDef(LProdutoDetalhe.EDT_Total.Text, 0);

     CDS_Produtos.Post;
    end;
    FreeAndNil(LProdutoDetalhe);
   end;
 end;


 if Sender = BTN_ExcluirProduto then
 begin
   if MessageDlg('Deseja Excluir o Item?', mtConfirmation, [mbYes, mbNo], 1) = mrYes then
   begin
     CDS_Produtos.Delete;
   end;
 end;

end;

procedure TF_DigitacaoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = VK_F3 then
  BTN_IncluirProduto.Click;

 if (key = 13) then
 begin
  BTN_AlterarProduto.Click;
 end;

 if (key = 46) then
 begin
  BTN_ExcluirProduto.Click;
 end;
end;

procedure TF_DigitacaoPedido.FormShow(Sender: TObject);
begin
 { Carregando Informacoes para Iniciar o Atendimento }
 PreencheDadosPedido;
 PreencheDadosCliente(CodigoCliente);

 CDS_Produtos.CreateDataSet;
 CDS_Produtos.Open;
end;

procedure TF_DigitacaoPedido.PreencheDadosCliente(const ACodigoCliente: Real);
begin
 with TFDQuery.Create(Nil) do
 begin
   try
    Connection := DTM_Conexao.Conexao;
    SQL.Add(' SELECT CODIGO           ' +
            ' ,      NOME             ' +
            ' ,      CIDADE           ' +
            ' ,      UF               ' +
            '   FROM CLIENTES         ' +
            '  WHERE CODIGO = :CODIGO ' );
    ParamByName('CODIGO').AsFloat := ACodigoCliente;
    Open;

    if not IsEmpty then
    begin
     EDT_Codigo.Text := FloatToStr(FieldByName('CODIGO').AsFloat);
     EDT_Nome.Text   := FieldByName('NOME').AsString;
     EDT_Cidade.Text := FieldByName('CIDADE').AsString;
     EDT_UF.Text     := FieldByName('UF').AsString;
    end;
   finally
    Free;
   end;
 end;
end;

procedure TF_DigitacaoPedido.PreencheDadosPedido;
begin
 { Recuperando Ultimo Pedido Armazenado }
 with TFDQuery.Create(Nil) do
 begin
   try
    Connection := DTM_Conexao.Conexao;
    SQL.Add(' SELECT COALESCE( MAX(NUMERO_PEDIDO), 0) ' +
            '   FROM DADOS_GERAIS_PEDIDO              ' );
    Open;
    EDT_NumeroPedido.Text := FloatToStr( Fields[0].AsFloat + 1 );
   finally
    Free;
   end;
 end;
end;

procedure TF_DigitacaoPedido.Q_ProdutosAfterOpen(DataSet: TDataSet);
begin
  TNumericField(DataSet.FieldByName('VALOR_UNITARIO')).DisplayFormat := ',0.00;-,0.00';
  TNumericField(DataSet.FieldByName('VALOR_TOTAL')).DisplayFormat    := ',0.00;-,0.00';
end;

procedure TF_DigitacaoPedido.Q_ProdutosBeforeOpen(DataSet: TDataSet);
begin
  Q_Produtos.ParamByName('NUMERO_PEDIDO').AsFloat := StrToFloat(EDT_NumeroPedido.Text);
end;

procedure TF_DigitacaoPedido.SetCodigoCliente(const Value: Real);
begin
  FCodigoCliente := Value;
end;

end.
