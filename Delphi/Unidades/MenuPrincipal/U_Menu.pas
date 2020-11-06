unit U_Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls;

type
  TF_Menu = class(TForm)
    TLB_Botoes: TToolBar;
    ToolButton2: TToolButton;
    BTN_Produtos: TSpeedButton;
    BTN_Clientes: TSpeedButton;
    BTN_Vendas: TSpeedButton;
    IMG_Background: TImage;
    ToolButton1: TToolButton;
    BTN_Sair: TSpeedButton;
    panInfoADM: TPanel;
    lblUsuario: TLabel;
    lblInformacoes: TLabel;
    lblSituacao: TLabel;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel6: TPanel;
    panHora: TPanel;
    lblHora: TLabel;
    panData: TPanel;
    lblData: TLabel;
    tmrStb: TTimer;
    LBL_Ativo: TLabel;
    LBL_Info: TLabel;
    LBL_Utilizador: TLabel;
    BTN_Pedidos: TSpeedButton;
    procedure BTN_ClientesClick(Sender: TObject);
    procedure BTN_SairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BTN_ProdutosClick(Sender: TObject);
    procedure BTN_VendasClick(Sender: TObject);
    procedure tmrStbTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  F_Menu: TF_Menu;

implementation

uses
  U_Cliente, U_Produto, U_IniciarAtendimento;
{$R *.dfm}

procedure TF_Menu.BTN_ClientesClick(Sender: TObject);
var LClientes : TF_Cliente;
begin
 try
  LClientes := TF_Cliente.Create(Nil);
  LClientes.ShowModal;
 finally
  FreeAndNil(LClientes);
 end;
end;

procedure TF_Menu.BTN_ProdutosClick(Sender: TObject);
var LProdutos : TF_Produto;
begin
 try
  LProdutos := TF_Produto.Create(Nil);
  LProdutos.ShowModal;
 finally
  FreeAndNil(LProdutos);
 end;
end;

procedure TF_Menu.BTN_SairClick(Sender: TObject);
begin
 if MessageDlg('Deseja Mesmo Sair?', mtConfirmation, [mbYes, mbNo], 1) = mrYes then
  Application.Terminate;
end;

procedure TF_Menu.BTN_VendasClick(Sender: TObject);
var LIniciarAtendimento : TF_IniciarAtendimento;
begin
 try
  LIniciarAtendimento := TF_IniciarAtendimento.Create(Nil);
  LIniciarAtendimento.ShowModal;
 finally
  FreeAndNil(LIniciarAtendimento);
 end;
end;

procedure TF_Menu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   BTN_Sair.Click;
end;

procedure TF_Menu.tmrStbTimer(Sender: TObject);
begin
 lblHora.Caption := FormatDateTime('hh:mm:ss', now);
 lblData.Caption := FormatDateTime('ddd "-" dd/mm/yyy', now);
end;

end.
