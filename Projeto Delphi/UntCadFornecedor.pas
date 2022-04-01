unit UntCadFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls;

type
  TfrmCadFornecedor = class(TForm)
    Panel1: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSair: TSpeedButton;
    btnNovo: TSpeedButton;
    btnApagar: TSpeedButton;
    btnLocalizar: TSpeedButton;
    DisabilitaCampo: TPanel;
    btnLocEndereco: TBitBtn;
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
    DataSource1: TDataSource;
    lbl02: TLabel;
    edit02: TDBEdit;
    lbl04: TLabel;
    edit04: TDBEdit;
    lbl05: TLabel;
    edit05: TDBEdit;
    lbl03: TLabel;
    edit03: TDBEdit;
    lbl06: TLabel;
    lbl07: TLabel;
    edit07: TDBEdit;
    lbl10: TLabel;
    edit10: TDBEdit;
    lbl11: TLabel;
    edit11: TDBEdit;
    lbl12: TLabel;
    lbl08: TLabel;
    edit08: TDBEdit;
    lbl09: TLabel;
    edit09: TDBEdit;
    edit12: TDBMemo;
    lbl13: TLabel;
    edit13: TDBEdit;
    lbl14: TLabel;
    edit14: TDBEdit;
    DSEndereco: TDataSource;
    lbl15: TLabel;
    edit15: TDBEdit;
    lbl17: TLabel;
    edit17: TDBEdit;
    lbl18: TLabel;
    edit18: TDBEdit;
    lbl16: TLabel;
    edit16: TDBEdit;
    edit06: TDBMemo;
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit13KeyPress(Sender: TObject; var Key: Char);
    procedure edit13Change(Sender: TObject);
    procedure edit13KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocEnderecoClick(Sender: TObject);
    procedure edit02Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit04Enter(Sender: TObject);
    procedure edit04Exit(Sender: TObject);
    procedure edit05Enter(Sender: TObject);
    procedure edit05Exit(Sender: TObject);
    procedure edit06Enter(Sender: TObject);
    procedure edit06Exit(Sender: TObject);
    procedure edit07Enter(Sender: TObject);
    procedure edit07Exit(Sender: TObject);
    procedure edit08Exit(Sender: TObject);
    procedure edit08Enter(Sender: TObject);
    procedure edit09Enter(Sender: TObject);
    procedure edit09Exit(Sender: TObject);
    procedure edit10Exit(Sender: TObject);
    procedure edit10Enter(Sender: TObject);
    procedure edit11Enter(Sender: TObject);
    procedure edit11Exit(Sender: TObject);
    procedure edit12Exit(Sender: TObject);
    procedure edit12Enter(Sender: TObject);
    procedure edit13Enter(Sender: TObject);
    procedure edit13Exit(Sender: TObject);
    procedure edit04KeyPress(Sender: TObject; var Key: Char);
    procedure edit05KeyPress(Sender: TObject; var Key: Char);
    procedure edit08KeyPress(Sender: TObject; var Key: Char);
    procedure edit09KeyPress(Sender: TObject; var Key: Char);
    procedure edit11KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFornecedor: TfrmCadFornecedor;
  Fechar : Boolean;
implementation

uses untDM, untControlaTabela, untPrincipal, untLocalizar, IBCustomDataSet;

{$R *.dfm}

procedure TfrmCadFornecedor.SalvarExecute(Sender: TObject);
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
   if edit13.Text = '' then begin
     edit13.SetFocus;
     lbl13.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit14.Text = 'NÃO LOCALIZADO!')or (edit14.Text = '') then begin
     edit13.SetFocus;
     lbl13.Font.Color := CorLabelError;
     exit;
   end;
  //*************************
  SalvarRegistro(DM.tblFornecedor);
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;
  DM.tblEnderecoCompleto.Close;
end;

procedure TfrmCadFornecedor.CancelarExecute(Sender: TObject);
begin
  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.tblFornecedor);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  if(DM.tblEnderecoCompleto.Active=True)then
   DM.tblEnderecoCompleto.Close;

end;

procedure TfrmCadFornecedor.EditarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.tblFornecedor);
end;

procedure TfrmCadFornecedor.SairExecute(Sender: TObject);
begin
 Fechar:= True;
  if(DM.tblEnderecoCompleto.Active=True)then
   DM.tblEnderecoCompleto.Close;
 close;
end;

procedure TfrmCadFornecedor.NovoExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  NovoRegistro(DM.tblFornecedor);
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
  //Inicia o saldo da Sacaria e do Emprestimo
  DM.tblFornecedorSACARIA.AsString := '0';
  DM.tblFornecedorEMPRESTIMO.AsCurrency := 0.00;
  //Data Cadastro
  DM.tblFornecedorDATA_CADASTRO.AsDateTime := Now();
  DM.tblFornecedorCPF_CNPJ.EditMask := '';
end;

procedure TfrmCadFornecedor.ApagarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  ExcluirRegistro(DM.tblFornecedor);
  DM.QryCommit.ExecSQL;
end;

procedure TfrmCadFornecedor.LocalizarExecute(Sender: TObject);
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
  //Carrega form na memória
  frmLocalizar := TfrmLocalizar.Create(Application);

  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM FORNECEDOR';

    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='FORNECEDOR_ID';
    grid.Columns.Items[0].Title.Caption:= 'Código';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME_RAZAOSOCIAL';
    grid.Columns.Items[1].Title.Caption:= 'Nome/Razão Social';
    Grid.Columns.Add;
    grid.Columns.Items[2].FieldName:='CPF_CNPJ';
    grid.Columns.Items[2].Title.Caption:= 'CPF/CNPJ';
    Grid.Columns.Add;
    grid.Columns.Items[3].FieldName:='RG_IE';
    grid.Columns.Items[3].Title.Caption:= 'RG/Insc.Estadual';
    //Adciona a opçoes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CODIGO');
    EditOpcao.Items.Add('NOME/RAZÃO SOCIAL');
    //nome real da pesquisa
    CampoPesquisa[0]:='FORNECEDOR_ID';
    CampoPesquisa[1]:='NOME_RAZAOSOCIAL';
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
    DM.tblFornecedor.Open;
    DM.tblFornecedor.Locate
        ('FORNECEDOR_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
    //
    DM.tblEnderecoCompleto.Open;
    //
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadFornecedor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose :=Fechar;
end;

procedure TfrmCadFornecedor.FormCreate(Sender: TObject);
begin
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
  lbl08.Font.Color := CorLabel;
  lbl09.Font.Color := CorLabel;
  lbl10.Font.Color := CorLabel;
  lbl11.Font.Color := CorLabel;
  lbl12.Font.Color := CorLabel;
  lbl13.Font.Color := CorLabel;

  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditExit;
  Edit05.Color := CorEditExit;
  Edit06.Color := CorEditExit;
  Edit07.Color := CorEditExit;
  Edit08.Color := CorEditExit;
  Edit09.Color := CorEditExit;
  Edit10.Color := CorEditExit;
  Edit11.Color := CorEditExit;
  Edit12.Color := CorEditExit;
  Edit13.Color := CorEditExit;
  Edit14.Color := CorEditDisable;
  Edit15.Color := CorEditDisable;
  Edit16.Color := CorEditDisable;
  Edit17.Color := CorEditDisable;
  Edit18.Color := CorEditDisable;
end;

procedure TfrmCadFornecedor.edit13KeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCadFornecedor.edit13Change(Sender: TObject);
var Existe : Boolean;
begin
try
  Existe := False;
  //LOCATE
   DM.tblEnderecoCompleto.Open;

   Existe := DM.tblEnderecoCompleto.Locate
         ('ENDERECOS_ID',strtoint(edit13.Text ),[]);
  if Existe = True then  Begin
     edit14.Text := DM.tblEnderecoCompletoLOGRADOURO.AsString;
   end else begin
     edit14.Text := 'Não Localizado!';
   end;
   except
    DM.tblEnderecoCompleto.Close;
   end;
end;

procedure TfrmCadFornecedor.edit13KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //procedimento para mostrar o nome
  Edit14.SetFocus;
  Edit13.SetFocus;
end;

procedure TfrmCadFornecedor.btnLocEnderecoClick(Sender: TObject);
begin
  //Carrega form na memória
  frmLocalizar := TfrmLocalizar.Create(Application);

  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM ENDERECOCOMPLETO';

    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='ENDERECOS_ID';
    grid.Columns.Items[0].Title.Caption:= 'Código';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='LOGRADOURO';
    grid.Columns.Items[1].Title.Caption:= 'Logradouro';
    Grid.Columns.Add;
    grid.Columns.Items[2].FieldName:='NOMEBAIRRO';
    grid.Columns.Items[2].Title.Caption:= 'Bairro';
    Grid.Columns.Add;
    grid.Columns.Items[3].FieldName:='NOMEMUNICIPIO';
    grid.Columns.Items[3].Title.Caption:= 'Municipio';
    Grid.Columns.Add;
    grid.Columns.Items[4].FieldName:='UF';
    grid.Columns.Items[4].Title.Caption:= 'UF';
    Grid.Columns.Add;
    grid.Columns.Items[5].FieldName:='CEP';
    grid.Columns.Items[5].Title.Caption:= 'Cep';

    //Adciona a opçoes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CODIGO');
    EditOpcao.Items.Add('LOGRADOURO');
    EditOpcao.Items.Add('MUNICIPIO');
    EditOpcao.Items.Add('BAIRRO');

    //nome real da pesquisa
    CampoPesquisa[0]:='ENDERECOS_ID';
    CampoPesquisa[1]:='LOGRADOURO';
    CampoPesquisa[2]:='NOMEMUNICIPIO';
    CampoPesquisa[3]:='NOMEBAIRRO';

    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
    MascaraPesquisa[2]:='';
    MascaraPesquisa[3]:='';

  end;
  frmLocalizar.Caption := 'Localizar Endereços';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;

  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
   DM.tblFornecedorENDERECOS_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;

end;

procedure TfrmCadFornecedor.edit02Enter(Sender: TObject);
begin
  Edit02.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit02Exit(Sender: TObject);
begin
  Edit02.Color := CorEditExit;
  lbl02.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit03Exit(Sender: TObject);
begin
  Edit03.Color := CorEditExit;
  lbl03.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit03Enter(Sender: TObject);
begin
  Edit03.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit04Enter(Sender: TObject);
begin
  Edit04.Color := CorEditEnter;
  DM.tblFornecedorCPF_CNPJ.EditMask := '';
end;

procedure TfrmCadFornecedor.edit04Exit(Sender: TObject);
begin
  Edit04.Color := CorEditExit;
  lbl04.font.Color := CorLabel;
  if Length(edit04.Text) = 11 then
   DM.tblFornecedorCPF_CNPJ.EditMask := '###.###.###-##;0;_'
  else if Length(edit04.Text) = 14 then
   DM.tblFornecedorCPF_CNPJ.EditMask := '##.###.###/####-##;0;_';
end;

procedure TfrmCadFornecedor.edit05Enter(Sender: TObject);
begin
  Edit05.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit05Exit(Sender: TObject);
begin
  Edit05.Color := CorEditExit;
  lbl05.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit06Enter(Sender: TObject);
begin
  Edit06.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit06Exit(Sender: TObject);
begin
  Edit06.Color := CorEditExit;
  lbl06.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit07Enter(Sender: TObject);
begin
  Edit07.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit07Exit(Sender: TObject);
begin
  Edit07.Color := CorEditExit;
  lbl07.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit08Exit(Sender: TObject);
begin
  Edit08.Color := CorEditExit;
  lbl08.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit08Enter(Sender: TObject);
begin
  Edit08.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit09Enter(Sender: TObject);
begin
  Edit09.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit09Exit(Sender: TObject);
begin
  Edit09.Color := CorEditExit;
  lbl09.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit10Exit(Sender: TObject);
begin
  Edit10.Color := CorEditExit;
  lbl10.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit10Enter(Sender: TObject);
begin
  Edit10.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit11Enter(Sender: TObject);
begin
  Edit11.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit11Exit(Sender: TObject);
begin
  Edit11.Color := CorEditExit;
  lbl11.font.Color := CorLabel;
  DM.tblFornecedorCPF_AVALISTA.EditMask := '###.###.###-##;0;_'
end;

procedure TfrmCadFornecedor.edit12Exit(Sender: TObject);
begin
  Edit12.Color := CorEditExit;
  lbl12.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit12Enter(Sender: TObject);
begin
  Edit12.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit13Enter(Sender: TObject);
begin
  Edit13.Color := CorEditEnter;
end;

procedure TfrmCadFornecedor.edit13Exit(Sender: TObject);
begin
  Edit13.Color := CorEditExit;
  lbl13.font.Color := CorLabel;
end;

procedure TfrmCadFornecedor.edit04KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadFornecedor.edit05KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadFornecedor.edit08KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadFornecedor.edit09KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadFornecedor.edit11KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

end.
