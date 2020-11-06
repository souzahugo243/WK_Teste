object F_OperacaoPedido: TF_OperacaoPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Operacao Pedido'
  ClientHeight = 532
  ClientWidth = 937
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 240
    Width = 937
    Height = 292
    Align = alBottom
    DataSource = DS_Dados
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_PRODUTO'
        Title.Alignment = taCenter
        Title.Caption = 'Codigo Produto'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_PRODUTO'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 258
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_EMISSAO'
        Title.Alignment = taCenter
        Title.Caption = 'Data Pedido'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_UNITARIO'
        Title.Alignment = taCenter
        Title.Caption = 'Valor Unitario Produto'
        Width = 162
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Title.Alignment = taCenter
        Title.Caption = 'Quantidade Produto'
        Width = 183
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 241
    object Label4: TLabel
      Left = 24
      Top = 24
      Width = 56
      Height = 16
      Caption = 'N'#186' Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object BTN_Localizar: TSpeedButton
      Left = 199
      Top = 45
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Localize Informa'#231#245'es'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000074120000741200000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFACA8E0DFDDFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3E3E3DADADAF8F8F8B4B2
        AF6B665CFAFAFAFFFFFFFFFFFFFCE9D2FBDEBBFBDEBBFBDEBBFBDEBBFBDEBBF9
        DDBA988D81B0A18FC0AE988D8A86949493FAFAFAFFFFFFFFFFFFFFFFFFFCE9D2
        FBDEBBFBDEBBFBDEBBFBDEBBFBDEBBBDAB96CAB69EFBDEBBFBDEBBF3D9BA9695
        94FFFFFFFFFFFFFFFFFFFFFFFFFCE9D2FBDEBBE7AB6BE7AB6BDD9244E7AA6A9E
        9385F0D5B5FBDEBBFBDEBBFBDEBB95938FFFFFFFFFFFFFFFFFFFFFFFFFFCE9D2
        FBDEBBE9B072E9B072E0994FE2A05ABAA995CAB69EFBDEBBFBDEBBF3D9BA9392
        91FFFFFFFFFFFFFFFFFFFFFFFFFCE9D2FBDEBBF4CC9EF4CC9EF0C290F0C290F2
        CB9F988D81B0A18FC0AE98918D89E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFCE9D2
        FBDEBBF2C697F2C697EDBB85EDBB85EEBE89FADCB9E0C8ABD7C1A6F7EEE2FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFCE9D2FBDEBBE7AB6BE7AB6BDD9244DD9244DD
        9244DD9244E7AB6BFBDEBBFEF4E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCE9D2
        FBDEBBE9B072E9B072E0994FE0994FE0994FE0994FE9B072FBDEBBFEF4E8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF2D1B8FBDEBBFBDEBBFBDEBBFBDEBBFBDEBBFB
        DEBBFBDEBBFBDEBBFBDEBBF5DED0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4B49C
        E8B99AE8B99AE8B99AE8B99AE8B99AE8B99AE8B99AE8B99AE8B99AEBCBBEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFCE8B7FB5513FB5513FB5513FB5513FB5513FB5
        513FB5513FB5513FB5513FE6C5BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1DFDC
        E6C5BFE6C5BFE6C5BFE6C5BFE6C5BFE6C5BFE6C5BFE6C5BFE6C5BFFAF3F1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BTN_LocalizarClick
    end
    object Label3: TLabel
      Left = 24
      Top = 87
      Width = 82
      Height = 16
      Caption = 'C'#243'digo Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LBL_Cliente: TLabel
      Left = 24
      Top = 136
      Width = 76
      Height = 16
      Caption = 'Nome Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 24
      Top = 185
      Width = 39
      Height = 16
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 359
      Top = 185
      Width = 66
      Height = 16
      Caption = 'UF / Estado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 24
      Top = 109
      Width = 257
      Height = 17
      DataField = 'CODIGO'
      DataSource = DS_Dados
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 24
      Top = 158
      Width = 257
      Height = 17
      DataField = 'NOME'
      DataSource = DS_Dados
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 359
      Top = 207
      Width = 257
      Height = 17
      DataField = 'UF'
      DataSource = DS_Dados
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 24
      Top = 207
      Width = 257
      Height = 17
      DataField = 'CIDADE'
      DataSource = DS_Dados
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BTN_Excluir: TSpeedButton
      Left = 199
      Top = 46
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Localize Informa'#231#245'es'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000074120000741200000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1DCFFBBCBFFBBCBFFBB
        CBFFBBCBFFBBCBFFBBCBFFD1DCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCFDAFF013EFF003DFF003DFF003DFF003DFF003DFF003DFF013EFFD1DC
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAABEFF003DFF003DFF003DFF00
        3DFF003DFF003DFF003DFF003DFFAABEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAABEFF003DFF003DFF3D6BFE003DFF003DFF3D6BFE003DFF003DFFAABE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAABEFF003DFF3A69FEFAFAFA76
        96FD7797FDFAFAFA3968FE003DFFAABEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAABEFF003DFF003DFF86A2FCFAFAFAFAFAFA85A1FC003DFF003DFFAABE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAABEFF003DFF003DFF6E90FDFA
        FAFAF9F9FA6E90FD003DFF003DFFAABEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAABEFF003DFF3A69FEFAFAFA7696FD7797FDFAFAFA3968FE003DFFAABE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAABEFF003DFF003DFF3D6BFE00
        3DFF003DFF3D6BFE003DFF003DFFAABEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAABEFF003DFF003DFF003DFF003DFF003DFF003DFF003DFF003DFFAABE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAABEFF003DFF003DFF003DFF00
        3DFF003DFF003DFF003DFF003DFFAABEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7797FF6086FF3162FF2B5DFF2B5DFF2B5DFF2B5DFF3162FF6086FF7797
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF92ACFF7395FF6288FF3263FF2F
        61FF2F61FF3364FF6489FF7395FF92ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFD7E1FFAABEFFAABEFFD7E1FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BTN_ExcluirClick
    end
    object EDT_NumeroPedido: TEdit
      Left = 24
      Top = 46
      Width = 169
      Height = 21
      TabOrder = 0
      OnKeyPress = EDT_NumeroPedidoKeyPress
    end
  end
  object Q_Dados: TFDQuery
    Connection = DTM_Conexao.Conexao
    SQL.Strings = (
      'SELECT CLIENTE.CODIGO'
      ',      CLIENTE.NOME'
      ',      CLIENTE.CIDADE'
      ',      CLIENTE.UF'
      ',      PEDIDO.NUMERO_PEDIDO'
      ',      PEDIDO.DATA_EMISSAO'
      ',      PEDIDO_ITEM.CODIGO_PRODUTO'
      ',      PRODUTO.DESCRICAO as "DESCRICAO_PRODUTO"'
      ',      PEDIDO_ITEM.VALOR_UNITARIO'
      ',      PEDIDO_ITEM.QUANTIDADE'
      ''
      '  FROM DADOS_GERAIS_PEDIDO PEDIDO'
      '  ,    PEDIDOS_PRODUTOS    PEDIDO_ITEM'
      '  ,    PRODUTOS            PRODUTO'
      '  ,    CLIENTES            CLIENTE'
      ' WHERE PEDIDO.NUMERO_PEDIDO       = PEDIDO_ITEM.NUMERO_PEDIDO'
      '   AND PEDIDO_ITEM.CODIGO_PRODUTO = PRODUTO.CODIGO'
      '   AND PEDIDO.CODIGO_CLIENTE      = CLIENTE.CODIGO'
      '   AND PEDIDO.NUMERO_PEDIDO       = :NUMERO_PEDIDO')
    Left = 640
    Top = 304
    ParamData = <
      item
        Name = 'NUMERO_PEDIDO'
        DataType = ftFloat
        ParamType = ptInput
      end>
  end
  object DS_Dados: TDataSource
    DataSet = Q_Dados
    Left = 640
    Top = 360
  end
end
