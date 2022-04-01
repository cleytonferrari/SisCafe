unit untCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ActnList, StdCtrls, DBCtrls, Mask, Buttons, ExtCtrls;

type
  TfrmCadCliente = class(TForm)
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
    lbl04: TLabel;
    lbl05: TLabel;
    lbl03: TLabel;
    lbl06: TLabel;
    lbl07: TLabel;
    lbl08: TLabel;
    lbl09: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl12: TLabel;
    btnLocEndereco: TBitBtn;
    edit01: TDBEdit;
    edit02: TDBEdit;
    edit04: TDBEdit;
    edit05: TDBEdit;
    edit03: TDBEdit;
    edit07: TDBEdit;
    edit08: TDBMemo;
    edit09: TDBEdit;
    edit10: TDBEdit;
    edit11: TDBEdit;
    edit13: TDBEdit;
    edit14: TDBEdit;
    edit12: TDBEdit;
    edit06: TDBMemo;
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
    DataSource1: TDataSource;
    DSEndereco: TDataSource;
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit09KeyPress(Sender: TObject; var Key: Char);
    procedure edit09Change(Sender: TObject);
    procedure edit09KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocEnderecoClick(Sender: TObject);
    procedure edit04Exit(Sender: TObject);
    procedure edit04KeyPress(Sender: TObject; var Key: Char);
    procedure edit05KeyPress(Sender: TObject; var Key: Char);
    procedure edit02Enter(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit04Enter(Sender: TObject);
    procedure edit05Enter(Sender: TObject);
    procedure edit06Enter(Sender: TObject);
    procedure edit07Enter(Sender: TObject);
    procedure edit08Enter(Sender: TObject);
    procedure edit09Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit05Exit(Sender: TObject);
    procedure edit06Exit(Sender: TObject);
    procedure edit07Exit(Sender: TObject);
    procedure edit08Exit(Sender: TObject);
    procedure edit09Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;
  Fechar : Boolean;
implementation

uses untDM, untPrincipal, untLocalizar, untControlaTabela;

{$R *.dfm}

procedure TfrmCadCliente.SalvarExecute(Sender: TObject);
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
   if edit09.Text = '' then begin
     edit09.SetFocus;
     lbl09.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit10.Text = 'NÃO LOCALIZADO!')or (edit10.Text = '') then begin
     edit10.SetFocus;
     lbl10.Font.Color := CorLabelError;
     exit;
   end;
  //*************************
  SalvarRegistro(DM.tblCliente);
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;
  DM.tblEnderecoCompleto2.Close;
end;

procedure TfrmCadCliente.CancelarExecute(Sender: TObject);
begin
  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.tblCliente);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  if(DM.tblEnderecoCompleto2.Active=True)then
   DM.tblEnderecoCompleto2.Close;
end;

procedure TfrmCadCliente.EditarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.tblCliente);
end;

procedure TfrmCadCliente.SairExecute(Sender: TObject);
begin
 Fechar:= True;
  if(DM.tblEnderecoCompleto2.Active=True)then
   DM.tblEnderecoCompleto2.Close;
 close;
end;

procedure TfrmCadCliente.NovoExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  NovoRegistro(DM.tblCliente);
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
  //Data Cadastro
  DM.tblClienteDATA_CADASTRO.AsDateTime := Now();
  DM.tblClienteCPF_CNPJ.EditMask := '';
end;

procedure TfrmCadCliente.ApagarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  ExcluirRegistro(DM.tblCliente);
  DM.QryCommit.ExecSQL;
end;

procedure TfrmCadCliente.LocalizarExecute(Sender: TObject);
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
    CampoTabela:='SELECT * FROM CLIENTE';

    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='CLIENTE_ID';
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
    DM.tblCliente.Open;
    DM.tblCliente.Locate
        ('CLIENTE_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
    //
    DM.tblEnderecoCompleto2.Open;
    //
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadCliente.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose :=Fechar;
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
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

  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditExit;
  Edit05.Color := CorEditExit;
  Edit06.Color := CorEditExit;
  Edit07.Color := CorEditExit;
  Edit08.Color := CorEditExit;
  Edit09.Color := CorEditExit;
  Edit10.Color := CorEditDisable;
  Edit11.Color := CorEditDisable;
  Edit12.Color := CorEditDisable;
  Edit13.Color := CorEditDisable;
  Edit14.Color := CorEditDisable;
end;

procedure TfrmCadCliente.edit09KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCadCliente.edit09Change(Sender: TObject);
var Existe : Boolean;
begin
try
  Existe := False;
  //LOCATE
   DM.tblEnderecoCompleto2.Open;

   Existe := DM.tblEnderecoCompleto2.Locate
         ('ENDERECOS_ID',strtoint(edit09.Text ),[]);
  if Existe = True then  Begin
     edit10.Text := DM.tblEnderecoCompleto2LOGRADOURO.AsString;
   end else begin
     edit10.Text := 'Não Localizado!';
   end;
   except
    DM.tblEnderecoCompleto2.Close;
   end;
end;

procedure TfrmCadCliente.edit09KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //procedimento para mostrar o nome
  Edit10.SetFocus;
  Edit09.SetFocus;
end;

procedure TfrmCadCliente.btnLocEnderecoClick(Sender: TObject);
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
   DM.tblClienteENDERECOS_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadCliente.edit04Exit(Sender: TObject);
begin
  Edit04.Color := CorEditExit;
  lbl04.font.Color := CorLabel;
  if Length(edit04.Text) = 11 then
   DM.tblClienteCPF_CNPJ.EditMask := '###.###.###-##;0;_'
  else if Length(edit04.Text) = 14 then
   DM.tblClienteCPF_CNPJ.EditMask := '##.###.###/####-##;0;_';
end;

procedure TfrmCadCliente.edit04KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadCliente.edit05KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadCliente.edit02Enter(Sender: TObject);
begin
  Edit02.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit03Enter(Sender: TObject);
begin
  Edit03.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit04Enter(Sender: TObject);
begin
  Edit04.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit05Enter(Sender: TObject);
begin
  Edit05.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit06Enter(Sender: TObject);
begin
  Edit06.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit07Enter(Sender: TObject);
begin
  Edit07.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit08Enter(Sender: TObject);
begin
  Edit08.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit09Enter(Sender: TObject);
begin
  Edit09.Color := CorEditEnter;
end;

procedure TfrmCadCliente.edit02Exit(Sender: TObject);
begin
  Edit02.Color := CorEditExit;
  lbl02.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit03Exit(Sender: TObject);
begin
  Edit03.Color := CorEditExit;
  lbl03.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit05Exit(Sender: TObject);
begin
  Edit05.Color := CorEditExit;
  lbl05.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit06Exit(Sender: TObject);
begin
  Edit06.Color := CorEditExit;
  lbl06.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit07Exit(Sender: TObject);
begin
  Edit07.Color := CorEditExit;
  lbl07.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit08Exit(Sender: TObject);
begin
  Edit08.Color := CorEditExit;
  lbl08.font.Color := CorLabel;
end;

procedure TfrmCadCliente.edit09Exit(Sender: TObject);
begin
  Edit09.Color := CorEditExit;
  lbl09.font.Color := CorLabel;
end;

end.
