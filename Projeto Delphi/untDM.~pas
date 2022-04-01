unit untDM;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBTable, IBQuery,inifiles,
  Provider, DBClient,  Messages,   Windows, Dialogs,Controls,  Forms;

type
  TDM = class(TDataModule)
    BaseDados: TIBDatabase;
    Transacao: TIBTransaction;
    tblBairros: TIBTable;
    tblBairrosBAIRROS_ID: TIntegerField;
    tblBairrosNOME: TIBStringField;
    QryCommit: TIBQuery;
    QryRollback: TIBQuery;
    tblEnderecos: TIBTable;
    tblEnderecosENDERECOS_ID: TIntegerField;
    tblEnderecosBAIRROS_ID: TIntegerField;
    tblEnderecosLOGRADOURO: TIBStringField;
    tblEnderecosCEP: TIBStringField;
    tblEnderecosMUNICIPIO_ID: TIBStringField;
    tblMunicipio: TIBTable;
    tblMunicipioMUNICIPIO_ID: TIBStringField;
    tblMunicipioNOME: TIBStringField;
    tblMunicipioUF: TIBStringField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    tblUF: TIBTable;
    tblUFUF: TIBStringField;
    tblUFUF_ID: TIBStringField;
    tblUFESTADO: TIBStringField;
    tblBairrosCad: TIBTable;
    tblBairrosCadBAIRROS_ID: TIntegerField;
    tblBairrosCadNOME: TIBStringField;
    tblFornecedor: TIBTable;
    tblFornecedorFORNECEDOR_ID: TIntegerField;
    tblFornecedorNOME_RAZAOSOCIAL: TIBStringField;
    tblFornecedorCPF_CNPJ: TIBStringField;
    tblFornecedorRG_IE: TIBStringField;
    tblFornecedorDATA_CADASTRO: TDateField;
    tblFornecedorTELEFONES: TIBStringField;
    tblFornecedorEMAIL: TIBStringField;
    tblFornecedorAVALISTA: TIBStringField;
    tblFornecedorCPF_AVALISTA: TIBStringField;
    tblFornecedorOBS: TBlobField;
    tblFornecedorSACARIA: TIntegerField;
    tblFornecedorEMPRESTIMO: TIBBCDField;
    tblFornecedorENDERECOS_ID: TIntegerField;
    DataSource5: TDataSource;
    tblEnderecoCompleto: TIBTable;
    tblEnderecoCompletoENDERECOS_ID: TIntegerField;
    tblEnderecoCompletoLOGRADOURO: TIBStringField;
    tblEnderecoCompletoCEP: TIBStringField;
    tblEnderecoCompletoNOMEBAIRRO: TIBStringField;
    tblEnderecoCompletoNOMEMUNICIPIO: TIBStringField;
    tblEnderecoCompletoUF: TIBStringField;
    DataSource6: TDataSource;
    tblHistoricoSacaria: TIBTable;
    tblHistoricoSacariaHISTORICOSACARIA_ID: TIntegerField;
    tblHistoricoSacariaFORNECEDOR_ID: TIntegerField;
    tblHistoricoSacariaDATA: TDateField;
    tblHistoricoSacariaQUANT: TIntegerField;
    tblHistoricoSacariaSTATUS: TIBStringField;
    tblFornecedor_Sacaria: TIBTable;
    tblFornecedor_SacariaFORNECEDOR_ID: TIntegerField;
    tblFornecedor_SacariaNOME_RAZAOSOCIAL: TIBStringField;
    tblFornecedor_SacariaSACARIA: TIntegerField;
    DataSource7: TDataSource;
    tblHistoricoEmprestimo: TIBTable;
    tblHistoricoEmprestimoHISTORICOEMPRESTIMO_ID: TIntegerField;
    tblHistoricoEmprestimoFORNECEDOR_ID: TIntegerField;
    tblHistoricoEmprestimoDATA: TDateField;
    tblHistoricoEmprestimoVALOR: TIBBCDField;
    tblHistoricoEmprestimoSTATUS: TIBStringField;
    tblFornecedor_Emprestimo: TIBTable;
    tblFornecedor_EmprestimoFORNECEDOR_ID: TIntegerField;
    tblFornecedor_EmprestimoNOME_RAZAOSOCIAL: TIBStringField;
    tblFornecedor_EmprestimoEMPRESTIMO: TIBBCDField;
    DataSource8: TDataSource;
    tblUsuarios: TIBTable;
    tblUsuariosUSUARIO_ID: TIntegerField;
    tblUsuariosNOME: TIBStringField;
    tblUsuariosSENHA: TIBStringField;
    tblCliente: TIBTable;
    tblClienteCLIENTE_ID: TIntegerField;
    tblClienteENDERECOS_ID: TIntegerField;
    tblClienteNOME_RAZAOSOCIAL: TIBStringField;
    tblClienteCPF_CNPJ: TIBStringField;
    tblClienteRG_IE: TIBStringField;
    tblClienteDATA_CADASTRO: TDateField;
    tblClienteTELEFONES: TIBStringField;
    tblClienteEMAIL: TIBStringField;
    tblClienteOBS: TBlobField;
    DataSource9: TDataSource;
    tblEnderecoCompleto2: TIBTable;
    tblEnderecoCompleto2ENDERECOS_ID: TIntegerField;
    tblEnderecoCompleto2LOGRADOURO: TIBStringField;
    tblEnderecoCompleto2CEP: TIBStringField;
    tblEnderecoCompleto2NOMEBAIRRO: TIBStringField;
    tblEnderecoCompleto2NOMEMUNICIPIO: TIBStringField;
    tblEnderecoCompleto2UF: TIBStringField;
    tblCadProduto: TIBTable;
    tblCadProdutoPRODUTO_ID: TIntegerField;
    tblCadProdutoDESCRICAO: TIBStringField;
    tblCadProdutoESTFORNECEDOR: TIBBCDField;
    tblCadProdutoESTEMPRESA: TIBBCDField;
    tblCadProdutoVALORCOMPRA: TIBBCDField;
    tblCadProdutoVALORVENDA: TIBBCDField;
    tblCadProdutoUND: TIBStringField;
    dspCompra: TDataSetProvider;
    tblCompra: TIBTable;
    tblCompraCOMPRA_ID: TIntegerField;
    tblCompraFORNECEDOR_ID: TIntegerField;
    tblCompraDATA: TDateField;
    tblCompraFUNRURAL: TIBBCDField;
    cdsCompra: TClientDataSet;
    cdsCompraCOMPRA_ID: TIntegerField;
    cdsCompraFORNECEDOR_ID: TIntegerField;
    cdsCompraDATA: TDateField;
    cdsCompraFUNRURAL: TBCDField;
    tblItensCompra: TIBTable;
    tblItensCompraITENSCOMPRA_ID: TIntegerField;
    tblItensCompraCOMPRA_ID: TIntegerField;
    tblItensCompraPRODUTO_ID: TIntegerField;
    tblItensCompraQUANTIDADE: TIBBCDField;
    tblItensCompraVALOR_TOTAL: TIBBCDField;
    tblItensCompraAPROVEITAMENTO: TIBBCDField;
    dsCompra: TDataSource;
    dsItensCompra: TDataSource;
    cdsCompratblItensCompra: TDataSetField;
    cdsItensCompra: TClientDataSet;
    cdsItensCompraITENSCOMPRA_ID: TIntegerField;
    cdsItensCompraCOMPRA_ID: TIntegerField;
    cdsItensCompraPRODUTO_ID: TIntegerField;
    cdsItensCompraQUANTIDADE: TBCDField;
    cdsItensCompraAPROVEITAMENTO: TBCDField;
    cdsItensCompraVTotal: TFloatField;
    cdsItensCompravalor: TAggregateField;
    tblProdutoCompra: TIBTable;
    tblProdutoCompraPRODUTO_ID: TIntegerField;
    tblProdutoCompraDESCRICAO: TIBStringField;
    tblProdutoCompraESTFORNECEDOR: TIBBCDField;
    tblProdutoCompraESTEMPRESA: TIBBCDField;
    tblProdutoCompraVALORCOMPRA: TIBBCDField;
    tblProdutoCompraVALORVENDA: TIBBCDField;
    tblProdutoCompraUND: TIBStringField;
    cdsItensCompraNomeProduto: TStringField;
    cdsItensCompraVUnitario: TFloatField;
    dscdsCompra: TDataSource;
    dscdsItensCompra: TDataSource;
    qryPesquisa: TIBQuery;
    tblCompraOPCAO: TIBStringField;
    cdsCompraOPCAO: TStringField;
    cdsItensCompraUND: TStringField;
    qryUtil: TIBQuery;
    dspVenda: TDataSetProvider;
    tblVenda: TIBTable;
    tblItensVenda: TIBTable;
    tblProdutoVenda: TIBTable;
    dsVenda: TDataSource;
    dsItensVenda: TDataSource;
    cdsVenda: TClientDataSet;
    cdsItensVenda: TClientDataSet;
    dscdsVenda: TDataSource;
    dscdsItensVenda: TDataSource;
    tblVendaVENDA_ID: TIntegerField;
    tblVendaCLIENTE_ID: TIntegerField;
    tblVendaDATA: TDateField;
    tblItensVendaITENSVENDA_ID: TIntegerField;
    tblItensVendaPRODUTO_ID: TIntegerField;
    tblItensVendaVENDA_ID: TIntegerField;
    tblItensVendaQUANTIDADE: TIBBCDField;
    tblItensVendaVALORTOTAL: TIBBCDField;
    tblProdutoVendaPRODUTO_ID: TIntegerField;
    tblProdutoVendaDESCRICAO: TIBStringField;
    tblProdutoVendaESTFORNECEDOR: TIBBCDField;
    tblProdutoVendaESTEMPRESA: TIBBCDField;
    tblProdutoVendaVALORCOMPRA: TIBBCDField;
    tblProdutoVendaVALORVENDA: TIBBCDField;
    tblProdutoVendaUND: TIBStringField;
    cdsVendaVENDA_ID: TIntegerField;
    cdsVendaCLIENTE_ID: TIntegerField;
    cdsVendaDATA: TDateField;
    cdsVendatblItensVenda: TDataSetField;
    cdsItensVendaITENSVENDA_ID: TIntegerField;
    cdsItensVendaPRODUTO_ID: TIntegerField;
    cdsItensVendaVENDA_ID: TIntegerField;
    cdsItensVendaQUANTIDADE: TBCDField;
    cdsItensVendaVALORTOTAL: TBCDField;
    cdsItensVendaVTotal: TFloatField;
    cdsItensVendaNomeProduto: TStringField;
    cdsItensVendaVUnitario: TFloatField;
    cdsItensVendaUND: TStringField;
    cdsItensVendavalor: TAggregateField;
    qryRelEnderecos: TIBQuery;
    qryRelEnderecosENDERECOS_ID: TIntegerField;
    qryRelEnderecosLOGRADOURO: TIBStringField;
    qryRelEnderecosCEP: TIBStringField;
    qryRelEnderecosNOMEBAIRRO: TIBStringField;
    qryRelEnderecosNOMEMUNICIPIO: TIBStringField;
    qryRelEnderecosUF: TIBStringField;
    qryRelFornecedor: TIBQuery;
    qryRelFornecedorFORNECEDOR_ID: TIntegerField;
    qryRelFornecedorNOME_RAZAOSOCIAL: TIBStringField;
    qryRelFornecedorCPF_CNPJ: TIBStringField;
    qryRelFornecedorRG_IE: TIBStringField;
    qryRelFornecedorDATA_CADASTRO: TDateField;
    qryRelFornecedorTELEFONES: TIBStringField;
    qryRelFornecedorEMAIL: TIBStringField;
    qryRelFornecedorAVALISTA: TIBStringField;
    qryRelFornecedorCPF_AVALISTA: TIBStringField;
    qryRelFornecedorOBS: TBlobField;
    qryRelFornecedorSACARIA: TIntegerField;
    qryRelFornecedorEMPRESTIMO: TIBBCDField;
    qryRelFornecedorENDERECOS_ID: TIntegerField;
    qryRelFornecedorLOGRADOURO: TIBStringField;
    qryRelFornecedorCEP: TIBStringField;
    qryRelFornecedorNOMEBAIRRO: TIBStringField;
    qryRelFornecedorNOMEMUNICIPIO: TIBStringField;
    qryRelFornecedorUF: TIBStringField;
    qryRelCliente: TIBQuery;
    qryRelClienteCLIENTE_ID: TIntegerField;
    qryRelClienteNOME_RAZAOSOCIAL: TIBStringField;
    qryRelClienteCPF_CNPJ: TIBStringField;
    qryRelClienteRG_IE: TIBStringField;
    qryRelClienteDATA_CADASTRO: TDateField;
    qryRelClienteTELEFONES: TIBStringField;
    qryRelClienteEMAIL: TIBStringField;
    qryRelClienteOBS: TBlobField;
    qryRelClienteENDERECOS_ID: TIntegerField;
    qryRelClienteLOGRADOURO: TIBStringField;
    qryRelClienteCEP: TIBStringField;
    qryRelClienteNOMEBAIRRO: TIBStringField;
    qryRelClienteNOMEMUNICIPIO: TIBStringField;
    qryRelClienteUF: TIBStringField;
    qryRelProduto: TIBQuery;
    qryRelProdutoPRODUTO_ID: TIntegerField;
    qryRelProdutoDESCRICAO: TIBStringField;
    qryRelProdutoESTFORNECEDOR: TIBBCDField;
    qryRelProdutoESTEMPRESA: TIBBCDField;
    qryRelProdutoVALORCOMPRA: TIBBCDField;
    qryRelProdutoVALORVENDA: TIBBCDField;
    qryRelProdutoUND: TIBStringField;
    qryRelSacaria: TIBQuery;
    qryRelSacariaFORNECEDOR_ID: TIntegerField;
    qryRelSacariaNOME_RAZAOSOCIAL: TIBStringField;
    qryRelSacariaCPF_CNPJ: TIBStringField;
    qryRelSacariaRG_IE: TIBStringField;
    qryRelSacariaDATA_CADASTRO: TDateField;
    qryRelSacariaTELEFONES: TIBStringField;
    qryRelSacariaEMAIL: TIBStringField;
    qryRelSacariaAVALISTA: TIBStringField;
    qryRelSacariaCPF_AVALISTA: TIBStringField;
    qryRelSacariaOBS: TBlobField;
    qryRelSacariaSACARIA: TIntegerField;
    qryRelSacariaEMPRESTIMO: TIBBCDField;
    qryRelSacariaENDERECOS_ID: TIntegerField;
    qryRelEmprestimo: TIBQuery;
    qryRelEmprestimoFORNECEDOR_ID: TIntegerField;
    qryRelEmprestimoNOME_RAZAOSOCIAL: TIBStringField;
    qryRelEmprestimoCPF_CNPJ: TIBStringField;
    qryRelEmprestimoRG_IE: TIBStringField;
    qryRelEmprestimoDATA_CADASTRO: TDateField;
    qryRelEmprestimoTELEFONES: TIBStringField;
    qryRelEmprestimoEMAIL: TIBStringField;
    qryRelEmprestimoAVALISTA: TIBStringField;
    qryRelEmprestimoCPF_AVALISTA: TIBStringField;
    qryRelEmprestimoOBS: TBlobField;
    qryRelEmprestimoSACARIA: TIntegerField;
    qryRelEmprestimoEMPRESTIMO: TIBBCDField;
    qryRelEmprestimoENDERECOS_ID: TIntegerField;
    cdsItensCompraVALOR_TOTAL: TBCDField;
    tblCompraVOLUME: TIntegerField;
    cdsCompraVOLUME: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tblBairrosNewRecord(DataSet: TDataSet);
    procedure tblEnderecosNewRecord(DataSet: TDataSet);
    procedure tblBairrosCadNewRecord(DataSet: TDataSet);
    procedure tblFornecedorNewRecord(DataSet: TDataSet);
    procedure tblHistoricoSacariaNewRecord(DataSet: TDataSet);
    procedure tblHistoricoEmprestimoNewRecord(DataSet: TDataSet);
    procedure tblClienteNewRecord(DataSet: TDataSet);
    procedure tblCadProdutoNewRecord(DataSet: TDataSet);
    procedure cdsItensCompraCalcFields(DataSet: TDataSet);
    procedure cdsCompraNewRecord(DataSet: TDataSet);
    procedure cdsItensCompraNewRecord(DataSet: TDataSet);
    procedure cdsItensCompraPRODUTO_IDValidate(Sender: TField);
    procedure cdsItensCompraBeforePost(DataSet: TDataSet);
    procedure cdsItensCompraBeforeDelete(DataSet: TDataSet);
    procedure cdsItensVendaCalcFields(DataSet: TDataSet);
    procedure cdsItensVendaNewRecord(DataSet: TDataSet);
    procedure cdsVendaNewRecord(DataSet: TDataSet);
    procedure cdsItensVendaPRODUTO_IDValidate(Sender: TField);
    procedure cdsItensVendaBeforePost(DataSet: TDataSet);
    procedure cdsItensVendaBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses untFerramentas, untControlaTabela;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
ArqIni : TIniFile;
BD : String;
begin
  ArqIni := tIniFile.Create(GetCurrentDir+'\SisCafe.ini');
  Try
  BD := ArqIni.ReadString('DADOS', 'BD', BD);
  Finally
  ArqIni.Free;
  end;
  try
    BaseDados.DatabaseName:= BD;
    BaseDados.Connected := True;
  Except
  on E: Exception do
  begin
    SaveLogError('untDM','procedure TDM.DataModuleCreate(Sender: TObject)', E.Message, E.ClassName, '', 'Post');
    Application.MessageBox(
    'Erro ao Conectar o Banco de Dados!'+#13#13+
    'Verifique o caminho do banco de Dados no arquivo SisCafe.ini'+#13#13+
    'e tente novamente!',
    'Aviso'  ,MB_OK+mb_iconerror );
    Application.Terminate;
   end;
  end;

end;

procedure TDM.tblBairrosNewRecord(DataSet: TDataSet);
begin
tblBairrosBAIRROS_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_BAIRROS');
end;

procedure TDM.tblEnderecosNewRecord(DataSet: TDataSet);
begin
tblEnderecosENDERECOS_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_ENDERECOS');
end;

procedure TDM.tblBairrosCadNewRecord(DataSet: TDataSet);
begin
tblBairrosCadBAIRROS_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_BAIRROS');
end;

procedure TDM.tblFornecedorNewRecord(DataSet: TDataSet);
begin
tblFornecedorFORNECEDOR_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_FORNECEDOR');
end;

procedure TDM.tblHistoricoSacariaNewRecord(DataSet: TDataSet);
begin
tblHistoricoSacariaHISTORICOSACARIA_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_HISTORICOSACARIA');
end;

procedure TDM.tblHistoricoEmprestimoNewRecord(DataSet: TDataSet);
begin
tblHistoricoEmprestimoHISTORICOEMPRESTIMO_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_HISTORICOEMPRESTIMO');
end;

procedure TDM.tblClienteNewRecord(DataSet: TDataSet);
begin
tblClienteCLIENTE_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_CLIENTE');
end;

procedure TDM.tblCadProdutoNewRecord(DataSet: TDataSet);
begin
tblCadProdutoPRODUTO_ID.AsInteger :=
  AutoGEN(BaseDados,'GEN_PRODUTO');
end;

procedure TDM.cdsItensCompraCalcFields(DataSet: TDataSet);
begin
  cdsItensCompraVTotal.Value := cdsItensCompraQUANTIDADE.Value *
      cdsItensCompraVUnitario.Value;
end;

procedure TDM.cdsCompraNewRecord(DataSet: TDataSet);
begin
  cdsCompraCOMPRA_ID.AsInteger :=
     AutoGEN(BaseDados,'GEN_COMPRA');
end;

procedure TDM.cdsItensCompraNewRecord(DataSet: TDataSet);
begin
  cdsItensCompraITENSCOMPRA_ID.AsInteger :=
     AutoGEN(BaseDados,'GEN_ITENSCOMPRA');
  cdsItensCompraCOMPRA_ID.AsInteger :=
     cdsCompraCOMPRA_ID.AsInteger;
end;

procedure TDM.cdsItensCompraPRODUTO_IDValidate(Sender: TField);
begin
 if not tblProdutoCompra.Locate('PRODUTO_ID',cdsItensCompraPRODUTO_ID.AsString,[]) then
 begin
   cdsItensCompraNomeProduto.AsString := 'NÃO LOCALIZADO!';
   Abort;
 end;
end;

procedure TDM.cdsItensCompraBeforePost(DataSet: TDataSet);
begin
 if not (DM.cdsItensCompraQUANTIDADE.AsFloat >0) then
  begin
     Application.MessageBox('Informe uma quantidade válida!',
  'Aviso de Validação!',MB_OK+mb_iconerror );
   Abort;
  end;
end;

procedure TDM.cdsItensCompraBeforeDelete(DataSet: TDataSet);
begin
if Application.MessageBox
      ('Confirma a Exclusão do Item selecionado?',
      'Atenção !!!',Mb_YesNo+MB_ICONEXCLAMATION) = mrNo then
      Abort;
end;

procedure TDM.cdsItensVendaCalcFields(DataSet: TDataSet);
begin
  cdsItensVendaVTotal.Value := cdsItensVendaQUANTIDADE.Value *
      cdsItensVendaVUnitario.Value;
end;

procedure TDM.cdsItensVendaNewRecord(DataSet: TDataSet);
begin
  cdsItensVendaITENSVENDA_ID.AsInteger :=
     AutoGEN(BaseDados,'GEN_ITENSVENDA');
  cdsItensVendaVENDA_ID.AsInteger :=
     cdsVendaVENDA_ID.AsInteger;
end;

procedure TDM.cdsVendaNewRecord(DataSet: TDataSet);
begin
  cdsVendaVENDA_ID.AsInteger :=
     AutoGEN(BaseDados,'GEN_VENDA');
end;

procedure TDM.cdsItensVendaPRODUTO_IDValidate(Sender: TField);
begin
 if not tblProdutoVenda.Locate('PRODUTO_ID',cdsItensVendaPRODUTO_ID.AsString,[]) then
 begin
   cdsItensVendaNomeProduto.AsString := 'NÃO LOCALIZADO!';
   Abort;
 end;
end;

procedure TDM.cdsItensVendaBeforePost(DataSet: TDataSet);
begin
 if not (DM.cdsItensVendaQUANTIDADE.AsFloat >0) then
  begin
     Application.MessageBox('Informe uma quantidade válida!',
  'Aviso de Validação!',MB_OK+mb_iconerror );
   Abort;
  end;
end;

procedure TDM.cdsItensVendaBeforeDelete(DataSet: TDataSet);
begin
if Application.MessageBox
      ('Confirma a Exclusão do Item selecionado?',
      'Atenção !!!',Mb_YesNo+MB_ICONEXCLAMATION) = mrNo then
      Abort;
end;

end.
