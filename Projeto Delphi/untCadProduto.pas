unit untCadProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Buttons, ExtCtrls, DB, StdCtrls, Mask, DBCtrls;

type
  TfrmCadProduto = class(TForm)
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
    DataSource1: TDataSource;
    lbl02: TLabel;
    edit02: TDBEdit;
    lbl06: TLabel;
    edit06: TDBEdit;
    lbl07: TLabel;
    edit07: TDBEdit;
    lbl04: TLabel;
    edit04: TDBEdit;
    lbl05: TLabel;
    edit05: TDBEdit;
    lbl03: TLabel;
    edit03: TDBEdit;
    lbl08: TLabel;
    edit08: TDBEdit;
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure LocalizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edit02Enter(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit04Enter(Sender: TObject);
    procedure edit05Enter(Sender: TObject);
    procedure edit06Enter(Sender: TObject);
    procedure edit07Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit04Exit(Sender: TObject);
    procedure edit05Exit(Sender: TObject);
    procedure edit06Exit(Sender: TObject);
    procedure edit07Exit(Sender: TObject);
    procedure edit04KeyPress(Sender: TObject; var Key: Char);
    procedure edit05KeyPress(Sender: TObject; var Key: Char);
    procedure edit06KeyPress(Sender: TObject; var Key: Char);
    procedure edit07KeyPress(Sender: TObject; var Key: Char);
    procedure edit06Change(Sender: TObject);
    procedure edit07Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;
  Fechar:Boolean;
implementation

uses untDM, untLocalizar, untPrincipal, untControlaTabela;

{$R *.dfm}

procedure TfrmCadProduto.SalvarExecute(Sender: TObject);
begin
  FocusControl(nil);
  if Edit02.Text = '' then begin
    Edit02.SetFocus;
    lbl02.Font.Color := CorLabelError;
    exit;
  end;
  if Edit03.Text = '' then begin
    Edit03.SetFocus;
    lbl03.Font.Color := CorLabelError;
    exit;
  end;
  if Edit04.Text = '' then begin
    Edit04.SetFocus;
    lbl04.Font.Color := CorLabelError;
    exit;
  end;
  if Edit05.Text = '' then begin
    Edit05.SetFocus;
    lbl05.Font.Color := CorLabelError;
    exit;
  end;
  if Edit06.Text = '' then begin
    Edit06.SetFocus;
    lbl06.Font.Color := CorLabelError;
    exit;
  end;
  if Edit07.Text = '' then begin
    Edit07.SetFocus;
    lbl07.Font.Color := CorLabelError;
    exit;
  end;
  //*************************
  SalvarRegistro(DM.tblCadProduto);
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;

  edit08.Clear;
end;

procedure TfrmCadProduto.CancelarExecute(Sender: TObject);
begin
  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.tblCadProduto);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  
  edit08.Clear;
end;

procedure TfrmCadProduto.EditarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  EditarRegistro(DM.tblCadProduto);
end;

procedure TfrmCadProduto.SairExecute(Sender: TObject);
begin
 Fechar:= True;
 close;
end;

procedure TfrmCadProduto.NovoExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  NovoRegistro(DM.tblCadProduto);
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := False;
  Sair.Enabled := False;
  Edit02.SetFocus;
  //Preenche valores
  DM.tblCadProdutoESTFORNECEDOR.AsString := '0';
  DM.tblCadProdutoESTEMPRESA.AsString := '0';
  DM.tblCadProdutoVALORCOMPRA.AsString := '0';
  DM.tblCadProdutoVALORVENDA.AsString := '0';
  DM.tblCadProdutoUND.AsString := 'KG';
end;

procedure TfrmCadProduto.ApagarExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;
  ExcluirRegistro(DM.tblCadProduto);
  DM.QryCommit.ExecSQL;
end;

procedure TfrmCadProduto.LocalizarExecute(Sender: TObject);
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
    CampoTabela:='SELECT * FROM PRODUTO';
    Grid.Columns.Clear;//Limpa
    Grid.Columns.Add;//Adciona um coluna na grid
    grid.Columns.Items[0].FieldName:='PRODUTO_ID';
    grid.Columns.Items[0].Title.Caption:= 'Código';
    Grid.Columns.Add;
    grid.Columns.Items[1].FieldName:='DESCRICAO';
    grid.Columns.Items[1].Title.Caption:= 'Descrição';
    grid.Columns.Items[1].Width := 185;

    //Adciona a opçoes de pesquisa
    EditOpcao.Items.Clear;
    EditOpcao.Items.Add('CÓDIGO');
    EditOpcao.Items.Add('DESCRIÇÃO');

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
    DM.tblCadProduto.Open;
    DM.tblCadProduto.Locate
        ('PRODUTO_ID',ResultadoPesquisa2,[]);
    ResultadoPesquisa2:='0';
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execução e depois Libera a Memória
  frmLocalizar.Free;
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Editar.Enabled := False;
  Apagar.Enabled := False;
  Localizar.Enabled := True;
  Sair.Enabled := True;

  lbl01.font.Color := CorLabel;
  lbl02.font.Color := CorLabel;
  lbl03.font.Color := CorLabel;
  lbl04.font.Color := CorLabel;
  lbl05.font.Color := CorLabel;
  lbl06.font.Color := CorLabel;
  lbl07.font.Color := CorLabel;
  lbl08.font.Color := CorLabel;

  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditExit;
  Edit05.Color := CorEditExit;
  Edit06.Color := CorEditExit;
  Edit07.Color := CorEditExit;
  Edit08.Color := CorEditDisable;
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  Fechar:=False;
end;

procedure TfrmCadProduto.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose :=Fechar;
end;

procedure TfrmCadProduto.edit02Enter(Sender: TObject);
begin
 Edit02.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit03Enter(Sender: TObject);
begin
 Edit03.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit04Enter(Sender: TObject);
begin
 Edit04.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit05Enter(Sender: TObject);
begin
 Edit05.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit06Enter(Sender: TObject);
begin
 Edit06.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit07Enter(Sender: TObject);
begin
 Edit07.Color := CorEditEnter;
end;

procedure TfrmCadProduto.edit02Exit(Sender: TObject);
begin
  lbl02.Font.Color := CorLabel;
  Edit02.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit03Exit(Sender: TObject);
begin
  lbl03.Font.Color := CorLabel;
  Edit03.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit04Exit(Sender: TObject);
begin
  lbl04.Font.Color := CorLabel;
  Edit04.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit05Exit(Sender: TObject);
begin
  lbl05.Font.Color := CorLabel;
  Edit05.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit06Exit(Sender: TObject);
begin
  lbl06.Font.Color := CorLabel;
  Edit06.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit07Exit(Sender: TObject);
begin
  lbl07.Font.Color := CorLabel;
  Edit07.Color := CorEditExit;
end;

procedure TfrmCadProduto.edit04KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',',',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadProduto.edit05KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',',',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadProduto.edit06KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',',',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadProduto.edit07KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',',',#8,#13]) then
      key:=#0;
end;

procedure TfrmCadProduto.edit06Change(Sender: TObject);
begin
  if (edit06.Text <> '') and (edit07.Text<> '') then
    edit08.Text := FloatToStr(StrToFloat(edit06.Text) + StrTofloat(edit07.Text));
end;

procedure TfrmCadProduto.edit07Change(Sender: TObject);
begin
  if (edit06.Text <> '') and (edit07.Text<> '') then
    edit08.Text := FloatToStr(StrToFloat(edit06.Text) + StrTofloat(edit07.Text));
end;

end.
