unit U_ProdutoDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TF_ProdutoDetalhe = class(TForm)
    Label4: TLabel;
    EDT_CodigoProduto: TEdit;
    Label1: TLabel;
    EDT_Quantidade: TEdit;
    Label2: TLabel;
    EDT_Unitario: TEdit;
    BTN_Localizar: TSpeedButton;
    TXT_Produto: TLabel;
    Label5: TLabel;
    EDT_Total: TEdit;
    Label6: TLabel;
    EDT_Pedido: TEdit;
    BTN_Confirmar: TSpeedButton;
    BTN_Cancelar: TSpeedButton;
    Shape1: TShape;
    procedure BTN_LocalizarClick(Sender: TObject);
    procedure EDT_CodigoProdutoExit(Sender: TObject);
    procedure EDT_UnitarioExit(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure BTN_ConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EDT_CodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCodigoCliente: Real;
    procedure SetCodigoCliente(const Value: Real);
    { Private declarations }
    procedure validaCamposObrigatorios;
  public
    { Public declarations }
    property CodigoCliente : Real read FCodigoCliente write SetCodigoCliente;
  end;

var
  F_ProdutoDetalhe: TF_ProdutoDetalhe;

implementation

uses
  TUtilidades, U_LocalizaProduto;

{$R *.dfm}

procedure TF_ProdutoDetalhe.BTN_CancelarClick(Sender: TObject);
begin
 if MessageDlg('Deseja Cancelar a Inser��o? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  Self.Close;
end;

procedure TF_ProdutoDetalhe.BTN_ConfirmarClick(Sender: TObject);
begin
 validaCamposObrigatorios;
 ModalResult := mrYes;
end;

procedure TF_ProdutoDetalhe.BTN_LocalizarClick(Sender: TObject);
var LLocalizaProduto : TF_LocalizaProduto;
begin
 try
  LLocalizaProduto := TF_LocalizaProduto.Create(Self);
  LLocalizaProduto.ShowModal;
  if LLocalizaProduto.ModalResult = mrYes then
  begin
   EDT_CodigoProduto.Text := FloatToStr(LLocalizaProduto.Q_Principal.FieldByName('CODIGO').AsFloat);
   EDT_CodigoProduto.OnExit(Sender);
  end;
 finally
  FreeAndNil(LLocalizaProduto);
 end;
end;
procedure TF_ProdutoDetalhe.EDT_CodigoProdutoExit(Sender: TObject);
var LNecesssidades : TUtilidadesDia;
begin
 if Trim(EDT_CodigoProduto.Text) <> EmptyStr then
 begin
  TXT_Produto.Caption :=  LNecesssidades.localizaNomeProduto(StrToFloat(EDT_CodigoProduto.Text));
  if TXT_Produto.Caption = EmptyStr then
  begin
   MessageDlg('Produto n�o localizado', mtWarning, [mbOk], 0);
   EDT_CodigoProduto.SetFocus;
   Abort;
  end;
 end;

end;

procedure TF_ProdutoDetalhe.EDT_CodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', ',','.',Chr(8)]) then
    Key := #0;
end;

procedure TF_ProdutoDetalhe.EDT_UnitarioExit(Sender: TObject);
var TotalProdutoItem : Real;
begin
 TotalProdutoItem    := 0;
 TotalProdutoItem    := ( StrToFloatDef(EDT_Quantidade.Text, 0) * StrToFloatDef(EDT_Unitario.Text, 0) );

 EDT_Total.Text := FormatFloat('#,,0.00', TotalProdutoItem);
end;

procedure TF_ProdutoDetalhe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  BTN_Confirmar.Click;

 if Key = VK_ESCAPE then
  BTN_Cancelar.Click;
end;

procedure TF_ProdutoDetalhe.FormShow(Sender: TObject);
begin
 EDT_CodigoProduto.Enabled := Caption = 'Incluir Produto';
 BTN_Localizar.Enabled     := EDT_CodigoProduto.Enabled;
end;

procedure TF_ProdutoDetalhe.SetCodigoCliente(const Value: Real);
begin
  FCodigoCliente := Value;
end;

procedure TF_ProdutoDetalhe.validaCamposObrigatorios;
begin
 if (TRIM(EDT_CodigoProduto.Text) = EmptyStr) then
 begin
  MessageDlg('C�digo Precisa ser preenchido, veifique', mtInformation, [mbOk], 0);
  Abort;
 end;

 if (TRIM(EDT_Quantidade.Text) = EmptyStr) then
 begin
  MessageDlg('Quantidade Precisa ser preenchida, veifique', mtInformation, [mbOk], 0);
  Abort;
 end;

 if (TRIM(EDT_Unitario.Text) = EmptyStr) then
 begin
  MessageDlg('Valor Unit�rio Precisa ser preenchida, veifique', mtInformation, [mbOk], 0);
  Abort;
 end;
end;

end.
