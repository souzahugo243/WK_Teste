inherited F_Cliente: TF_Cliente
  Caption = 'Clientes'
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Main: TDBGrid
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Alignment = taCenter
        Title.Caption = 'Nome '
        Width = 359
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cidade'
        Title.Alignment = taCenter
        Title.Caption = 'Cidade'
        Width = 256
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Alignment = taCenter
        Title.Caption = 'UF'
        Width = 69
        Visible = True
      end>
  end
  inherited PNL_Filtro: TPanel
    inherited BTN_Localizar: TSpeedButton
      OnClick = BTN_LocalizarClick
    end
    inherited CMB_Filtro: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Cidade')
    end
  end
  inherited Q_Principal: TFDQuery
    SQL.Strings = (
      'select codigo'
      ',      nome'
      ',      cidade'
      ',      uf'
      '  from clientes'
      '')
  end
end
