unit untCadEnderecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ActnList, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls;

type
  TfrmCadEnderecos = class(TForm)
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
    DataSource2: TDataSource;
    lbl06: TLabel;
    edit06: TDBEdit;
    lbl02: TLabel;
    edit02: TDBEdit;
    lbl08: TLabel;
    edit08: TDBEdit;
    lbl03: TLabel;
    edit03: TDBEdit;
    edit04: TDBEdit;
    edit05: TDBEdit;
    edit07: TDBEdit;
    lbl04: TLabel;
    lbl05: TLabel;
    lbl07: TLabel;
    btnLocBairro: TBitBtn;
    btnLocMunicipio: TBitBtn;
    DSMunicipio: TDataSource;
    DSBairro: TDataSource;
    procedure NovoExecute(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit03KeyPress(Sender: TObject; var Key: Char);
    procedure edit03Change(Sender: TObject);
    procedure edit03KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edit04Change(Sender: TObject);
    procedure edit06KeyPress(Sender: TObject; var Key: Char);
    procedure edit06Change(Sender: TObject);
    procedure edit06KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edit07Change(Sender: TObject);
    procedure btnLocBairroClick(Sender: TObject);
    procedure btnLocMunicipioClick(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit02Enter(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit06Exit(Sender: TObject);
    procedure edit06Enter(Sender: TObject);
    procedure edit08Enter(Sender: TObject);
    procedure edit08Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadEnderecos: TfrmCadEnderecos;
  Fechar:Boolean;


implementation

uses untDM, untControlaTabela, untLocalizar, untPrincipal, untFerramentas;

{$R *.dfm}

procedure TfrmCadEnderecos.NovoExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  NovoRegistro(DM.tblEnderecos);
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
end;

procedure TfrmCadEnderecos.SalvarExecute(Sender: TObject);
begin
  FocusControl(nil);
  //*************************
  //verifica dados editados
   if edit02.Text = '' then begin
     edit02.SetFocus;
     lbl02.Font.Color := CorLabelError;
     exit;
   end;
   if edit03.Text = '' then begin
     edit03.SetFocus;
     lbl03.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit04.Text = 'NÃO LOCALIZADO!')or (edit04.Text = '') then begin
     edit03.SetFocus;
     lbl03.Font.Color := CorLabelError;
     exit;
   end;
   if edit06.Text = '' then begin
     edit06.SetFocus;
     lbl06.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit07.Text = 'NÃO LOCALIZADO!')or (edit07.Text = '') then begin
     edit06.SetFocus;
     lbl06.Font.Color := CorLabelError;
     exit;
   end;
   if DM.tblEnderecosCEP.AsString = ''  then begin
     edit08.SetFocus;
     lbl08.Font.Color := CorLabelError;
     exit;
   end;
  //*************************
  SalvarRegistro(DM.tblEnderecos);
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;
  DM.tblBairros.Close;
  DM.tblMunicipio.Close;

end;

procedure TfrmCadEnderecos.CancelarExecute(Sender: TObject);
begin
  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.tblEnderecos);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
end;

procedure TfrmCadEnderecos.EditarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.tblEnderecos);
end;

procedure TfrmCadEnderecos.ApagarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  ExcluirRegistro(DM.tblEnderecos);
  DM.QryCommit.ExecSQL;
end;

procedure TfrmCadEnderecos.LocalizarExecute(Sender: TObject);
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
    DM.tblEnderecos.Open;
    DM.tblEnderecos.Locate
        ('ENDERECOS_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
    //
    DM.tblBairros.open;
    DM.tblMunicipio.Open;
    //
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;

end;

procedure TfrmCadEnderecos.SairExecute(Sender: TObject);
begin
 Fechar:= True;
  if(DM.tblMunicipio.Active=True)then
   DM.tblMunicipio.Close;
  if(DM.tblBairros.Active=True)then
   DM.tblBairros.Close;
 close;
end;

procedure TfrmCadEnderecos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose :=Fechar;
end;

procedure TfrmCadEnderecos.FormCreate(Sender: TObject);
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
  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditDisable;
  Edit05.Color := CorEditDisable;
  Edit06.Color := CorEditExit;
  Edit07.Color := CorEditDisable;
  Edit08.Color := CorEditExit;
end;

procedure TfrmCadEnderecos.edit03KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCadEnderecos.edit03Change(Sender: TObject);
var Existe : Boolean;
begin
try
  Existe := False;
  //LOCATE
   DM.tblMunicipio.Open;

   Existe := DM.tblMunicipio.Locate
         ('MUNICIPIO_ID',strtoint(edit03.Text ),[]);
  if Existe = True then  Begin
     edit04.Text := DM.tblMunicipioNOME.AsString;
   end else begin
     edit04.Text := 'Não Localizado!';
   end;
   except
    edit04.Text := '';
    DM.tblMunicipio.Close;
   end;
end;

procedure TfrmCadEnderecos.edit03KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //procedimento para mostrar o nome
  Edit04.SetFocus;
  Edit03.SetFocus;
end;

procedure TfrmCadEnderecos.edit04Change(Sender: TObject);
begin
   if (Edit04.Text = '') and
         (DM.tblMunicipio.Active=True)then
    Edit04.Text := 'Não Localizado!';
end;

procedure TfrmCadEnderecos.edit06KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmCadEnderecos.edit06Change(Sender: TObject);
var Existe : Boolean;
begin
try
  Existe := False;
  //LOCATE
   DM.tblBairros.Open;

   Existe := DM.tblBairros.Locate
         ('BAIRROS_ID',strtoint(edit06.Text ),[]);
  if Existe = True then  Begin
     edit07.Text := DM.tblBairrosNOME.AsString;
   end else begin
     edit07.Text := 'Não Localizado!';
   end;
   except
    edit07.Text := '';
    DM.tblBairros.Close;
   end;

end;

procedure TfrmCadEnderecos.edit06KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //procedimento para mostrar o nome
  Edit07.SetFocus;
  Edit06.SetFocus;
end;

procedure TfrmCadEnderecos.edit07Change(Sender: TObject);
begin
   if (Edit07.Text = '') and
         (DM.tblBairros.Active=True)then
    Edit07.Text := 'Não Localizado!';
end;

procedure TfrmCadEnderecos.btnLocBairroClick(Sender: TObject);
begin
  //Carrega form na memória
  frmLocalizar := TfrmLocalizar.Create(Application);
  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM BAIRROS';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='BAIRROS_ID';
    grid.Columns.Items[0].Title.Caption:= 'Código';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME';
    grid.Columns.Items[1].Title.Caption:= 'Nome do Bairro';
    grid.Columns.Items[1].Width := 185;

    //Adciona a opçoes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CÓDIGO');
    EditOpcao.Items.Add('NOME');

    //nome real da pesquisa
    CampoPesquisa[0]:='BAIRROS_ID';
    CampoPesquisa[1]:='NOME';

    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
  end;
  frmLocalizar.Caption := 'Localizar Bairros';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;
  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.tblEnderecosBAIRROS_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadEnderecos.btnLocMunicipioClick(Sender: TObject);
begin
  //Carrega form na memória
  frmLocalizar := TfrmLocalizar.Create(Application);
  with frmLocalizar do
  begin
    Qry_Localizar.Close;
    Qry_Localizar.SQL.Clear;//Limpa
    CampoTabela:='SELECT * FROM MUNICIPIO';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='MUNICIPIO_ID';
    grid.Columns.Items[0].Title.Caption:= 'Código';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='NOME';
    grid.Columns.Items[1].Title.Caption:= 'Nome da Cidade';
    grid.Columns.Items[1].Width := 185;

    //Adciona a opçoes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CÓDIGO');
    EditOpcao.Items.Add('NOME');

    //nome real da pesquisa
    CampoPesquisa[0]:='MUNICIPIO_ID';
    CampoPesquisa[1]:='NOME';

    //Mascara para a pesquisa
    MascaraPesquisa[0]:='';
    MascaraPesquisa[1]:='';
  end;
  frmLocalizar.Caption := 'Localizar Municipio';
  //Mostra form em modo exclusivo
  try
   frmLocalizar.ShowModal;
  finally
   frmLocalizar.Release;
   frmLocalizar := nil;
  end;
  if ResultadoPesquisa2 <> '0' then
  begin
    DM.tblEnderecosMUNICIPIO_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadEnderecos.edit02Exit(Sender: TObject);
begin
  Edit02.Color := CorEditExit;
  lbl02.font.Color := CorLabel;
end;

procedure TfrmCadEnderecos.edit02Enter(Sender: TObject);
begin
  Edit02.Color := CorEditEnter;
end;

procedure TfrmCadEnderecos.edit03Enter(Sender: TObject);
begin
  Edit03.Color := CorEditEnter;
end;

procedure TfrmCadEnderecos.edit03Exit(Sender: TObject);
begin
  Edit03.Color := CorEditExit;
  lbl03.font.Color := CorLabel;
end;

procedure TfrmCadEnderecos.edit06Exit(Sender: TObject);
begin
  Edit06.Color := CorEditExit;
  lbl06.font.Color := CorLabel;
end;

procedure TfrmCadEnderecos.edit06Enter(Sender: TObject);
begin
  Edit06.Color := CorEditEnter;
end;

procedure TfrmCadEnderecos.edit08Enter(Sender: TObject);
begin
  Edit08.Color := CorEditEnter;
end;

procedure TfrmCadEnderecos.edit08Exit(Sender: TObject);
begin
  Edit08.Color := CorEditExit;
  lbl08.font.Color := CorLabel;
end;

end.
