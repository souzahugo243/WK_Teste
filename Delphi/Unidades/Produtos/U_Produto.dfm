inherited F_Produto: TF_Produto
  Caption = 'F_Produto'
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
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 458
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'preco_venda'
        Title.Alignment = taCenter
        Title.Caption = 'Pre'#231'o de Venda'
        Width = 199
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
        'Descri'#231#227'o')
    end
  end
  inherited Q_Principal: TFDQuery
    AfterOpen = Q_PrincipalAfterOpen
    SQL.Strings = (
      'select codigo'
      ',      descricao'
      ',      preco_venda'
      '  from produtos')
  end
end
