object DTM_Conexao: TDTM_Conexao
  OldCreateOrder = False
  Height = 155
  Width = 133
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=wk_teste'
      'User_Name=root'
      'Server=LOCALHOST'
      'Password=Antonella$13'
      'DriverID=mySQL')
    Left = 40
    Top = 24
  end
  object DriverMYSQL: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\souza\Desktop\WK_TESTE\Banco\libmysql.dll'
    Left = 40
    Top = 80
  end
end
