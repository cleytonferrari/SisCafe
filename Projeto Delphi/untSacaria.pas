unit untSacaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ActnList, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls;

type
  TfrmSacaria = class(TForm)
    Panel1: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    btnNovo: TSpeedButton;
    DisabilitaCampo: TPanel;
    ActCadBairros: TActionList;
    Salvar: TAction;
    Cancelar: TAction;
    Sair: TAction;
    Novo: TAction;
    Menu: TMainMenu;
    Arquivo1: TMenuItem;
    Novo1: TMenuItem;
    Salvar1: TMenuItem;
    cancelar1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    lbl01: TLabel;
    edit01: TDBEdit;
    DataSource1: TDataSource;
    lbl03: TLabel;
    edit03: TDBEdit;
    lbl02: TLabel;
    edit02: TDBEdit;
    lbl07: TLabel;
    edit07: TDBEdit;
    lbl06: TLabel;
    edit06: TDBComboBox;
    btnLocFornecedor: TBitBtn;
    lbl04: TLabel;
    edit04: TDBEdit;
    DSFornecedor: TDataSource;
    lbl05: TLabel;
    edit05: TDBEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure edit03Change(Sender: TObject);
    procedure edit03KeyPress(Sender: TObject; var Key: Char);
    procedure edit03KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocFornecedorClick(Sender: TObject);
    procedure edit02Enter(Sender: TObject);
    procedure edit02Exit(Sender: TObject);
    procedure edit03Exit(Sender: TObject);
    procedure edit03Enter(Sender: TObject);
    procedure edit06Exit(Sender: TObject);
    procedure edit06Enter(Sender: TObject);
    procedure edit07Enter(Sender: TObject);
    procedure edit07Exit(Sender: TObject);
    procedure edit07KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSacaria: TfrmSacaria;
  Fechar : boolean;

implementation

uses untDM, untPrincipal, untControlaTabela, untLocalizar;

{$R *.dfm}

procedure TfrmSacaria.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose :=Fechar;
end;

procedure TfrmSacaria.FormCreate(Sender: TObject);
begin
  DisabilitaCampo.Enabled := False;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Sair.Enabled := True;
  lbl02.Font.Color := CorLabel;
  lbl03.Font.Color := CorLabel;
  lbl06.Font.Color := CorLabel;
  lbl07.Font.Color := CorLabel;
  Edit01.Color := CorEditDisable;
  Edit02.Color := CorEditExit;
  Edit03.Color := CorEditExit;
  Edit04.Color := CorEditDisable;
  Edit05.Color := CorEditDisable;
  Edit06.Color := CorEditExit;
  Edit07.Color := CorEditExit;
end;

procedure TfrmSacaria.SalvarExecute(Sender: TObject);
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
   if edit03.Text = '' then begin
     edit03.SetFocus;
     lbl03.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit04.Text = 'N?O LOCALIZADO!')or (edit04.Text = '') then begin
     edit03.SetFocus;
     lbl03.Font.Color := CorLabelError;
     exit;
   end;
   if (Edit06.Text = '') then begin
     edit06.SetFocus;
     lbl06.Font.Color := CorLabelError;
     exit;
   end;
   if (edit07.Text = '') or (strToInt(edit07.Text)<=0) then begin
     edit07.SetFocus;
     lbl07.Font.Color := CorLabelError;
     exit;
   end;
  //*************************
  SalvarRegistro(DM.tblHistoricoSacaria);
  DM.QryCommit.ExecSQL;  //Executa o Commit no Banco de Dados;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Sair.Enabled := True;
  DisabilitaCampo.Enabled := False;
  DM.tblFornecedor_Sacaria.Close;
end;

procedure TfrmSacaria.CancelarExecute(Sender: TObject);
begin
  FocusControl(nil);
  DisabilitaCampo.Enabled := False;
  CancelarRegistro(DM.tblHistoricoSacaria);
  DM.QryRollback.ExecSQL;
  Novo.Enabled := True;
  Salvar.Enabled := False;
  Cancelar.Enabled := False;
  Sair.Enabled := True;
end;

procedure TfrmSacaria.SairExecute(Sender: TObject);
begin
 Fechar:= True;
  if(DM.tblFornecedor_Sacaria.Active=True)then
   DM.tblFornecedor_Sacaria.Close;
 close;
end;

procedure TfrmSacaria.NovoExecute(Sender: TObject);
begin
  DisabilitaCampo.Enabled := True;
  NovoRegistro(DM.tblHistoricoSacaria);
  Novo.Enabled := False;
  Salvar.Enabled := True;
  Cancelar.Enabled := True;
  Sair.Enabled := False;
  Edit03.SetFocus;
  //Preenche a data atual
  DM.tblHistoricoSacariaDATA.AsDateTime := Now();  
end;

procedure TfrmSacaria.edit03Change(Sender: TObject);
var Existe : Boolean;
begin
try
  Existe := False;
  //LOCATE
   DM.tblFornecedor_Sacaria.Open;

   Existe := DM.tblFornecedor_Sacaria.Locate
         ('FORNECEDOR_ID',strtoint(edit03.Text ),[]);
  if Existe = True then  Begin
     edit04.Text := DM.tblFornecedor_SacariaNOME_RAZAOSOCIAL.AsString;
   end else begin
     edit04.Text := 'N?o Localizado!';
   end;
   except
    edit04.Text := '';
    DM.tblFornecedor_Sacaria.Close;
   end;
end;

procedure TfrmSacaria.edit03KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;

end;

procedure TfrmSacaria.edit03KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //procedimento para mostrar o nome
  Edit04.SetFocus;
  Edit03.SetFocus;
end;

procedure TfrmSacaria.btnLocFornecedorClick(Sender: TObject);
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
    EditOpcao.Items.Add('C?DIGO');
    EditOpcao.Items.Add('NOME/RAZ?O SOCIAL');

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
    DM.tblHistoricoSacariaFORNECEDOR_ID.AsString := ResultadoPesquisa2;
  end
  else
    CancelarExecute(Sender);
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmLocalizar.Free;
end;

procedure TfrmSacaria.edit02Enter(Sender: TObject);
begin
  Edit02.Color := CorEditEnter;
end;

procedure TfrmSacaria.edit02Exit(Sender: TObject);
begin
  Edit02.Color := CorEditExit;
  lbl02.font.Color := CorLabel;
end;

procedure TfrmSacaria.edit03Exit(Sender: TObject);
begin
  Edit03.Color := CorEditExit;
  lbl03.font.Color := CorLabel;
end;

procedure TfrmSacaria.edit03Enter(Sender: TObject);
begin
  Edit03.Color := CorEditEnter;
end;

procedure TfrmSacaria.edit06Exit(Sender: TObject);
begin
  Edit06.Color := CorEditExit;
  lbl06.font.Color := CorLabel;
end;

procedure TfrmSacaria.edit06Enter(Sender: TObject);
begin
  Edit06.Color := CorEditEnter;
end;

procedure TfrmSacaria.edit07Enter(Sender: TObject);
begin
  Edit07.Color := CorEditEnter;
end;

procedure TfrmSacaria.edit07Exit(Sender: TObject);
begin
  Edit07.Color := CorEditExit;
  lbl07.font.Color := CorLabel;
end;

procedure TfrmSacaria.edit07KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

end.
