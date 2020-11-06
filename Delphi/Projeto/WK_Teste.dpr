program WK_Teste;

uses
  Vcl.Forms,
  DataModuleConexao in '..\Unidades\DataModule\DataModuleConexao.pas' {DTM_Conexao: TDataModule},
  U_Menu in '..\Unidades\MenuPrincipal\U_Menu.pas' {F_Menu},
  U_DigitacaoPedido in '..\Unidades\Pedido\U_DigitacaoPedido.pas' {F_DigitacaoPedido},
  U_ModeloConsulta1 in '..\Unidades\Modelos\U_ModeloConsulta1.pas' {F_ModeloConsulta1},
  U_Cliente in '..\Unidades\Clientes\U_Cliente.pas' {F_Cliente},
  TUtilidades in '..\Classes\TUtilidades.pas',
  U_Produto in '..\Unidades\Produtos\U_Produto.pas' {F_Produto},
  U_IniciarAtendimento in '..\Unidades\Pedido\U_IniciarAtendimento.pas' {F_IniciarAtendimento},
  U_ProdutoDetalhe in '..\Unidades\Produtos\U_ProdutoDetalhe.pas' {F_ProdutoDetalhe},
  U_LocalizaProduto in '..\Unidades\Produtos\U_LocalizaProduto.pas' {F_LocalizaProduto},
  U_OperacaoPedido in '..\Unidades\Pedido\U_OperacaoPedido.pas' {F_OperacaoPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDTM_Conexao, DTM_Conexao);
  Application.CreateForm(TF_Menu, F_Menu);
  Application.CreateForm(TF_OperacaoPedido, F_OperacaoPedido);
  Application.Run;
end.
