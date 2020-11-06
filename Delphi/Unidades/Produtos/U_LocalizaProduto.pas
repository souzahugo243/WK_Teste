unit U_LocalizaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TF_LocalizaProduto = class(TForm)
    PNL_Header: TPanel;
    DBGrid1: TDBGrid;
    Q_Principal: TFDQuery;
    DS_Principal: TDataSource;
    CMB_Filtro: TComboBox;
    EDT_CodigoProduto: TEdit;
    BTN_Localizar: TSpeedButton;
    PNL_Botoes: TPanel;
    BTN_Confirmar: TSpeedButton;
    BTN_Sair: TSpeedButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BTN_LocalizarClick(Sender: TObject);
    procedure BTN_SairClick(Sender: TObject);
    procedure BTN_ConfirmarClick(Sender: TObject);
  private
    FSQLOriginal: String;
    procedure SetSQLOriginal(const Value: String);
    { Private declarations }
    property SQLOriginal : String read FSQLOriginal write SetSQLOriginal;
  public
    { Public declarations }
  end;

var
  F_LocalizaProduto: TF_LocalizaProduto;

implementation

uses
  DataModuleConexao, U_ProdutoDetalhe;
{$R *.dfm}

{ TF_LocalizaProduto }

procedure TF_LocalizaProduto.BTN_ConfirmarClick(Sender: TObject);
begin
 ModalResult := mrYes
end;

procedure TF_LocalizaProduto.BTN_LocalizarClick(Sender: TObject);
begin
 if Trim(EDT_CodigoProduto.Text) = EmptyStr then
  begin
   Q_Principal.Close;
   Q_Principal.SQL.Clear;
   Q_Principal.SQL.Text := SQLOriginal;
   Q_Principal.Open;
   Exit;
  end;

  Q_Principal.Close;
  case CMB_Filtro.ItemIndex of
   0:begin
      Q_Principal.SQL.Clear;
      Q_Principal.SQL.Text := SQLOriginal;
      Q_Principal.SQL.Add(' where codigo = ' + QuotedStr(EDT_CodigoProduto.Text) );
      Q_Principal.SQL.Add('  order by codigo ');
     end;

   1:begin
      Q_Principal.SQL.Clear;
      Q_Principal.SQL.Text := SQLOriginal;
      Q_Principal.SQL.Add(' where descricao like ' + QuotedStr('%' + EDT_CodigoProduto.Text + '%') );
      Q_Principal.SQL.Add('  order by descricao ');
     end;
  end;
  Q_Principal.Open;

  if Q_Principal.IsEmpty then
  begin
    MessageDlg('N�o Foi Encontrado '+ CMB_Filtro.Text +' com Essa Inform��o',
    mtWarning, [mbOk], 0);
  EDT_CodigoProduto.SetFocus;
  Abort;
  end;
end;

procedure TF_LocalizaProduto.BTN_SairClick(Sender: TObject);
begin
 Self.Close;
end;

procedure TF_LocalizaProduto.FormShow(Sender: TObject);
begin
 FSQLOriginal := Q_Principal.SQL.Text;
 Q_Principal.Open;
end;

procedure TF_LocalizaProduto.SetSQLOriginal(const Value: String);
begin
  FSQLOriginal := Value;
end;

end.
