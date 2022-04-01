{====================================================
#####################################################
#     Sistema de Controle de Cafeeria Versão 1      #
#                      SisCafe                      #
#                                                   #
#                                                   #
# Programa desenvolvido com o intuito de auxiliar o #
# Cadastramento dos Cafeeicultores Atendidos pela   #
# cafeeira contratante, mantendo um controle total  #
# de seus estoques de cafe.                         #
# Inicio do Desenvolvimento  Agosto/2006            #
# Academico: Alencar                                #
# Orientador: Cleyton Ferrari                       #
# Retomada do projeto em: Abril/2007                #
# Empresa: AL Informática                           #
#####################################################
====================================================}
program prjSisCafe;

uses
  Forms,
  Windows,
  Dialogs,
  Messages,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untCadBairros in 'untCadBairros.pas' {frmCadBairros},
  untFerramentas in 'untFerramentas.pas',
  untControlaTabela in 'untControlaTabela.pas',
  untLocalizar in 'untLocalizar.pas' {frmLocalizar},
  untCadEnderecos in 'untCadEnderecos.pas' {frmCadEnderecos},
  UntCadFornecedor in 'UntCadFornecedor.pas' {frmCadFornecedor},
  untSacaria in 'untSacaria.pas' {frmSacaria},
  untEmprestimo in 'untEmprestimo.pas' {frmEmprestimo},
  untSplash in 'untSplash.pas' {frmSplash},
  untLoggin in 'untLoggin.pas' {frmLoggin},
  untSobre in 'untSobre.pas' {frmSobre},
  untCadCliente in 'untCadCliente.pas' {frmCadCliente},
  untCadProduto in 'untCadProduto.pas' {frmCadProduto},
  untCompra in 'untCompra.pas' {frmCompra},
  untVenda in 'untVenda.pas' {frmVenda},
  untRelEnderecos in 'untRelEnderecos.pas' {frmRelEnderecos},
  untRelFornecedor in 'untRelFornecedor.pas' {frmRelFornecedor},
  untRelCliente in 'untRelCliente.pas' {frmRelCliente},
  untRelProduto in 'untRelProduto.pas' {frmRelProduto},
  untRelEmprestimo in 'untRelEmprestimo.pas' {frmRelEmprestimo},
  untRelSacaria in 'untRelSacaria.pas' {frmRelSacaria},
  untRelCompraDetalhado in 'untRelCompraDetalhado.pas' {frmRelCompraDetalhado},
  untRelCompraDetalhadoForm in 'untRelCompraDetalhadoForm.pas' {frmRelCompraDetalhadoForm},
  untRelVendaDetalhada in 'untRelVendaDetalhada.pas' {frmRelVendaDetalhada},
  untRelVendaDetalhadaForm in 'untRelVendaDetalhadaForm.pas' {frmRelVendaDetalhadaForm};

{$R *.res}
Var
I,J:Integer;
A:Real;

begin
  { É utilizado para validar o programa SisCafeExe
  com a utilização do Prot, para programas
  alugados, conta X dias para bloquear o SisCafe }
  if ParamStr(1) <> '250498' then begin
   Application.MessageBox('Erro ao abrir o SisCafe, Execute o SisCafeExe!',
  'SisCafe',MB_OK+mb_iconerror );
   Halt;
  end;
  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Refresh;
  frmSplash.lblMsg.Caption := 'Carregando Aplicativo...';
  frmSplash.Refresh;
  Application.ProcessMessages;
  //#######################################
  //Este procedimento é utilizado para que
  //a tela de Splash seja exibida por mais
  //tempo, este mesmo procedimento se repete
  //por mais algumas vezes no codigo a baixo
  for J:=1 to 2 do
  for I:=1 to 9900000 do begin
    A:=I*(Sqrt(I));
    A:= sqrt(I)*A;
  end;
  //#######################################

  Application.Initialize;
  Application.Title := 'SisCafe';
  //
  frmSplash.lblMsg.Caption := 'Conectando ao Banco de Dados...';
  frmSplash.Refresh;
  Application.ProcessMessages;
  for J:=1 to 3 do
  for I:=1 to 9900000 do begin
    A:=I*(Sqrt(I));
    A:= sqrt(I)*A;
  end;
  Application.CreateForm(TDM, DM);
  frmLoggin := TfrmLoggin.Create(Application);
  frmLoggin.Refresh;

  frmSplash.lblMsg.Caption := 'Iniciando Loggin...';
  frmSplash.Refresh;
  Application.ProcessMessages;

  for J:=1 to 2 do
  for I:=1 to 9900000 do begin
    A:=I*(Sqrt(I));
    A:= sqrt(I)*A;
  end;

  frmLoggin.ShowModal;

  if Entra = True then begin
  frmLoggin.Release;
  frmLoggin := nil;
  frmLoggin.Free;

  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  frmPrincipal.BarraStatus.Panels[2].Text := 'Usuário: ' +Usuario;
  Application.Run;
  end else begin
    Application.Terminate;
  end;

  Application.Run;
end.
