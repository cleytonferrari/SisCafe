unit untVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls, DB,
  Grids, DBGrids, IBCustomDataSet, IBQuery;

type
  TfrmVenda = class(TForm)
    Panel1: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSair: TSpeedButton;
    btnNovo: TSpeedButton;
    btnApagar: TSpeedButton;
    btnLocalizar: TSpeedButton;
    DisabilitaCampo: TPanel;
    lbl01: TLabel;
    lbl02: TLabel;
    lbl03: TLabel;
    lbl05: TLabel;
    lbl04: TLabel;
    edit01: TDBEdit;
    edit02: TDBEdit;
    edit03: TDBEdit;
    gridItens: TDBGrid;
    edit05: TDBEdit;
    btnLocCliente: TBitBtn;
    edit04: TEdit;
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
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit03KeyPress(Sender: TObject; var Key: Char);
    procedure edit03Change(Sender: TObject);
    procedure btnLocClienteClick(Sender: TObject);
    procedure gridItensEditButtonClick(Sender: TObject);
    procedure edit02Enter(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure gridItensKeyPress(Sender: TObject; var Key: Char);
    procedure Excluir1Click(Sender: TObject);
    procedure gridItensColExit(Sender: TObject);
    procedure edit05Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVenda: TfrmVenda;
  Fechar : Boolean;
  Editar_atu : Boolean;

implementation

uses untDM, untFerramentas, untControlaTabela, untPrincipal, untLocalizar;

{$R *.dfm}

procedure TfrmVenda.SalvarExecute(Sender: TObject);
Var
ID : String;
begin
  FocusControl(nil);
  //*************************
  //verifica dados editados
   try
    StrToDate(edit02.Text);
   except
     edit02.SetFocus;
     lbl02.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit04.Text = 'N?O LOCALIZADO!')or (edit04.Text = '') then begin
     edit04.SetFocus;
     lbl04.Font.Color := CorLabelError;
     exit;
   end;
   //----------//----------//
   //IMPLEMENTAR A VALIDACAO DA GRID
   //----------//----------//



  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
   ID := DM.cdsVendaVENDA_ID.AsString;

  DM.cdsVenda.Post;
  if (DM.cdsItensVenda.State in [dsInsert, dsEdit]) then
    DM.cdsItensVenda.Post;
  DM.cdsVenda.ApplyUpdates(0);

  DM.cdsVenda.Close;
  DM.cdsItensVenda.Close;
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

  //ATUALIZA O ESTOQUE
  DM.qryUtil.Close;
  DM.qryUtil.SQL.Clear;
  DM.qryUtil.SQL.Add('SELECT * FROM ATU_VENDA(:ID);');
  DM.qryUtil.ParamByName('ID').AsString := ID;
  DM.qryUtil.Open;
  DM.qryUtil.close;
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  //
end;

procedure TfrmVenda.CancelarExecute(Sender: TObject);
Var
 ID : String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsVendaVENDA_ID.AsString;

  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.cdsItensVenda);
  CancelarRegistro(DM.cdsVenda);
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
    DM.qryUtil.SQL.Add('SELECT * FROM ATU_VENDA_EDIT(:ID);');
    DM.qryUtil.ParamByName('ID').AsString := ID;
    DM.qryUtil.Open;
    DM.qryUtil.close;
    DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  end;
  //
  Editar_atu := False;
end;

procedure TfrmVenda.EditarExecute(Sender: TObject);
Var
 ID:String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsVendaVENDA_ID.AsString;

  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.cdsVenda);

 //ATUALIZA O ESTOQUE
  DM.qryUtil.Close;
  DM.qryUtil.SQL.Clear;
  DM.qryUtil.SQL.Add('SELECT * FROM ATU_VENDA_EDIT(:ID);');
  DM.qryUtil.ParamByName('ID').AsString := ID;
  DM.qryUtil.Open;
  DM.qryUtil.close;
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  //
  Editar_atu:=true;
end;

procedure TfrmVenda.SairExecute(Sender: TObject);
begin
  Fechar:= True;
  Close;
end;

procedure TfrmVenda.NovoExecute(Sender: TObject);
begin
  DM.tblVenda.Open;
  DisabilitaCampo.Enabled := True;
  //---///----
  //Bug01: ao criar 3 registro seguidos da erro de
  //transa?ao nao active!
  DM.BaseDados.Close;
  DM.BaseDados.Open;
  ///------------------

  NovoRegistro(DM.cdsVenda);

  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
  //Data Cadastro
  DM.cdsVendaDATA.AsDateTime := Now();
  Editar_atu := False;
end;

procedure TfrmVenda.ApagarExecute(Sender: TObject);
Var
 ID : String;
begin
  //Pega os valores a serem utilizados na
  //atualiza??o do Estoque (StoredProcedure)
  ID := DM.cdsVendaVENDA_ID.AsString;


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
       'Ao Excluir uma Venda, pode-se optar por Retornar os produtos'+#13+
       'no estoque Fisico da Empresa retirados por esta Venda.   '+#13+#13+
       'Deseja Retornar os produtos no estoque Fisico retirados por'+#13+
       'esta Venda?',
      'Aten??o !!!',Mb_YesNo+MB_ICONEXCLAMATION) = mrYes then
      begin
       //ATUALIZA O ESTOQUE
        DM.qryUtil.Close;
        DM.qryUtil.SQL.Clear;
        DM.qryUtil.SQL.Add('SELECT * FROM ATU_VENDA_EDIT(:ID);');
        DM.qryUtil.ParamByName('ID').AsString := ID;
        DM.qryUtil.Open;
        DM.qryUtil.close;
        DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
      end;


    //inicio exlusao
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('DELETE FROM ITENSVENDA WHERE VENDA_ID = :ID');
    DM.qryUtil.ParamByName('ID').AsString := DM.cdsVendaVENDA_ID.AsString;
    DM.qryUtil.ExecSQL;
    DM.qryUtil.Close;
    DM.qryUtil.SQL.Clear;
    DM.qryUtil.SQL.Add('DELETE FROM VENDA WHERE VENDA_ID = :ID');
    DM.qryUtil.ParamByName('ID').AsString := DM.cdsVendaVENDA_ID.AsString;
    DM.qryUtil.ExecSQL;
    DM.cdsVenda.ApplyUpdates(0);
    DM.cdsVenda.Close;
    DM.QryCommit.ExecSQL;
    //fim exclusao normal
  end else begin
    DM.cdsVenda.close;
    DM.tblVenda.close;
  end;
end;

procedure TfrmVenda.LocalizarExecute(Sender: TObject);
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
    CampoTabela:='SELECT * FROM CLIENTEVENDA';

    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='VENDA_ID';
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

    //Adciona a op?oes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CODIGO');
    EditOpcao.Items.Add('CLIENTE');
    //nome real da pesquisa
    CampoPesquisa[0]:='VENDA_ID';
    CampoPesquisa[1]:='NOME_RAZAOSOCIAL';
    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';

  end;
  frmLocalizar.Caption := 'Localizar Vendas';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;

  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.cdsVenda.Open;
    DM.cdsVenda.Locate
        ('VENDA_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
   DM.tblVenda.Open;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmVenda.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose :=Fechar;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
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

  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditDisable;
  Edit05.Color := CorEditDisable;
end;

procedure TfrmVenda.edit03KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmVenda.edit03Change(Sender: TObject);
begin
  try
     if edit03.Text <> '' then begin
     DM.qryPesquisa.Close;
     DM.qryPesquisa.SQL.Clear;
     DM.qryPesquisa.SQL.Add(
       'select * from CLIENTE where cliente_id = :id'
     );
     DM.qryPesquisa.ParamByName('id').AsString := edit03.Text;
     DM.qryPesquisa.Open;
     DM.qryPesquisa.Last;
     DM.qryPesquisa.Prior;

     if (DM.qryPesquisa.RecordCount > 0) then
       edit04.Text := DM.qryPesquisa.FieldByName('NOME_RAZAOSOCIAL').AsString
     else
       edit04.Text := 'N?o Localizado!';

     end else
       edit04.clear;
   except
     DM.qryPesquisa.Close;
   end;

end;

procedure TfrmVenda.btnLocClienteClick(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmLocalizar := TfrmLocalizar.Create(Application);
  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM CLIENTE';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='CLIENTE_ID';
    grid.Columns.Items[0].Title.Caption:= 'C?digo';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME_RAZAOSOCIAL';
    grid.Columns.Items[1].Title.Caption:= 'Nome/Raz?o Social';
    grid.Columns.Items[1].Width := 185;

    //Adciona a op?oes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('C?DIGO');
    EditOpcao.Items.Add('NOME/RAZ?O SOCIAL');

    //nome real da pesquisa
    CampoPesquisa[0]:='CLIENTE_ID';
    CampoPesquisa[1]:='NOME_RAZAOSOCIAL';

    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
  end;
  frmLocalizar.Caption := 'Localizar Cliente';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;
  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.cdsVendaCLIENTE_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmVenda.gridItensEditButtonClick(Sender: TObject);
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
    if not (DM.cdsItensVenda.State in [dsInsert, dsEdit]) then
      DM.cdsItensVenda.Edit;
    DM.cdsItensVendaPRODUTO_ID.AsString := ResultadoPesquisa2;
    ResultadoPesquisa2:='0';
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmVenda.edit02Enter(Sender: TObject);
begin
 Edit02.Color := CorEditEnter;
end;

procedure TfrmVenda.edit03Enter(Sender: TObject);
begin
 Edit03.Color := CorEditEnter;
end;

procedure TfrmVenda.edit02Exit(Sender: TObject);
begin
  lbl02.Font.Color := CorLabel;
  Edit02.Color := CorEditExit;
end;

procedure TfrmVenda.edit03Exit(Sender: TObject);
begin
  lbl03.Font.Color := CorLabel;
  Edit03.Color := CorEditExit;
end;

procedure TfrmVenda.gridItensKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edit02.SetFocus;
end;

procedure TfrmVenda.Excluir1Click(Sender: TObject);
begin
 try
  DM.cdsItensVenda.Delete;
 except
 end; 

end;

procedure TfrmVenda.gridItensColExit(Sender: TObject);
begin
  //caucula o valor total!
  if (gridItens.SelectedField =  DM.cdsItensVendaQUANTIDADE)then begin
    if (DM.cdsItensVenda.State in [dsedit, dsinsert] ) then
       DM.cdsItensVendaVALORTOTAL.AsFloat :=   DM.cdsItensVendaVTotal.AsFloat
       else begin
        DM.cdsItensVenda.Edit; 
        DM.cdsItensVendaVALORTOTAL.AsFloat :=   DM.cdsItensVendaVTotal.AsFloat
       end;
   end;
end;

procedure TfrmVenda.edit05Change(Sender: TObject);
begin
  if edit05.Text <> '' then
  edit05.Text :=  FormatFloat('#.00',StrToFloat(edit05.text));
end;

end.
