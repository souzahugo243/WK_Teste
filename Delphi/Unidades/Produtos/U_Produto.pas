unit U_Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_ModeloConsulta1, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TF_Produto = class(TF_ModeloConsulta1)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Q_PrincipalAfterOpen(DataSet: TDataSet);
    procedure BTN_LocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Produto: TF_Produto;

implementation

{$R *.dfm}

procedure TF_Produto.BTN_LocalizarClick(Sender: TObject);
begin
  inherited;
  if Trim(EDT_Pesquisa.Text) = EmptyStr then
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
      Q_Principal.SQL.Add(' where codigo = ' + QuotedStr(EDT_Pesquisa.Text) );
      Q_Principal.SQL.Add('  order by codigo ');
     end;

   1:begin
      Q_Principal.SQL.Clear;
      Q_Principal.SQL.Text := SQLOriginal;
      Q_Principal.SQL.Add(' where descricao like ' + QuotedStr('%' + EDT_Pesquisa.Text + '%') );
      Q_Principal.SQL.Add('  order by descricao ');
     end;
  end;
  Q_Principal.Open;

  if Q_Principal.IsEmpty then
  begin
    MessageDlg('N�o Foi Encontrado '+ CMB_Filtro.Text +' com Essa Inform��o',
    mtWarning, [mbOk], 0);
  EDT_Pesquisa.SetFocus;
  Abort;
  end;
end;

procedure TF_Produto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Q_Principal.Close;
end;

procedure TF_Produto.FormShow(Sender: TObject);
begin
  inherited;
  SQLOriginal := Q_Principal.SQL.Text;

  Q_Principal.Open;
end;

procedure TF_Produto.Q_PrincipalAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(DataSet.FieldByName('preco_venda')).DisplayFormat := ',0.00;-,0.00';
end;

end.
