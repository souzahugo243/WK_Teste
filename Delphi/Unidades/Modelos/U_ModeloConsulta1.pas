unit U_ModeloConsulta1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.Buttons, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TF_ModeloConsulta1 = class(TForm)
    DBG_Main: TDBGrid;
    PNL_Filtro: TPanel;
    Q_Principal: TFDQuery;
    DS_Principal: TDataSource;
    CMB_Filtro: TComboBox;
    EDT_Pesquisa: TEdit;
    BTN_Localizar: TSpeedButton;
    procedure EDT_PesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FSQLOriginal: String;
    procedure SetSQLOriginal(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property SQLOriginal: String read FSQLOriginal write SetSQLOriginal;
  end;

var
  F_ModeloConsulta1: TF_ModeloConsulta1;

implementation

uses
  DataModuleConexao;
{$R *.dfm}

procedure TF_ModeloConsulta1.EDT_PesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  BTN_Localizar.Click;
end;

procedure TF_ModeloConsulta1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
  Self.Close;
end;

procedure TF_ModeloConsulta1.SetSQLOriginal(const Value: String);
begin
  FSQLOriginal := Value;
end;

end.
