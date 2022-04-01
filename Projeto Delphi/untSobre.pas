unit untSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons, StdCtrls, inifiles;

type
  TfrmSobre = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lblVersao: TLabel;
    SpeedButton1: TSpeedButton;
    lblMemoria: TLabel;
    Label3: TLabel;
    lblExpira: TLabel;
    lblMemoLivre: TLabel;
    Image5: TImage;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

uses untPrincipal, untFerramentas;

{$R *.dfm}

procedure TfrmSobre.FormShow(Sender: TObject);
Var
 MS: TMemoryStatus;
 ArqIni : TIniFile;
 EndSistem : Array[0..144] of Char;
 DirSistem:String;
 Data: Tdate;
 DataStr:String;
 dia, mes, ano: Word;
begin
  lblVersao.Caption := 'Versão -  '+GetVersionInfo+'   ';
  GlobalMemoryStatus(MS);
  lblmemoria.Caption := 'Memória Avaliada: '+(FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024));
  lblMemoLivre.Caption := 'Memória Livre: '+(FormatFloat('#,###" KB"', MS.dwAvailPhys / 1024));

 //************************************************************************
  //Data Expirar
 try
  GetSystemDirectory(EndSistem,144);//Dir do Sistema
  DirSistem :=StrPas(@EndSistem);//Dir do Sistema em str
  ArqIni := TIniFile.Create(DirSistem+'\SCWin.ini');
 Try
  If (fileexists(DirSistem+'\SCWin.ini')) then
  begin
    Data := StrToDate(Criptografia(ArqIni.ReadString('P4','D.F','')))- Date;
    DecodeDate( Data, ano, mes, dia);
    lblExpira.Caption :=FloatToStr(Data)+' Dias';
  end;
 Finally
    ArqIni.Free;
    FileSetAttr(DirSistem+'\SCWin.ini',7);
 end;
 except
 end;
 //*******

end;

procedure TfrmSobre.SpeedButton1Click(Sender: TObject);
begin
  close;
end;

end.
