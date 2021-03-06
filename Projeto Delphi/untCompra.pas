unit untCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls, DB,
  Grids, DBGrids,inifiles;

type
  TfrmCompra = class(TForm)
    Panel1: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSair: TSpeedButton;
    btnNovo: TSpeedButton;
    btnApagar: TSpeedButton;
    btnLocalizar: TSpeedButton;
    DisabilitaCampo: TPanel;
    ActCadBairros: TActionList;
    Salvar: TAction;
    Cancelar: TAction;
    Editar: TAction;
    Sair: TAction;
    Novo: TAction;
    Apagar: TAction;
    Localizar: TAction;
    Menu: TMainMenu;
    Arquivo1: TMenuItem;
    Novo1: TMenuItem;
    Salvar1: TMenuItem;
    cancelar1: TMenuItem;
    Editar1: TMenuItem;
    apagar1: TMenuItem;
    Localizar1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    lbl01: TLabel;
    edit01: TDBEdit;
    lbl03: TLabel;
    edit03: TDBEdit;
    lbl05: TLabel;
    edit05: TDBEdit;
    lbl02: TLabel;
    lbl04: TLabel;
    edit04: TDBEdit;
    gridItens: TDBGrid;
    edit07: TDBEdit;
    lbl07: TLabel;
    btnLocFornecedor: TBitBtn;
    lbl06: TLabel;
    edit06: TEdit;
    edit02: TDBComboBox;
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    edit08: TDBEdit;
    lbl08: TLabel;
    lbl11: TLabel;
    lbl10: TLabel;
    lbl09: TLabel;
    edit10: TEdit;
    edit09: TEdit;
    rgProduto: TRadioGroup;
    edit11: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edit12: TEdit;
    Label2: TLabel;
    edit13: TMaskEdit;
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit05KeyPress(Sender: TObject; var Key: Char);
    procedure edit05Change(Sender: TObject);
    procedure btnLocFornecedorClick(Sender: TObject);
    procedure gridItensEditButtonClick(Sender: TObject);
    procedure edit02Enter(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit04Enter(Sender: TObject);
    procedure edit05Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit04Exit(Sender: TObject);
    procedure edit05Exit(Sender: TObject);
    procedure gridItensKeyPress(Sender: TObject; var Key: Char);
    procedure Excluir1Click(Sender: TObject);
    procedure gridItensColExit(Sender: TObject);
    procedure edit07Change(Sender: TObject);
    procedure edit08KeyPress(Sender: TObject; var Key: Char);
    procedure edit08Enter(Sender: TObject);
    procedure edit08Exit(Sender: TObject);
    procedure calcularRenda;
    procedure rgProdutoClick(Sender: TObject);
    procedure edit09Change(Sender: TObject);
    procedure edit10Change(Sender: TObject);
    procedure edit04Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCompra: TfrmCompra;
  Fechar : Boolean;
  Editar_atu : Boolean;

implementation

uses untDM, untControlaTabela, untPrincipal, untFerramentas, untLocalizar;

{$R *.dfm}

procedure TfrmCompra.SalvarExecute(Sender: TObject);
Var
Opcao,ID,forn,data: String;
quant : integer;
begin
  FocusControl(nil);
  //*************************
  //verifica dados editados
  if edit02.Text = '' then begin
     edit02.SetFocus;
     lbl02.Font.Color := CorLabelError;
     exit;
   end;
   try
    StrToDate(edit03.Text);
   except
     edit03.SetFocus;
     lbl03.Font.Color := CorLabelError;
     exit;
   end;
   if edit04.Text = '' then begin
     edit04.SetFocus;
     lbl04.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit06.Text = 'N?O LOCALIZADO!')or (edit06.Text = '') then begin
     edit06.SetFocus;
     lbl06.Font.Color := CorLabelError;
     exit;
   end;
   //----------//----------//
   //IMPLEMENTAR A VALIDACAO DA GRID
   //----------//----------//



  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
   ID := DM.cdsCompraCOMPRA_ID.AsString;
   Opcao := DM.cdsCompraOPCAO.AsString;
   forn := DM.cdsCompraFORNECEDOR_ID.AsString;
   data := DM.cdsCompraDATA.AsString;
   quant:= DM.cdsCompraVOLUME.AsInteger;


  DM.cdsCompra.Post;
  if (DM.cdsItensCompra.State in [dsInsert, dsEdit]) then
    DM.cdsItensCompra.Post;
  DM.cdsCompra.ApplyUpdates(0);

  DM.cdsCompra.Close;
  DM.cdsItensCompra.Close;
  Application.MessageBox(
  'Registro Salvo com Sucesso!!!',
  'Aviso',MB_OK+MB_ICONINFORMATION);

  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;
  DM.cdsCompra.Close;

  //ATUALIZA O ESTOQUE
  DM.qryUtil.Close;
  DM.qryUtil.SQL.Clear;
  DM.qryUtil.SQL.Add('SELECT * FROM ATU_ESTOQUE(:ID,:OPCAO);');
  DM.qryUtil.ParamByName('ID').AsString := ID;
  DM.qryUtil.ParamByName('OPCAO').AsString := Opcao;
  DM.qryUtil.Open;
  DM.qryUtil.close;
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  //

  if (quant > 0) then begin
    //ATUALIZA VOLUME DE SACARIA
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('INSERT INTO HISTORICOSACARIA VALUES (:CHAVE, :FORN, :DATA, :QUANT, :OP);');
    DM.qryUtil.ParamByName('CHAVE').AsInteger:= AutoGEN(DM.BaseDados,'GEN_HISTORICOSACARIA');
    DM.qryUtil.ParamByName('FORN').AsString := forn;
    DM.qryUtil.ParamByName('DATA').AsString := data;
    DM.qryUtil.ParamByName('QUANT').AsInteger := quant;
    DM.qryUtil.ParamByName('OP').AsString := 'D';
    DM.qryUtil.Open;
    DM.qryUtil.close;
    DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
    //
  end;
  rgProduto.ItemIndex := 0;
  edit09.Clear;
  edit10.Clear;
  edit11.Clear;

end;

procedure TfrmCompra.CancelarExecute(Sender: TObject);
Var
Opcao,ID : String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsCompraCOMPRA_ID.AsString;
  Opcao := DM.cdsCompraOPCAO.AsString;

  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.cdsItensCompra);
  CancelarRegistro(DM.cdsCompra);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  //
  //ATUALIZA O ESTOQUE
  if editar_atu = true then begin
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('SELECT * FROM ATU_ESTOQUE_EDIT(:ID,:OPCAO);');
    DM.qryUtil.ParamByName('ID').AsString := ID;
    DM.qryUtil.ParamByName('OPCAO').AsString := Opcao;
    DM.qryUtil.Open;
    DM.qryUtil.close;
    DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  end;
  //
  Editar_atu := False;

  rgProduto.ItemIndex := 0;
  edit09.Clear;
  edit10.Clear;
  edit11.Clear;
  
end;

procedure TfrmCompra.EditarExecute(Sender: TObject);
Var
 ID, Opcao:String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsCompraCOMPRA_ID.AsString;
  Opcao := DM.cdsCompraOPCAO.AsString;

  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.cdsCompra);

 //ATUALIZA O ESTOQUE
  DM.qryUtil.Close;
  DM.qryUtil.SQL.Clear;
  DM.qryUtil.SQL.Add('SELECT * FROM ATU_ESTOQUE_EDIT(:ID,:OPCAO);');
  DM.qryUtil.ParamByName('ID').AsString := ID;
  DM.qryUtil.ParamByName('OPCAO').AsString := Opcao;
  DM.qryUtil.Open;
  DM.qryUtil.close;
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  //
  Editar_atu:=true;
end;

procedure TfrmCompra.SairExecute(Sender: TObject);
begin
  Fechar:= True;
  Close;
end;

procedure TfrmCompra.NovoExecute(Sender: TObject);
var
 ArqIni : TIniFile;
 FUNRURAL : String;
begin
  DM.tblCompra.Open;
  DisabilitaCampo.Enabled := True;
  //---///----
  //Bug01: ao criar 3 registro seguidos da erro de
  //transa?ao nao active!
  DM.BaseDados.Close;
  DM.BaseDados.Open;
  ///------------------

  NovoRegistro(DM.cdsCompra);

  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
  //Data Cadastro
  DM.cdsCompraDATA.AsDateTime := Now();

  DM.cdsCompraVOLUME.AsInteger := 0;
  DM.cdsCompraOPCAO.AsString := 'DEPOSITO';
  //Auxilia a atualizacao do estoque
  Editar_atu := False;

  //Carrega os Parametros do Sistema do arquivo INI
  ArqIni := tIniFile.Create(GetCurrentDir+'\SisCafe.ini');
  Try
    FUNRURAL := ArqIni.ReadString('PARAMETROS', 'FUNRURAL', FUNRURAL);
      DM.cdsCompraFUNRURAL.AsString := FUNRURAL;
  Finally
    ArqIni.Free;
  end;


end;

procedure TfrmCompra.ApagarExecute(Sender: TObject);
Var
 ID, Opcao : String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsCompraCOMPRA_ID.AsString;
  Opcao := DM.cdsCompraOPCAO.AsString;

  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  //Exclui os itens ///
    if Application.MessageBox
  ('Confirma Exclus?o?','Excluir?',Mb_YesNo+mb_IconQuestion) = mrYes then
  begin
    if Application.MessageBox
      ('Aten??o!!!'+#13+
       'Ao Excluir uma Compra, pode-se optar por Retornar os produtos'+#13+
       'no estoque Fisico retirados por esta Compra.   '+#13+#13+
       'Deseja Retornar os produtos no estoque Fisico retirados por'+#13+
       'esta Compra?',
      'Aten??o !!!',Mb_YesNo+MB_ICONEXCLAMATION) = mrYes then
      begin
       //ATUALIZA O ESTOQUE
        DM.qryUtil.Close;
        DM.qryUtil.SQL.Clear;
        DM.qryUtil.SQL.Add('SELECT * FROM ATU_ESTOQUE_EDIT(:ID,:OPCAO);');
        DM.qryUtil.ParamByName('ID').AsString := ID;
        DM.qryUtil.ParamByName('OPCAO').AsString := Opcao;
        DM.qryUtil.Open;
        DM.qryUtil.close;
        DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
      end;


    //inicio exlusao
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('DELETE FROM ITENSCOMPRA WHERE COMPRA_ID = :ID');
    DM.qryUtil.ParamByName('ID').AsString := DM.cdsCompraCOMPRA_ID.AsString;
    DM.qryUtil.ExecSQL;
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('DELETE FROM COMPRA WHERE COMPRA_ID = :ID');
    DM.qryUtil.ParamByName('ID').AsString := DM.cdsCompraCOMPRA_ID.AsString;
    DM.qryUtil.ExecSQL;
    DM.cdsCompra.ApplyUpdates(0);
    DM.cdsCompra.Close;
    DM.QryCommit.ExecSQL;
    //fim exclusao normal
  end else begin
    DM.cdsCompra.close;
    DM.tblCompra.close;
  end;
end;

procedure TfrmCompra.LocalizarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := False;
  Salvar.Enabled := False;
  Cancelar.Enabled := True;
  Editar.Enabled := True;
  Apagar.Enabled := True;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  //********************
  //Carrega form na mem?ria
  frmLocalizar := TfrmLocalizar.Create(Application);

  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM FORNECEDORCOMPRA';

    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='COMPRA_ID';
    grid.Columns.Items[0].Title.Caption:= 'C?digo';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME_RAZAOSOCIAL';
    grid.Columns.Items[1].Title.Caption:= 'Nome/Raz?o Social';
    Grid.Columns.Add;
    grid.Columns.Items[2].FieldName:='CPF_CNPJ';
    grid.Columns.Items[2].Title.Caption:= 'CPF/CNPJ';
    Grid.Columns.Add;
    grid.Columns.Items[3].FieldName:='DATA';
    grid.Columns.Items[3].Title.Caption:= 'Data da Compra';
    Grid.Columns.Add;
    grid.Columns.Items[4].FieldName:='OPCAO';
    grid.Columns.Items[4].Title.Caption:= 'Tipo de Compra';
    //Adciona a op?oes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('FORNECEDOR');
    EditOpcao.Items.Add('CODIGO');
    //nome real da pesquisa
    CampoPesquisa[0]:='NOME_RAZAOSOCIAL';
    CampoPesquisa[1]:='COMPRA_ID';
    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';

  end;
  frmLocalizar.Caption := 'Localizar Compras';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;

  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.cdsCompra.Open;
    DM.cdsCompra.Locate
        ('COMPRA_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
   DM.tblCompra.Open;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmCompra.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   CanClose :=Fechar;
end;

procedure TfrmCompra.FormCreate(Sender: TObject);
begin
  //Variavel que auxilia a edi?ao dos dados
  //durante a atualiza?ao do Estoque
  Editar_atu:= False;
  
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;

  lbl01.Font.Color := CorLabel;
  lbl02.Font.Color := CorLabel;
  lbl03.Font.Color := CorLabel;
  lbl04.Font.Color := CorLabel;
  lbl05.Font.Color := CorLabel;
  lbl06.Font.Color := CorLabel;
  lbl07.Font.Color := CorLabel;

  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditExit;
  Edit05.Color := CorEditExit;
  Edit06.Color := CorEditDisable;
  Edit07.Color := CorEditDisable;

  rgProduto.ItemIndex := 0;
  edit09.Clear;
  edit10.Clear;
  edit11.Clear;

end;

procedure TfrmCompra.edit05KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCompra.edit05Change(Sender: TObject);
begin
  try
     if edit05.Text <> '' then begin
     DM.qryPesquisa.Close;
     DM.qryPesquisa.SQL.Clear;
     DM.qryPesquisa.SQL.Add(
       'select * from FORNECEDOR where fornecedor_id = :id'
     );
     DM.qryPesquisa.ParamByName('id').AsString := edit05.Text;
     DM.qryPesquisa.Open;
     DM.qryPesquisa.Last;
     DM.qryPesquisa.Prior;

     if (DM.qryPesquisa.RecordCount > 0) then begin
       edit06.Text := DM.qryPesquisa.FieldByName('NOME_RAZAOSOCIAL').AsString;
       edit12.Text := DM.qryPesquisa.FieldByName('SACARIA').AsString;
       edit13.Text := formatFloat('R$ 0.00',DM.qryPesquisa.FieldByName('EMPRESTIMO').AsFloat);
     end else begin
       edit06.Text := 'N?o Localizado!';
       edit12.Clear;
       edit13.Clear;

     end end else begin
       edit06.clear;
       edit12.Clear;
       edit13.Clear;
     end
   except
     DM.qryPesquisa.Close;
   end;
end;

procedure TfrmCompra.btnLocFornecedorClick(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmLocalizar := TfrmLocalizar.Create(Application);
  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM FORNECEDOR';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='FORNECEDOR_ID';
    grid.Columns.Items[0].Title.Caption:= 'C?digo';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME_RAZAOSOCIAL';
    grid.Columns.Items[1].Title.Caption:= 'Nome/Raz?o Social';
    grid.Columns.Items[1].Width := 185;

    //Adciona a op?oes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('NOME/RAZ?O SOCIAL');
    EditOpcao.Items.Add('C?DIGO');
    //nome real da pesquisa
    CampoPesquisa[0]:='NOME_RAZAOSOCIAL';
    CampoPesquisa[1]:='FORNECEDOR_ID';
    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
  end;
  frmLocalizar.Caption := 'Localizar Fornecedor';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;
  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.cdsCompraFORNECEDOR_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmCompra.gridItensEditButtonClick(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmLocalizar := TfrmLocalizar.Create(Application);
  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM PRODUTO';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='PRODUTO_ID';
    grid.Columns.Items[0].Title.Caption:= 'C?digo';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='DESCRICAO';
    grid.Columns.Items[1].Title.Caption:= 'Descri??o';
    grid.Columns.Items[1].Width := 185;

    //Adciona a op?oes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('C?DIGO');
    EditOpcao.Items.Add('DESCRI??O');

    //nome real da pesquisa
    CampoPesquisa[0]:='PRODUTO_ID';
    CampoPesquisa[1]:='DESCRICAO';

    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
  end;
  frmLocalizar.Caption := 'Localizar Produtos';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;
  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    if not (DM.cdsItensCompra.State in [dsInsert, dsEdit]) then
      DM.cdsItensCompra.Edit;
    DM.cdsItensCompraPRODUTO_ID.AsString := ResultadoPesquisa2;
    ResultadoPesquisa2:='0';
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmCompra.edit02Enter(Sender: TObject);
begin
 Edit02.Color := CorEditEnter;
end;

procedure TfrmCompra.edit03Enter(Sender: TObject);
begin
 Edit03.Color := CorEditEnter;
end;

procedure TfrmCompra.edit04Enter(Sender: TObject);
begin
 Edit04.Color := CorEditEnter;
end;

procedure TfrmCompra.edit05Enter(Sender: TObject);
begin
 Edit05.Color := CorEditEnter;
end;

procedure TfrmCompra.edit02Exit(Sender: TObject);
begin
  lbl02.Font.Color := CorLabel;
  Edit02.Color := CorEditExit;
end;

procedure TfrmCompra.edit03Exit(Sender: TObject);
begin
  lbl03.Font.Color := CorLabel;
  Edit03.Color := CorEditExit;
end;

procedure TfrmCompra.edit04Exit(Sender: TObject);
begin
  lbl04.Font.Color := CorLabel;
  Edit04.Color := CorEditExit;
end;

procedure TfrmCompra.edit05Exit(Sender: TObject);
begin
  lbl05.Font.Color := CorLabel;
  Edit05.Color := CorEditExit;
end;

procedure TfrmCompra.gridItensKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edit02.SetFocus;
end;

procedure TfrmCompra.Excluir1Click(Sender: TObject);
begin
 try
  DM.cdsItensCompra.Delete;
 except
 end; 
end;

procedure TfrmCompra.gridItensColExit(Sender: TObject);
begin
  //caucula o valor total!
  if (gridItens.SelectedField =  DM.cdsItensCompraQUANTIDADE)then begin
    if (DM.cdsItenscompra.State in [dsedit, dsinsert] ) then
     DM.cdsItensCompraVALOR_TOTAL.AsFloat :=   DM.cdsItensCompraVTotal.AsFloat
     else begin
      DM.cdsItensCompra.Edit;
      DM.cdsItensCompraVALOR_TOTAL.AsFloat :=   DM.cdsItensCompraVTotal.AsFloat;
     end;
   end;
end;

procedure TfrmCompra.edit07Change(Sender: TObject);
begin
  if edit07.Text <> '' then
  edit07.Text :=  FormatFloat('#.00',StrToFloat(edit07.text));
end;

procedure TfrmCompra.edit08KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCompra.edit08Enter(Sender: TObject);
begin
 Edit08.Color := CorEditEnter;
end;

procedure TfrmCompra.edit08Exit(Sender: TObject);
begin
  lbl08.Font.Color := CorLabel;
  Edit08.Color := CorEditExit;
end;

procedure TfrmCompra.calcularRenda;
Var
 quant, renda, total, funRural : real;
begin
//Procedimento para calcular a renda do produto
//
   try
    quant := StrToFloat(edit09.Text);
   except
    quant := 0;
   end;
   try
    renda := StrTofloat(edit10.Text);
   except
    renda := 0;
   end;
   try
     funRural := (StrToFloat(edit04.Text))/100;
   except
     funRural := 0;
   end;

   if  rgProduto.ItemIndex = 0 then
   begin
   //coco
     total := (quant / 41) * renda;
   end else begin
   //verde
     total := (quant / 14) * renda;
   end;

   total := total - (total * funRural);
   edit11.Text := FormatFloat('0.##', total);

end;

procedure TfrmCompra.rgProdutoClick(Sender: TObject);
begin
  calcularRenda;
end;

procedure TfrmCompra.edit09Change(Sender: TObject);
begin
  calcularRenda;
end;

procedure TfrmCompra.edit10Change(Sender: TObject);
begin
  calcularRenda;
end;

procedure TfrmCompra.edit04Change(Sender: TObject);
begin
  calcularRenda;
end;

end.
