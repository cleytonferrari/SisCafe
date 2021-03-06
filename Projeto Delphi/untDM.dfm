object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 231
  Top = 95
  Height = 593
  Width = 677
  object BaseDados: TIBDatabase
    DatabaseName = 'C:\SisCafe\Dados\SISCAFE.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=171099')
    LoginPrompt = False
    DefaultTransaction = Transacao
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 40
    Top = 32
  end
  object Transacao: TIBTransaction
    Active = False
    DefaultDatabase = BaseDados
    AutoStopAction = saNone
    Left = 104
    Top = 32
  end
  object tblBairros: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblBairrosNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    IndexFieldNames = 'BAIRROS_ID'
    MasterFields = 'BAIRROS_ID'
    MasterSource = DataSource3
    TableName = 'BAIRROS'
    Left = 40
    Top = 88
    object tblBairrosBAIRROS_ID: TIntegerField
      FieldName = 'BAIRROS_ID'
    end
    object tblBairrosNOME: TIBStringField
      FieldName = 'NOME'
      Size = 50
    end
  end
  object QryCommit: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'commit work;')
    Left = 168
    Top = 32
  end
  object QryRollback: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'rollback work;')
    Left = 224
    Top = 32
  end
  object tblEnderecos: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblEnderecosNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'ENDERECOS'
    Left = 40
    Top = 144
    object tblEnderecosENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
    end
    object tblEnderecosBAIRROS_ID: TIntegerField
      FieldName = 'BAIRROS_ID'
    end
    object tblEnderecosLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Size = 70
    end
    object tblEnderecosCEP: TIBStringField
      FieldName = 'CEP'
      EditMask = '00000\-999;0;_'
      Size = 8
    end
    object tblEnderecosMUNICIPIO_ID: TIBStringField
      FieldName = 'MUNICIPIO_ID'
      Size = 10
    end
  end
  object tblMunicipio: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'MUNICIPIO_ID'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NOME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'UF'
        Attributes = [faRequired]
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'XPKMUNICIPIO'
        Fields = 'MUNICIPIO_ID'
        Options = [ixUnique]
      end>
    IndexFieldNames = 'MUNICIPIO_ID'
    MasterFields = 'MUNICIPIO_ID'
    MasterSource = DataSource3
    StoreDefs = True
    TableName = 'MUNICIPIO'
    Left = 40
    Top = 200
    object tblMunicipioMUNICIPIO_ID: TIBStringField
      FieldName = 'MUNICIPIO_ID'
      Size = 10
    end
    object tblMunicipioNOME: TIBStringField
      FieldName = 'NOME'
      Size = 50
    end
    object tblMunicipioUF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = tblBairros
    Left = 248
    Top = 152
  end
  object DataSource2: TDataSource
    DataSet = tblMunicipio
    Left = 208
    Top = 152
  end
  object DataSource3: TDataSource
    DataSet = tblEnderecos
    Left = 120
    Top = 152
  end
  object tblUF: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'UF'
    Left = 40
    Top = 264
    object tblUFUF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
    object tblUFUF_ID: TIBStringField
      FieldName = 'UF_ID'
      Size = 2
    end
    object tblUFESTADO: TIBStringField
      FieldName = 'ESTADO'
      Size = 50
    end
  end
  object tblBairrosCad: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblBairrosCadNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'BAIRROS'
    Left = 104
    Top = 88
    object tblBairrosCadBAIRROS_ID: TIntegerField
      FieldName = 'BAIRROS_ID'
      Required = True
    end
    object tblBairrosCadNOME: TIBStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
  end
  object tblFornecedor: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblFornecedorNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'FORNECEDOR_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME_RAZAOSOCIAL'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CPF_CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'RG_IE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'DATA_CADASTRO'
        DataType = ftDate
      end
      item
        Name = 'TELEFONES'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'AVALISTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CPF_AVALISTA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 11
      end
      item
        Name = 'OBS'
        DataType = ftBlob
        Size = 8
      end
      item
        Name = 'SACARIA'
        DataType = ftInteger
      end
      item
        Name = 'EMPRESTIMO'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'ENDERECOS_ID'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'XPKFORNECEDOR'
        Fields = 'FORNECEDOR_ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'FORNECEDOR'
    Left = 40
    Top = 320
    object tblFornecedorFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Required = True
    end
    object tblFornecedorNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Size = 50
    end
    object tblFornecedorCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Size = 14
    end
    object tblFornecedorRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Size = 15
    end
    object tblFornecedorDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      EditMask = '!99/99/0000;1;_'
    end
    object tblFornecedorTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Size = 50
    end
    object tblFornecedorEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Size = 40
    end
    object tblFornecedorAVALISTA: TIBStringField
      FieldName = 'AVALISTA'
      Size = 50
    end
    object tblFornecedorCPF_AVALISTA: TIBStringField
      FieldName = 'CPF_AVALISTA'
      Size = 11
    end
    object tblFornecedorOBS: TBlobField
      FieldName = 'OBS'
      Size = 8
    end
    object tblFornecedorSACARIA: TIntegerField
      FieldName = 'SACARIA'
    end
    object tblFornecedorEMPRESTIMO: TIBBCDField
      FieldName = 'EMPRESTIMO'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblFornecedorENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
    end
  end
  object DataSource5: TDataSource
    DataSet = tblFornecedor
    Left = 128
    Top = 264
  end
  object tblEnderecoCompleto: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    IndexFieldNames = 'ENDERECOS_ID'
    MasterFields = 'ENDERECOS_ID'
    MasterSource = DataSource5
    TableName = 'ENDERECOCOMPLETO'
    Left = 136
    Top = 320
    object tblEnderecoCompletoENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
    end
    object tblEnderecoCompletoLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Size = 70
    end
    object tblEnderecoCompletoCEP: TIBStringField
      FieldName = 'CEP'
      Size = 8
    end
    object tblEnderecoCompletoNOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Size = 50
    end
    object tblEnderecoCompletoNOMEMUNICIPIO: TIBStringField
      FieldName = 'NOMEMUNICIPIO'
      Size = 50
    end
    object tblEnderecoCompletoUF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
  end
  object DataSource6: TDataSource
    DataSet = tblEnderecoCompleto
    Left = 168
    Top = 152
  end
  object tblHistoricoSacaria: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblHistoricoSacariaNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'HISTORICOSACARIA'
    Left = 40
    Top = 384
    object tblHistoricoSacariaHISTORICOSACARIA_ID: TIntegerField
      FieldName = 'HISTORICOSACARIA_ID'
      Required = True
    end
    object tblHistoricoSacariaFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
    end
    object tblHistoricoSacariaDATA: TDateField
      FieldName = 'DATA'
      EditMask = '!99/99/0000;1;_'
    end
    object tblHistoricoSacariaQUANT: TIntegerField
      FieldName = 'QUANT'
    end
    object tblHistoricoSacariaSTATUS: TIBStringField
      FieldName = 'STATUS'
      Size = 1
    end
  end
  object tblFornecedor_Sacaria: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    IndexFieldNames = 'FORNECEDOR_ID'
    MasterFields = 'FORNECEDOR_ID'
    MasterSource = DataSource7
    TableName = 'FORNECEDOR'
    Left = 152
    Top = 384
    object tblFornecedor_SacariaFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Required = True
    end
    object tblFornecedor_SacariaNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Size = 50
    end
    object tblFornecedor_SacariaSACARIA: TIntegerField
      FieldName = 'SACARIA'
    end
  end
  object DataSource7: TDataSource
    DataSet = tblHistoricoSacaria
    Left = 104
    Top = 376
  end
  object tblHistoricoEmprestimo: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblHistoricoEmprestimoNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'HISTORICOEMPRESTIMO'
    Left = 48
    Top = 440
    object tblHistoricoEmprestimoHISTORICOEMPRESTIMO_ID: TIntegerField
      FieldName = 'HISTORICOEMPRESTIMO_ID'
      Required = True
    end
    object tblHistoricoEmprestimoFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
    end
    object tblHistoricoEmprestimoDATA: TDateField
      FieldName = 'DATA'
      EditMask = '!99/99/0000;1;_'
    end
    object tblHistoricoEmprestimoVALOR: TIBBCDField
      FieldName = 'VALOR'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblHistoricoEmprestimoSTATUS: TIBStringField
      FieldName = 'STATUS'
      Size = 1
    end
  end
  object tblFornecedor_Emprestimo: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'FORNECEDOR_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME_RAZAOSOCIAL'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CPF_CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'RG_IE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'DATA_CADASTRO'
        DataType = ftDate
      end
      item
        Name = 'TELEFONES'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'AVALISTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CPF_AVALISTA'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'OBS'
        DataType = ftBlob
      end
      item
        Name = 'SACARIA'
        DataType = ftInteger
      end
      item
        Name = 'EMPRESTIMO'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'ENDERECOS_ID'
        DataType = ftInteger
      end>
    IndexFieldNames = 'FORNECEDOR_ID'
    MasterFields = 'FORNECEDOR_ID'
    MasterSource = DataSource8
    StoreDefs = True
    TableName = 'FORNECEDOR'
    Left = 152
    Top = 440
    object tblFornecedor_EmprestimoFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Required = True
    end
    object tblFornecedor_EmprestimoNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Size = 50
    end
    object tblFornecedor_EmprestimoEMPRESTIMO: TIBBCDField
      FieldName = 'EMPRESTIMO'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object DataSource8: TDataSource
    DataSet = tblHistoricoEmprestimo
    Left = 96
    Top = 440
  end
  object tblUsuarios: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'USUARIOS'
    Left = 184
    Top = 88
    object tblUsuariosUSUARIO_ID: TIntegerField
      FieldName = 'USUARIO_ID'
      Required = True
    end
    object tblUsuariosNOME: TIBStringField
      FieldName = 'NOME'
    end
    object tblUsuariosSENHA: TIBStringField
      FieldName = 'SENHA'
      Size = 8
    end
  end
  object tblCliente: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblClienteNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'CLIENTE'
    Left = 344
    Top = 40
    object tblClienteCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Required = True
    end
    object tblClienteENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
    end
    object tblClienteNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Size = 50
    end
    object tblClienteCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Size = 14
    end
    object tblClienteRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Size = 15
    end
    object tblClienteDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
    end
    object tblClienteTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Size = 50
    end
    object tblClienteEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Size = 40
    end
    object tblClienteOBS: TBlobField
      FieldName = 'OBS'
    end
  end
  object DataSource9: TDataSource
    DataSet = tblCliente
    Left = 392
    Top = 40
  end
  object tblEnderecoCompleto2: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    IndexFieldNames = 'ENDERECOS_ID'
    MasterFields = 'ENDERECOS_ID'
    MasterSource = DataSource9
    TableName = 'ENDERECOCOMPLETO'
    Left = 432
    Top = 40
    object tblEnderecoCompleto2ENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
    end
    object tblEnderecoCompleto2LOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Size = 70
    end
    object tblEnderecoCompleto2CEP: TIBStringField
      FieldName = 'CEP'
      Size = 8
    end
    object tblEnderecoCompleto2NOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Size = 50
    end
    object tblEnderecoCompleto2NOMEMUNICIPIO: TIBStringField
      FieldName = 'NOMEMUNICIPIO'
      Size = 50
    end
    object tblEnderecoCompleto2UF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
  end
  object tblCadProduto: TIBTable
    Database = BaseDados
    Transaction = Transacao
    OnNewRecord = tblCadProdutoNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PRODUTO'
    Left = 344
    Top = 88
    object tblCadProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Required = True
    end
    object tblCadProdutoDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object tblCadProdutoESTFORNECEDOR: TIBBCDField
      FieldName = 'ESTFORNECEDOR'
      Precision = 18
      Size = 2
    end
    object tblCadProdutoESTEMPRESA: TIBBCDField
      FieldName = 'ESTEMPRESA'
      Precision = 18
      Size = 2
    end
    object tblCadProdutoVALORCOMPRA: TIBBCDField
      FieldName = 'VALORCOMPRA'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblCadProdutoVALORVENDA: TIBBCDField
      FieldName = 'VALORVENDA'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblCadProdutoUND: TIBStringField
      FieldName = 'UND'
      Size = 4
    end
  end
  object dspCompra: TDataSetProvider
    DataSet = tblCompra
    Constraints = True
    Left = 336
    Top = 168
  end
  object tblCompra: TIBTable
    Database = BaseDados
    Transaction = Transacao
    ObjectView = True
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'COMPRA_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FORNECEDOR_ID'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDate
      end
      item
        Name = 'OPCAO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FUNRURAL'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'VOLUME'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'XPKCOMPRA'
        Fields = 'COMPRA_ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'COMPRA'
    Left = 336
    Top = 216
    object tblCompraCOMPRA_ID: TIntegerField
      FieldName = 'COMPRA_ID'
      Required = True
    end
    object tblCompraFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
    end
    object tblCompraDATA: TDateField
      FieldName = 'DATA'
    end
    object tblCompraFUNRURAL: TIBBCDField
      FieldName = 'FUNRURAL'
      Precision = 18
      Size = 2
    end
    object tblCompraOPCAO: TIBStringField
      FieldName = 'OPCAO'
    end
    object tblCompraVOLUME: TIntegerField
      FieldName = 'VOLUME'
    end
  end
  object cdsCompra: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCompra'
    OnNewRecord = cdsCompraNewRecord
    Left = 488
    Top = 216
    object cdsCompraCOMPRA_ID: TIntegerField
      FieldName = 'COMPRA_ID'
      Required = True
    end
    object cdsCompraFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
    end
    object cdsCompraDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsCompraFUNRURAL: TBCDField
      FieldName = 'FUNRURAL'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Precision = 18
      Size = 2
    end
    object cdsCompratblItensCompra: TDataSetField
      FieldName = 'tblItensCompra'
    end
    object cdsCompraOPCAO: TStringField
      FieldName = 'OPCAO'
    end
    object cdsCompraVOLUME: TIntegerField
      FieldName = 'VOLUME'
    end
  end
  object tblItensCompra: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'ITENSCOMPRA_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'COMPRA_ID'
        DataType = ftInteger
      end
      item
        Name = 'PRODUTO_ID'
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'VALOR_TOTAL'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'APROVEITAMENTO'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'XPKITENSCOMPRA'
        Fields = 'ITENSCOMPRA_ID'
        Options = [ixUnique]
      end
      item
        Name = 'IDX_ITENSCOMPRA'
        Fields = 'COMPRA_ID'
      end>
    IndexFieldNames = 'COMPRA_ID'
    MasterFields = 'COMPRA_ID'
    MasterSource = dsCompra
    StoreDefs = True
    TableName = 'ITENSCOMPRA'
    Left = 336
    Top = 272
    object tblItensCompraITENSCOMPRA_ID: TIntegerField
      FieldName = 'ITENSCOMPRA_ID'
      Required = True
    end
    object tblItensCompraCOMPRA_ID: TIntegerField
      FieldName = 'COMPRA_ID'
    end
    object tblItensCompraPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
    end
    object tblItensCompraQUANTIDADE: TIBBCDField
      FieldName = 'QUANTIDADE'
      Precision = 18
      Size = 2
    end
    object tblItensCompraVALOR_TOTAL: TIBBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object tblItensCompraAPROVEITAMENTO: TIBBCDField
      FieldName = 'APROVEITAMENTO'
      Precision = 18
      Size = 2
    end
  end
  object dsCompra: TDataSource
    DataSet = tblCompra
    Left = 408
    Top = 216
  end
  object dsItensCompra: TDataSource
    DataSet = tblItensCompra
    Left = 408
    Top = 272
  end
  object cdsItensCompra: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cdsCompratblItensCompra
    Params = <>
    BeforePost = cdsItensCompraBeforePost
    BeforeDelete = cdsItensCompraBeforeDelete
    OnCalcFields = cdsItensCompraCalcFields
    OnNewRecord = cdsItensCompraNewRecord
    Left = 488
    Top = 272
    object cdsItensCompraITENSCOMPRA_ID: TIntegerField
      DisplayWidth = 19
      FieldName = 'ITENSCOMPRA_ID'
      Required = True
    end
    object cdsItensCompraCOMPRA_ID: TIntegerField
      DisplayWidth = 13
      FieldName = 'COMPRA_ID'
    end
    object cdsItensCompraPRODUTO_ID: TIntegerField
      DisplayWidth = 14
      FieldName = 'PRODUTO_ID'
      OnValidate = cdsItensCompraPRODUTO_IDValidate
    end
    object cdsItensCompraQUANTIDADE: TBCDField
      DisplayLabel = 'Quant.'
      DisplayWidth = 11
      FieldName = 'QUANTIDADE'
      Precision = 18
      Size = 2
    end
    object cdsItensCompraAPROVEITAMENTO: TBCDField
      DisplayWidth = 23
      FieldName = 'APROVEITAMENTO'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Precision = 18
      Size = 2
    end
    object cdsItensCompraVTotal: TFloatField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 12
      FieldKind = fkInternalCalc
      FieldName = 'VTotal'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
    end
    object cdsItensCompraNomeProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 24
      FieldKind = fkLookup
      FieldName = 'NomeProduto'
      LookupDataSet = tblProdutoCompra
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'DESCRICAO'
      KeyFields = 'PRODUTO_ID'
      Lookup = True
    end
    object cdsItensCompraVUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'VUnitario'
      LookupDataSet = tblProdutoCompra
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'VALORCOMPRA'
      KeyFields = 'PRODUTO_ID'
      ReadOnly = True
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Lookup = True
    end
    object cdsItensCompraUND: TStringField
      FieldKind = fkLookup
      FieldName = 'UND'
      LookupDataSet = tblProdutoCompra
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'UND'
      KeyFields = 'PRODUTO_ID'
      ReadOnly = True
      Lookup = True
    end
    object cdsItensCompraVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Precision = 18
      Size = 2
    end
    object cdsItensCompravalor: TAggregateField
      FieldName = 'valor'
      Active = True
      currency = True
      Expression = 'SUM ( VALOR_TOTAL )'
    end
  end
  object tblProdutoCompra: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'PRODUTO_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ESTFORNECEDOR'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'ESTEMPRESA'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'VALORCOMPRA'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'VALORVENDA'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'UND'
        DataType = ftString
        Size = 4
      end>
    IndexDefs = <
      item
        Name = 'XPKPRODUTO'
        Fields = 'PRODUTO_ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'PRODUTO'
    Left = 400
    Top = 168
    object tblProdutoCompraPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Required = True
    end
    object tblProdutoCompraDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object tblProdutoCompraESTFORNECEDOR: TIBBCDField
      FieldName = 'ESTFORNECEDOR'
      Precision = 18
      Size = 2
    end
    object tblProdutoCompraESTEMPRESA: TIBBCDField
      FieldName = 'ESTEMPRESA'
      Precision = 18
      Size = 2
    end
    object tblProdutoCompraVALORCOMPRA: TIBBCDField
      FieldName = 'VALORCOMPRA'
      Precision = 18
      Size = 2
    end
    object tblProdutoCompraVALORVENDA: TIBBCDField
      FieldName = 'VALORVENDA'
      Precision = 18
      Size = 2
    end
    object tblProdutoCompraUND: TIBStringField
      FieldName = 'UND'
      Size = 4
    end
  end
  object dscdsCompra: TDataSource
    DataSet = cdsCompra
    Left = 576
    Top = 216
  end
  object dscdsItensCompra: TDataSource
    DataSet = cdsItensCompra
    Left = 576
    Top = 272
  end
  object qryPesquisa: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 536
    Top = 32
  end
  object qryUtil: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 592
    Top = 32
  end
  object dspVenda: TDataSetProvider
    DataSet = tblVenda
    Constraints = True
    Left = 336
    Top = 344
  end
  object tblVenda: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'VENDA_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CLIENTE_ID'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDate
      end>
    IndexDefs = <
      item
        Name = 'XPKVENDA'
        Fields = 'VENDA_ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'VENDA'
    Left = 336
    Top = 400
    object tblVendaVENDA_ID: TIntegerField
      FieldName = 'VENDA_ID'
      Required = True
    end
    object tblVendaCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
    end
    object tblVendaDATA: TDateField
      FieldName = 'DATA'
    end
  end
  object tblItensVenda: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'ITENSVENDA_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'PRODUTO_ID'
        DataType = ftInteger
      end
      item
        Name = 'VENDA_ID'
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'VALORTOTAL'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'XPKITENSVENDA'
        Fields = 'ITENSVENDA_ID'
        Options = [ixUnique]
      end>
    IndexFieldNames = 'VENDA_ID'
    MasterFields = 'VENDA_ID'
    MasterSource = dsVenda
    StoreDefs = True
    TableName = 'ITENSVENDA'
    Left = 336
    Top = 448
    object tblItensVendaITENSVENDA_ID: TIntegerField
      FieldName = 'ITENSVENDA_ID'
      Required = True
    end
    object tblItensVendaPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
    end
    object tblItensVendaVENDA_ID: TIntegerField
      FieldName = 'VENDA_ID'
    end
    object tblItensVendaQUANTIDADE: TIBBCDField
      FieldName = 'QUANTIDADE'
      Precision = 18
      Size = 2
    end
    object tblItensVendaVALORTOTAL: TIBBCDField
      FieldName = 'VALORTOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object tblProdutoVenda: TIBTable
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PRODUTO'
    Left = 400
    Top = 344
    object tblProdutoVendaPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Required = True
    end
    object tblProdutoVendaDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object tblProdutoVendaESTFORNECEDOR: TIBBCDField
      FieldName = 'ESTFORNECEDOR'
      Precision = 18
      Size = 2
    end
    object tblProdutoVendaESTEMPRESA: TIBBCDField
      FieldName = 'ESTEMPRESA'
      Precision = 18
      Size = 2
    end
    object tblProdutoVendaVALORCOMPRA: TIBBCDField
      FieldName = 'VALORCOMPRA'
      Precision = 18
      Size = 2
    end
    object tblProdutoVendaVALORVENDA: TIBBCDField
      FieldName = 'VALORVENDA'
      Precision = 18
      Size = 2
    end
    object tblProdutoVendaUND: TIBStringField
      FieldName = 'UND'
      Size = 4
    end
  end
  object dsVenda: TDataSource
    DataSet = tblVenda
    Left = 408
    Top = 400
  end
  object dsItensVenda: TDataSource
    DataSet = tblItensVenda
    Left = 408
    Top = 448
  end
  object cdsVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    OnNewRecord = cdsVendaNewRecord
    Left = 480
    Top = 400
    object cdsVendaVENDA_ID: TIntegerField
      FieldName = 'VENDA_ID'
      Required = True
    end
    object cdsVendaCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
    end
    object cdsVendaDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsVendatblItensVenda: TDataSetField
      FieldName = 'tblItensVenda'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cdsVendatblItensVenda
    Params = <>
    BeforePost = cdsItensVendaBeforePost
    BeforeDelete = cdsItensVendaBeforeDelete
    OnCalcFields = cdsItensVendaCalcFields
    OnNewRecord = cdsItensVendaNewRecord
    Left = 480
    Top = 448
    object cdsItensVendaITENSVENDA_ID: TIntegerField
      FieldName = 'ITENSVENDA_ID'
      Required = True
    end
    object cdsItensVendaPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      OnValidate = cdsItensVendaPRODUTO_IDValidate
    end
    object cdsItensVendaVENDA_ID: TIntegerField
      FieldName = 'VENDA_ID'
    end
    object cdsItensVendaQUANTIDADE: TBCDField
      FieldName = 'QUANTIDADE'
      Precision = 18
      Size = 2
    end
    object cdsItensVendaVALORTOTAL: TBCDField
      FieldName = 'VALORTOTAL'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Precision = 18
      Size = 2
    end
    object cdsItensVendaVTotal: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'VTotal'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
    end
    object cdsItensVendaNomeProduto: TStringField
      FieldKind = fkLookup
      FieldName = 'NomeProduto'
      LookupDataSet = tblProdutoVenda
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'DESCRICAO'
      KeyFields = 'PRODUTO_ID'
      Lookup = True
    end
    object cdsItensVendaVUnitario: TFloatField
      FieldKind = fkLookup
      FieldName = 'VUnitario'
      LookupDataSet = tblProdutoVenda
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'VALORVENDA'
      KeyFields = 'PRODUTO_ID'
      DisplayFormat = '#,###.00'
      EditFormat = '#,###.00'
      Lookup = True
    end
    object cdsItensVendaUND: TStringField
      FieldKind = fkLookup
      FieldName = 'UND'
      LookupDataSet = tblProdutoVenda
      LookupKeyFields = 'PRODUTO_ID'
      LookupResultField = 'UND'
      KeyFields = 'PRODUTO_ID'
      Lookup = True
    end
    object cdsItensVendavalor: TAggregateField
      FieldName = 'valor'
      Active = True
      currency = True
      Expression = 'SUM ( VALORTOTAL)'
    end
  end
  object dscdsVenda: TDataSource
    DataSet = cdsVenda
    Left = 560
    Top = 400
  end
  object dscdsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 560
    Top = 448
  end
  object qryRelEnderecos: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM ENDERECOCOMPLETO')
    Left = 48
    Top = 504
    object qryRelEnderecosENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
      Origin = 'ENDERECOCOMPLETO.ENDERECOS_ID'
    end
    object qryRelEnderecosLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Origin = 'ENDERECOCOMPLETO.LOGRADOURO'
      Size = 70
    end
    object qryRelEnderecosCEP: TIBStringField
      FieldName = 'CEP'
      Origin = 'ENDERECOCOMPLETO.CEP'
      EditMask = '00.000-000;0;_'
      Size = 8
    end
    object qryRelEnderecosNOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Origin = 'ENDERECOCOMPLETO.NOMEBAIRRO'
      Size = 50
    end
    object qryRelEnderecosNOMEMUNICIPIO: TIBStringField
      FieldName = 'NOMEMUNICIPIO'
      Origin = 'ENDERECOCOMPLETO.NOMEMUNICIPIO'
      Size = 50
    end
    object qryRelEnderecosUF: TIBStringField
      FieldName = 'UF'
      Origin = 'ENDERECOCOMPLETO.UF'
      Size = 2
    end
  end
  object qryRelFornecedor: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM FORNECEDORENDERECO')
    Left = 120
    Top = 504
    object qryRelFornecedorFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Origin = 'FORNECEDORENDERECO.FORNECEDOR_ID'
    end
    object qryRelFornecedorNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Origin = 'FORNECEDORENDERECO.NOME_RAZAOSOCIAL'
      Size = 50
    end
    object qryRelFornecedorCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'FORNECEDORENDERECO.CPF_CNPJ'
      Size = 14
    end
    object qryRelFornecedorRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Origin = 'FORNECEDORENDERECO.RG_IE'
      Size = 15
    end
    object qryRelFornecedorDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'FORNECEDORENDERECO.DATA_CADASTRO'
    end
    object qryRelFornecedorTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Origin = 'FORNECEDORENDERECO.TELEFONES'
      Size = 50
    end
    object qryRelFornecedorEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = 'FORNECEDORENDERECO.EMAIL'
      Size = 40
    end
    object qryRelFornecedorAVALISTA: TIBStringField
      FieldName = 'AVALISTA'
      Origin = 'FORNECEDORENDERECO.AVALISTA'
      Size = 50
    end
    object qryRelFornecedorCPF_AVALISTA: TIBStringField
      FieldName = 'CPF_AVALISTA'
      Origin = 'FORNECEDORENDERECO.CPF_AVALISTA'
      FixedChar = True
      Size = 11
    end
    object qryRelFornecedorOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'FORNECEDORENDERECO.OBS'
      Size = 8
    end
    object qryRelFornecedorSACARIA: TIntegerField
      FieldName = 'SACARIA'
      Origin = 'FORNECEDORENDERECO.SACARIA'
    end
    object qryRelFornecedorEMPRESTIMO: TIBBCDField
      FieldName = 'EMPRESTIMO'
      Origin = 'FORNECEDORENDERECO.EMPRESTIMO'
      Precision = 18
      Size = 2
    end
    object qryRelFornecedorENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
      Origin = 'FORNECEDORENDERECO.ENDERECOS_ID'
    end
    object qryRelFornecedorLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Origin = 'FORNECEDORENDERECO.LOGRADOURO'
      Size = 70
    end
    object qryRelFornecedorCEP: TIBStringField
      FieldName = 'CEP'
      Origin = 'FORNECEDORENDERECO.CEP'
      EditMask = '00.000-000;0;_'
      Size = 8
    end
    object qryRelFornecedorNOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Origin = 'FORNECEDORENDERECO.NOMEBAIRRO'
      Size = 50
    end
    object qryRelFornecedorNOMEMUNICIPIO: TIBStringField
      FieldName = 'NOMEMUNICIPIO'
      Origin = 'FORNECEDORENDERECO.NOMEMUNICIPIO'
      Size = 50
    end
    object qryRelFornecedorUF: TIBStringField
      FieldName = 'UF'
      Origin = 'FORNECEDORENDERECO.UF'
      Size = 2
    end
  end
  object qryRelCliente: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM CLIENTEENDERECO')
    Left = 192
    Top = 504
    object qryRelClienteCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTEENDERECO.CLIENTE_ID'
    end
    object qryRelClienteNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Origin = 'CLIENTEENDERECO.NOME_RAZAOSOCIAL'
      Size = 50
    end
    object qryRelClienteCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'CLIENTEENDERECO.CPF_CNPJ'
      Size = 14
    end
    object qryRelClienteRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Origin = 'CLIENTEENDERECO.RG_IE'
      Size = 15
    end
    object qryRelClienteDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'CLIENTEENDERECO.DATA_CADASTRO'
    end
    object qryRelClienteTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Origin = 'CLIENTEENDERECO.TELEFONES'
      Size = 50
    end
    object qryRelClienteEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = 'CLIENTEENDERECO.EMAIL'
      Size = 40
    end
    object qryRelClienteOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'CLIENTEENDERECO.OBS'
      Size = 8
    end
    object qryRelClienteENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
      Origin = 'CLIENTEENDERECO.ENDERECOS_ID'
    end
    object qryRelClienteLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Origin = 'CLIENTEENDERECO.LOGRADOURO'
      Size = 70
    end
    object qryRelClienteCEP: TIBStringField
      FieldName = 'CEP'
      Origin = 'CLIENTEENDERECO.CEP'
      Size = 8
    end
    object qryRelClienteNOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Origin = 'CLIENTEENDERECO.NOMEBAIRRO'
      Size = 50
    end
    object qryRelClienteNOMEMUNICIPIO: TIBStringField
      FieldName = 'NOMEMUNICIPIO'
      Origin = 'CLIENTEENDERECO.NOMEMUNICIPIO'
      Size = 50
    end
    object qryRelClienteUF: TIBStringField
      FieldName = 'UF'
      Origin = 'CLIENTEENDERECO.UF'
      Size = 2
    end
  end
  object qryRelProduto: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from produto')
    Left = 264
    Top = 504
    object qryRelProdutoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO.PRODUTO_ID'
      Required = True
    end
    object qryRelProdutoDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'PRODUTO.DESCRICAO'
      Size = 50
    end
    object qryRelProdutoESTFORNECEDOR: TIBBCDField
      FieldName = 'ESTFORNECEDOR'
      Origin = 'PRODUTO.ESTFORNECEDOR'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
      Precision = 18
      Size = 2
    end
    object qryRelProdutoESTEMPRESA: TIBBCDField
      FieldName = 'ESTEMPRESA'
      Origin = 'PRODUTO.ESTEMPRESA'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
      Precision = 18
      Size = 2
    end
    object qryRelProdutoVALORCOMPRA: TIBBCDField
      FieldName = 'VALORCOMPRA'
      Origin = 'PRODUTO.VALORCOMPRA'
      DisplayFormat = 'R$ #,###.00'
      EditFormat = 'R$ #,###.00'
      Precision = 18
      Size = 2
    end
    object qryRelProdutoVALORVENDA: TIBBCDField
      FieldName = 'VALORVENDA'
      Origin = 'PRODUTO.VALORVENDA'
      DisplayFormat = 'R$ #,###.00'
      EditFormat = 'R$ #,###.00'
      Precision = 18
      Size = 2
    end
    object qryRelProdutoUND: TIBStringField
      FieldName = 'UND'
      Origin = 'PRODUTO.UND'
      Size = 4
    end
  end
  object qryRelSacaria: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from fornecedor'
      'where sacaria <> 0')
    Left = 328
    Top = 504
    object qryRelSacariaFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Origin = 'FORNECEDOR.FORNECEDOR_ID'
      Required = True
    end
    object qryRelSacariaNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Origin = 'FORNECEDOR.NOME_RAZAOSOCIAL'
      Size = 50
    end
    object qryRelSacariaCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'FORNECEDOR.CPF_CNPJ'
      Size = 14
    end
    object qryRelSacariaRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Origin = 'FORNECEDOR.RG_IE'
      Size = 15
    end
    object qryRelSacariaDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'FORNECEDOR.DATA_CADASTRO'
    end
    object qryRelSacariaTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Origin = 'FORNECEDOR.TELEFONES'
      Size = 50
    end
    object qryRelSacariaEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = 'FORNECEDOR.EMAIL'
      Size = 40
    end
    object qryRelSacariaAVALISTA: TIBStringField
      FieldName = 'AVALISTA'
      Origin = 'FORNECEDOR.AVALISTA'
      Size = 50
    end
    object qryRelSacariaCPF_AVALISTA: TIBStringField
      FieldName = 'CPF_AVALISTA'
      Origin = 'FORNECEDOR.CPF_AVALISTA'
      FixedChar = True
      Size = 11
    end
    object qryRelSacariaOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'FORNECEDOR.OBS'
      Size = 8
    end
    object qryRelSacariaSACARIA: TIntegerField
      FieldName = 'SACARIA'
      Origin = 'FORNECEDOR.SACARIA'
    end
    object qryRelSacariaEMPRESTIMO: TIBBCDField
      FieldName = 'EMPRESTIMO'
      Origin = 'FORNECEDOR.EMPRESTIMO'
      Precision = 18
      Size = 2
    end
    object qryRelSacariaENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
      Origin = 'FORNECEDOR.ENDERECOS_ID'
    end
  end
  object qryRelEmprestimo: TIBQuery
    Database = BaseDados
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from fornecedor'
      'where emprestimo <> 0')
    Left = 392
    Top = 504
    object qryRelEmprestimoFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      Origin = 'FORNECEDOR.FORNECEDOR_ID'
      Required = True
    end
    object qryRelEmprestimoNOME_RAZAOSOCIAL: TIBStringField
      FieldName = 'NOME_RAZAOSOCIAL'
      Origin = 'FORNECEDOR.NOME_RAZAOSOCIAL'
      Size = 50
    end
    object qryRelEmprestimoCPF_CNPJ: TIBStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'FORNECEDOR.CPF_CNPJ'
      Size = 14
    end
    object qryRelEmprestimoRG_IE: TIBStringField
      FieldName = 'RG_IE'
      Origin = 'FORNECEDOR.RG_IE'
      Size = 15
    end
    object qryRelEmprestimoDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'FORNECEDOR.DATA_CADASTRO'
    end
    object qryRelEmprestimoTELEFONES: TIBStringField
      FieldName = 'TELEFONES'
      Origin = 'FORNECEDOR.TELEFONES'
      Size = 50
    end
    object qryRelEmprestimoEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = 'FORNECEDOR.EMAIL'
      Size = 40
    end
    object qryRelEmprestimoAVALISTA: TIBStringField
      FieldName = 'AVALISTA'
      Origin = 'FORNECEDOR.AVALISTA'
      Size = 50
    end
    object qryRelEmprestimoCPF_AVALISTA: TIBStringField
      FieldName = 'CPF_AVALISTA'
      Origin = 'FORNECEDOR.CPF_AVALISTA'
      FixedChar = True
      Size = 11
    end
    object qryRelEmprestimoOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'FORNECEDOR.OBS'
      Size = 8
    end
    object qryRelEmprestimoSACARIA: TIntegerField
      FieldName = 'SACARIA'
      Origin = 'FORNECEDOR.SACARIA'
    end
    object qryRelEmprestimoEMPRESTIMO: TIBBCDField
      FieldName = 'EMPRESTIMO'
      Origin = 'FORNECEDOR.EMPRESTIMO'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
      Precision = 18
      Size = 2
    end
    object qryRelEmprestimoENDERECOS_ID: TIntegerField
      FieldName = 'ENDERECOS_ID'
      Origin = 'FORNECEDOR.ENDERECOS_ID'
    end
  end
end
