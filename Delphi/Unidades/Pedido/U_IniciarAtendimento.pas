unit U_IniciarAtendimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TF_IniciarAtendimento = class(TForm)
    PNL_Head: TPanel;
    EDT_Pesquisa: TEdit;
    TXT_NomeCliente: TLabel;
    BTN_Iniciar: TSpeedButton;
    LBL_Dica: TLabel;
    BTN_Pedidos: TSpeedButton;
    BTN_Cancelar: TSpeedButton;
    procedure BTN_IniciarClick(Sender: TObject);
    procedure EDT_PesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDT_PesquisaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BTN_PedidosClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_IniciarAtendimento: TF_IniciarAtendimento;

implementation

uses
  U_DigitacaoPedido, TUtilidades, U_OperacaoPedido;
{$R *.dfm}

procedure TF_IniciarAtendimento.BTN_CancelarClick(Sender: TObject);
var LOperacaoPedido : TF_OperacaoPedido;
begin
 try
   LOperacaoPedido         := TF_OperacaoPedido.Create(Self);
   LOperacaoPedido.Caption := 'Excluir Pedido pelo Numero';
   LOperacaoPedido.BTN_Localizar.Visible := False;
   LOperacaoPedido.ShowModal;
 finally
   FreeAndNil(LOperacaoPedido);
 end;
end;

procedure TF_IniciarAtendimento.BTN_IniciarClick(Sender: TObject);
var 
  LDigitacaoPedido : TF_DigitacaoPedido;
begin
 if Trim(EDT_Pesquisa.Text) = EmptyStr then
 begin
  MessageDlg('N�o existe Cliente Parametrizado, verifique o C�digo!', mtError, [mbOk], 0);
  EDT_Pesquisa.SetFocus;
  Abort;
 end;

 if (TXT_NomeCliente.Caption <> '') or
    (TXT_NomeCliente.Caption <> EmptyStr)
 then
 begin
  try
   LDigitacaoPedido               := TF_DigitacaoPedido.Create(Self);
   LDigitacaoPedido.CodigoCliente := StrToFloat(EDT_Pesquisa.Text);
   Self.Hide;
   LDigitacaoPedido.ShowModal;
  finally
   FreeAndNil(LDigitacaoPedido);
   Self.Close;
  end;
 end;
end;

procedure TF_IniciarAtendimento.BTN_PedidosClick(Sender: TObject);
var LOperacaoPedido : TF_OperacaoPedido;
begin
 try
   LOperacaoPedido         := TF_OperacaoPedido.Create(Self);
   LOperacaoPedido.BTN_Excluir.Visible := False;
   LOperacaoPedido.Caption := 'Consultar Pedido pelo Numero';
   LOperacaoPedido.ShowModal;
 finally
   FreeAndNil(LOperacaoPedido);
 end;
end;

procedure TF_IniciarAtendimento.EDT_PesquisaExit(Sender: TObject);
var LCodigoCliente   : Real;
    LUtilidades      : TUtilidadesDia;    
begin
 LCodigoCliente            := StrToFloatDef(EDT_Pesquisa.Text, 0);
 TXT_NomeCliente.Caption   := LUtilidades.localizaNomeCliente(LCodigoCliente);

 if TXT_NomeCliente.Caption = EmptyStr then
 begin
  BTN_Pedidos.Visible  := TXT_NomeCliente.Caption = '';
  BTN_Cancelar.Visible := BTN_Pedidos.Visible;
  MessageDlg('Cliente Informado incorreto, ou n�o cadastrado', mtInformation, [mbOk], 0);
  EDT_Pesquisa.SetFocus;
  Abort;
 end
 else
 begin
  BTN_Pedidos.Visible  := TXT_NomeCliente.Caption = '';
  BTN_Cancelar.Visible := BTN_Pedidos.Visible;
  MessageDlg('Cliente Localizado, Para Continuar "Inicie o Atendimento"', mtInformation, [mbOk], 0);
 end;
end;

procedure TF_IniciarAtendimento.EDT_PesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    EDT_Pesquisa.OnExit(Sender);
 if Key = VK_TAB then
    EDT_Pesquisa.OnExit(Sender);
end;

procedure TF_IniciarAtendimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
 if MessageDlg('Deseja Mesmo Sair?', mtConfirmation, [mbYes, mbNo], 1) = mrYes then
  Self.Close

end;

procedure TF_IniciarAtendimento.FormShow(Sender: TObject);
begin
 BTN_Pedidos.Visible  := TXT_NomeCliente.Caption = '';
 BTN_Cancelar.Visible := BTN_Pedidos.Visible;
end;

end.
