program LicensaUSO;

uses
  Forms,
  ULicenca in 'ULicenca.pas' {Form1},
  UFerramentas in 'UFerramentas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
