unit U_Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_ModeloConsulta1, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, System.UITypes;

type
  TF_Cliente = class(TF_ModeloConsulta1)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTN_LocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Cliente: TF_Cliente;

implementation

{$R *.dfm}

procedure TF_Cliente.BTN_LocalizarClick(Sender: TObject);
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
      Q_Principal.SQL.Add(' where nome like ' + QuotedStr('%' + EDT_Pesquisa.Text + '%') );
      Q_Principal.SQL.Add('  order by nome ');
     end;

   2:begin
      Q_Principal.SQL.Clear;
      Q_Principal.SQL.Text := SQLOriginal;
      Q_Principal.SQL.Add(' where cidade like ' + QuotedStr('%' + EDT_Pesquisa.Text + '%') );
      Q_Principal.SQL.Add('  order by cidade, uf ');
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

procedure TF_Cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Q_Principal.Close;
end;

procedure TF_Cliente.FormShow(Sender: TObject);
begin
  inherited;
  { Armazenando SQL Original sem filtro }
  SQLOriginal := Q_Principal.SQL.Text;

  Q_Principal.Open;
end;
end.
