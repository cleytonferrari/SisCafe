program SisCafeExe;

uses
  Forms,
  Windows,
  Dialogs,
  UProt in 'UProt.pas' {frmProtSisCafe},
  ULogo in 'ULogo.pas' {frmLogo},
  UFerramentas in 'UFerramentas.pas';

{$R *.res}

begin
 //verefica se já existe uma copia do programa em
 //execução, repare que TfrmProtSisH é o nome
 //da classe construrura do form frmProSisH o qual
 //é o form principal da aplicação, e o mesmo sempre
 //ta em execução!!! quanto o programa esta aberto.
 if FindWindow('TfrmProtSisCafe', nil) > 0 then begin
   Application.MessageBox('O SisCafe já Está em Execução!!!',
  'SisCafe',MB_OK+MB_ICONINFORMATION);
   halt;
 end;

 Application.Initialize;
 Application.Title := 'ProtSisCafe';
  Application.CreateForm(TfrmProtSisCafe, frmProtSisCafe);
  Application.Run;

end.
