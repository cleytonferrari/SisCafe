unit untRelCompraDetalhadoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, Buttons;

type
  TfrmRelCompraDetalhadoForm = class(TForm)
    groupOpcao: TRadioGroup;
    gbFiltragem: TGroupBox;
    lblCodFornecedor: TLabel;
    edtCodFornecedor: TEdit;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    edtDataInicial: TMaskEdit;
    edtDataFinal: TMaskEdit;
    lblCodCompra: TLabel;
    edtCodCompra: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbOpcao: TComboBox;
    cbTipo: TComboBox;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCompraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbOpcaoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCompraDetalhadoForm: TfrmRelCompraDetalhadoForm;
  Fechar : Boolean;
implementation

uses untPrincipal;

{$R *.dfm}

procedure TfrmRelCompraDetalhadoForm.edtCodFornecedorKeyPress(
  Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmRelCompraDetalhadoForm.edtCodCompraKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
      key:=#0;
end;

procedure TfrmRelCompraDetalhadoForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose :=Fechar;
end;

procedure TfrmRelCompraDetalhadoForm.BitBtn2Click(Sender: TObject);
begin
  Fechar:= True;
  Rel_Cancelar := True;
  Close;
end;

procedure TfrmRelCompraDetalhadoForm.FormCreate(Sender: TObject);
begin
  gbFiltragem.Visible := False;
end;

procedure TfrmRelCompraDetalhadoForm.cbOpcaoChange(Sender: TObject);
begin
  case cbOpcao.ItemIndex  of
  0: begin
      //Por codigo de fornecedor
      edtCodFornecedor.Visible := true;
      lblCodFornecedor.Visible := true;
      edtDataInicial.Visible := False;
      edtDataFinal.Visible := False;
      lblDataInicial.Visible := False;
      lblDataFinal.Visible := False;
      edtCodCompra.Visible := False;
      lblCodCompra.Visible := False;
      gbFiltragem.Visible := true;
     end;
  1: begin
      //Por Data de Compra
      edtCodFornecedor.Visible := false;
      lblCodFornecedor.Visible := false;
      edtDataInicial.Visible := true;
      edtDataFinal.Visible := true;
      lblDataInicial.Visible := true;
      lblDataFinal.Visible := true;
      edtCodCompra.Visible := False;
      lblCodCompra.Visible := False;
      gbFiltragem.Visible := true;
     end;
  2: begin
      //Por codigo Compra
      edtCodFornecedor.Visible := false;
      lblCodFornecedor.Visible := false;
      edtDataInicial.Visible := False;
      edtDataFinal.Visible := False;
      lblDataInicial.Visible := False;
      lblDataFinal.Visible := False;
      edtCodCompra.Visible := true;
      lblCodCompra.Visible := true;
      gbFiltragem.Visible := true;
     end;
  3: begin
      //completo
      gbFiltragem.Visible := false;
     end;
  end;

end;

procedure TfrmRelCompraDetalhadoForm.BitBtn1Click(Sender: TObject);
begin
//  Rel_Cancelar:Boolean=False;
//  Rel_Completo:Boolean=False;
//  Rel_DI, Rel_DF, Rel_CodFornecedor, Rel_CodCompra : String;
  case cbOpcao.ItemIndex  of
  0: begin
      //Por codigo de fornecedor
      if edtCodFornecedor.text <> '' then begin
        Rel_CodFornecedor := edtCodFornecedor.Text;
        Rel_Completo := False;
        Rel_Cancelar := False;
      end else begin
        Application.MessageBox(
        'Informe um c?digo de Fornecedor!',
        'Aviso'  ,MB_OK+mb_iconerror);
        exit;
        end;
     end;
  1: begin
      //Por Data de Compra
      try
        StrToDate(edtDataInicial.Text);
        StrToDate(edtDataFinal.Text);
      except
        Application.MessageBox(
        'Informe uma data Valida!',
        'Aviso'  ,MB_OK+mb_iconerror );
        exit;
      end;
      Rel_DI := edtDataInicial.Text;
      Rel_DF := edtDataFinal.Text;
      Rel_Completo := False;
      Rel_Cancelar := False;
     end;
  2: begin
      //Por codigo Compra
      if (edtCodCompra.Text <> '') then begin
      Rel_CodCompra := edtCodCompra.Text;
      Rel_Completo:=False;
      Rel_Cancelar:=False;
      end else begin
        Application.MessageBox(
        'Informe o codigo da Compra!',
        'Aviso'  ,MB_OK+mb_iconerror );
        exit;
        end;
    end;
  3: begin
      //completo
      Rel_Completo := True;
     end;
  end;
  Rel_opcao := cbOpcao.ItemIndex;
  Rel_Tipo :=  cbTipo.ItemIndex;
  Fechar := True;
  close;
end;

end.
