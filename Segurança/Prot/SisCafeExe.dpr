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
 //verefica se j� existe uma copia do programa em
 //execu��o, repare que TfrmProtSisH � o nome
 //da classe construrura do form frmProSisH o qual
 //� o form principal da aplica��o, e o mesmo sempre
 //ta em execu��o!!! quanto o programa esta aberto.
 if FindWindow('TfrmProtSisCafe', nil) > 0 then begin
   Application.MessageBox('O SisCafe j� Est� em Execu��o!!!',
  'SisCafe',MB_OK+MB_ICONINFORMATION);
   halt;
 end;

 Application.Initialize;
 Application.Title := 'ProtSisCafe';
  Application.CreateForm(TfrmProtSisCafe, frmProtSisCafe);
  Application.Run;

end.
