unit untLocalizar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, DB, IBCustomDataSet, IBQuery, Buttons,
  StdCtrls, Mask, Grids, DBGrids, ExtCtrls;

type
  TfrmLocalizar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lblLocalizarPor: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    lblQuantPesq: TLabel;
    Grid: TDBGrid;
    EditOpcao: TComboBox;
    EditLocalizar: TMaskEdit;
    BarraFerramentas: TPanel;
    btnLocalizar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    DSLocalizar: TDataSource;
    Qry_Localizar: TIBQuery;
    ActionList1: TActionList;
    Localizar: TAction;
    Cancelar: TAction;
    Sair: TAction;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Localizar1: TMenuItem;
    Cancelar1: TMenuItem;
    Sair1: TMenuItem;
    Sair2: TMenuItem;
    procedure LocalizarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditOpcaoExit(Sender: TObject);
    procedure EditOpcaoChange(Sender: TObject);
    procedure EditLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EditLocalizarExit(Sender: TObject);
    procedure EditLocalizarEnter(Sender: TObject);
    procedure EditOpcaoEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalizar: TfrmLocalizar;
  CampoTabela:String;
  CampoPesquisa : Array[0..4] of String;
  MascaraPesquisa : Array[0..4] of String;
  Campo:String;
  TipoCliente:STring;  

implementation

uses untPrincipal, untDM;

{$R *.dfm}

procedure TfrmLocalizar.LocalizarExecute(Sender: TObject);
begin
  if (EditOpcao.Font.Color = CorLabelError) or
   (EditOpcao.Text = '') then begin
    EditOpcao.SetFocus;
    exit;
  end;
  EditLocalizar.SetFocus;
 //Localiza o registro
 Qry_Localizar.SQL.Clear;

 if EditLocalizar.Text <> '' then begin
    //Pesquisa fonetica para o paciente ****************** 01/01/2005
    //if (campo = 'NOMEsoundex') then
     //Qry_Localizar.SQL.Add(CampoTabela+
     //com soundex
     // ' WHERE '+Campo+' STARTING WITH (SOUNDEX("'+EditLocalizar.Text+'")) ORDER BY '+Campo)
      // ' WHERE '+Campo+' STARTING WITH "'+EditLocalizar.Text+'" ORDER BY '+Campo)
       //fim pesquisa ************************************
   // else  begin
     Qry_Localizar.SQL.Add(CampoTabela+
       ' WHERE '+Campo+' STARTING WITH :NOME ORDER BY '+Campo);
      Qry_Localizar.ParamByName('NOME').AsString := EditLocalizar.Text;
   // end
 end else  begin
     Qry_Localizar.SQL.Add(CampoTabela+' ORDER BY '+Campo);
 end;

  Qry_Localizar.open;
  Qry_Localizar.Last; //Atualiza o recordCount
  Qry_Localizar.Prior; //idem
  lblQuantPesq.Caption := IntToStr(Qry_Localizar.RecordCount);

end;

procedure TfrmLocalizar.CancelarExecute(Sender: TObject);
begin
  ResultadoPesquisa2:='0';
  frmLocalizar.Close;
end;

procedure TfrmLocalizar.SairExecute(Sender: TObject);
begin
  if grid.ValidFieldIndex(Grid.SelectedIndex) then
    ResultadoPesquisa2 := Grid.SelectedField.AsString
  else
    ResultadoPesquisa2:='0';
  frmLocalizar.Close;
end;

procedure TfrmLocalizar.FormShow(Sender: TObject);
begin
  Qry_Localizar.Close;
  EditOpcao.ItemIndex:=0;
end;

procedure TfrmLocalizar.EditOpcaoExit(Sender: TObject);
Var I,J : Integer;
begin
 EditOpcao.Color := CorEditExit;
 Case EditOpcao.ItemIndex  of
   0:Begin
       Campo:=CampoPesquisa[0];
       EditLocalizar.EditMask:=
          MascaraPesquisa[0];
     end;
   1:Begin
       Campo:=CampoPesquisa[1];
       EditLocalizar.EditMask:=
          MascaraPesquisa[1];
     end;
   2:Begin
       Campo:=CampoPesquisa[2];
       EditLocalizar.EditMask:=
          MascaraPesquisa[2];
     end;
   3:Begin
       Campo:=CampoPesquisa[3];
       EditLocalizar.EditMask:=
          MascaraPesquisa[3];
     end;
   4:Begin
       Campo:=CampoPesquisa[4];
       EditLocalizar.EditMask:=
          MascaraPesquisa[4];
     end;
 end;//Case
 J:= EditOpcao.Items.Count;
  For I:=0 to J do
    if EditOpcao.Text = EditOpcao.Items.Strings[I] then
      begin
        EditOpcao.Font.Color := clBlack;
        lblLocalizarPor.Caption := EditOpcao.Text;
        exit;
      end
      else
        begin
          EditOpcao.Font.Color := CorLabelError;
        end;

end;

procedure TfrmLocalizar.EditOpcaoChange(Sender: TObject);
begin
  EditLocalizar.Text:= '';
  EditLocalizar.EditMask:='';
end;

procedure TfrmLocalizar.EditLocalizarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    LocalizarExecute(Sender);
end;

procedure TfrmLocalizar.GridDblClick(Sender: TObject);
begin
  SairExecute(Sender);
end;

procedure TfrmLocalizar.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    SairExecute(Sender);
end;

procedure TfrmLocalizar.EditLocalizarExit(Sender: TObject);
begin
  EditLocalizar.Color := CorEditExit;
end;

procedure TfrmLocalizar.EditLocalizarEnter(Sender: TObject);
begin
  EditLocalizar.Color := CorEditEnter;
end;

procedure TfrmLocalizar.EditOpcaoEnter(Sender: TObject);
begin
  EditOpcao.Color := CorEditEnter;
end;

procedure TfrmLocalizar.FormActivate(Sender: TObject);
begin
 EditLocalizar.SetFocus;
end;

end.
