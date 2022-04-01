unit untLoggin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  TfrmLoggin = class(TForm)
    editUsuario: TEdit;
    editSenha: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    btnconfirma: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure editSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure editUsuarioEnter(Sender: TObject);
    procedure editSenhaEnter(Sender: TObject);
    procedure editSenhaExit(Sender: TObject);
    procedure editUsuarioExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoggin: TfrmLoggin;
  Cont:Integer;
  Entra:Boolean;
  Usuario:STring;
  Fechar:Boolean;  

implementation

uses untSplash, untDM, untPrincipal;

{$R *.dfm}

procedure TfrmLoggin.FormCreate(Sender: TObject);
begin
  //brush.Style := bsClear;
  frmSplash.Visible := false;
  sleep(100);
  cont:=1;
  Fechar:= False;//Desabilita o alt + F4
end;

procedure TfrmLoggin.btnConfirmaClick(Sender: TObject);
begin
DM.tblUsuarios.Open;
if  DM.tblUsuarios.Locate
     ('NOME',EditUsuario.Text,[]) then
   begin
     if DM.tblUsuariosSENHA.AsString =
        EditSenha.Text then
         begin
            Fechar:=True;
            FrmLoggin.Close;
            Entra := True;
            Usuario:=EditUsuario.Text;
         end
         else
          begin
            Application.MessageBox
           ('Usuário/Senha Inválidos','Sistema',Mb_Ok+mb_IconError);
           exit;
          end;
   end
   else
    begin
      Application.MessageBox
           ('Usuário/Senha Inválidos','Sistema',Mb_Ok+mb_IconError);
      Exit;
    end;
   DM.tblUsuarios.Close;
end;

procedure TfrmLoggin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= Fechar;
end;

procedure TfrmLoggin.FormShow(Sender: TObject);
begin
  frmSplash.Visible := False;
  frmSplash.Release;
  frmSplash:= nil;
end;

procedure TfrmLoggin.btnCancelarClick(Sender: TObject);
begin
   Fechar:=True;
   Entra := False;
   DM.BaseDados.Connected := false;
   DM := nil;
   DM.Free;
   Application.Terminate;
end;

procedure TfrmLoggin.editSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnConfirmaClick(Sender);
end;

procedure TfrmLoggin.editUsuarioEnter(Sender: TObject);
begin
  editUsuario.Color := clMoneyGreen;
end;

procedure TfrmLoggin.editSenhaEnter(Sender: TObject);
begin
  editSenha.Color := clMoneyGreen;
end;

procedure TfrmLoggin.editSenhaExit(Sender: TObject);
begin
 editSenha.Color:= clWindow;
end;

procedure TfrmLoggin.editUsuarioExit(Sender: TObject);
begin
 editUsuario.Color:= clWindow;
end;

end.
