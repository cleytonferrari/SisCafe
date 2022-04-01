{
 Sistema de controle de segurança

 Funciona por periodo de dias, executa junto com o programa principal
 e aguarda a sua finalizaçao para fechar.
}

unit UProt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
   Forms, Dialogs ,ShellAPI, Menus, ExtCtrls, Registry,iniFiles;

const
  wm_IconMessage = wm_User;
  //Constante

type
  TfrmProtSisCafe = class(TForm)
    Relogio01: TTimer;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Relogio01Timer(Sender: TObject);
    procedure Executa (Arquivo : String; Estado : Integer);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  IconeBarra: TNotifyIconData;

  end;

var
  frmProtSisCafe: TfrmProtSisCafe;
  reg:TRegIniFile;
  EndSistem : Array[0..144] of Char;
  DirSistem:String;
implementation

uses ULogo, UFerramentas;

{$R *.dfm}

{ TForm1 }


procedure TfrmProtSisCafe.Executa(Arquivo: String; Estado: Integer);
var
  Programa : array [0..512] of char;
  CurDir : array [0..255] of char;
  WorkDir : String;
  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
begin
    StrPCopy (Programa, Arquivo);
    GetDir (0, WorkDir);
    StrPCopy (CurDir, WorkDir);
    FillChar (StartupInfo, Sizeof (StartupInfo), #0);
    StartupInfo.cb := sizeof (StartupInfo);
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := Estado;
    if not CreateProcess (nil, Programa, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
      //Result := -1
    else
    begin
     WaitForSingleObject (ProcessInfo.hProcess, Infinite);
     //GetExitCodeProcess(ProcessInfo.hProcess, Result);
    end;
end;

procedure TfrmProtSisCafe.FormCreate(Sender: TObject);
var
ArqIni : TIniFile;

begin
  // carrega o ícone inicial
  Icon.Handle := LoadIcon (HInstance, 'MAINICON');
  // preenche os dados da estrutura NotifyIcon
  IconeBarra.cbSize := sizeof (IconeBarra);
  IconeBarra.wnd := Handle;
  IconeBarra.uID := 1; // Identificador do ícone
  IconeBarra.uCallBAckMessage := wm_IconMessage;
  IconeBarra.hIcon := Icon.Handle;
  IconeBarra.szTip := 'ProtSisCafe'; //Hint do icone
  IconeBarra.uFlags := nif_Message or
  nif_Icon or nif_Tip;
  Shell_NotifyIcon (NIM_ADD, @IconeBarra);
try
  //cria SCWin.ini **************************
  //Na Primeira Execução se nao existir o SCWin.ini ele entao é criado
  GetSystemDirectory(EndSistem,144);//Dir do Sistema
  DirSistem :=StrPas(@EndSistem);//Dir do Sistema em str
  ArqIni := TIniFile.Create(DirSistem+'\SCWin.ini');

  Try
  If Not (fileexists(DirSistem+'\SCWin.ini')) then
  begin
    ArqIni.WriteString('P4','D.I','');
    ArqIni.WriteString('P4','D.F','');
    ArqIni.WriteString('P4','C','');
    ArqIni.WriteString('P4','C2','');
  end;
Finally
  ArqIni.Free;
  FileSetAttr(DirSistem+'\SCWin.ini',7);
  //************************************
end;
except
end;
end;

procedure TfrmProtSisCafe.FormDestroy(Sender: TObject);
begin
  IconeBarra.uFlags := 0;
  Shell_NotifyIcon (NIM_DELETE, @IconeBarra);
end;

procedure TfrmProtSisCafe.FormShow(Sender: TObject);
var
H : HWnd;
begin
 H := FindWindow(Nil,'ProtSisCafe');
 if H <> 0 then
   ShowWindow(H,SW_HIDE);
 //O relogio a baixo marca o tempo para ficar verificando se a
 // data do sistema foi alterada.
    Relogio01.Interval := 1000;
 //*************************

//cria a tela de logo
 frmLogo := TfrmLogo.Create(Application);
 try
  frmLogo.ShowModal;
finally
  frmLogo.Release;
  frmlogo := nil;
end;
  frmLogo.Free;
end;

procedure TfrmProtSisCafe.Relogio01Timer(Sender: TObject);
var
 ArqIni : TIniFile;
 VDataAgora,VDataInicio,VDataFim:TDateTime;
 VContador,VContador2:TDateTime;
begin
try
 //O relogio a baixo marca o tempo para ficar verificando se a
 // data do sistema foi alterada.
    Relogio01.Interval := 1000;
 //*************************

  FileSetAttr(DirSistem+'\SCWin.ini',0);
  //**************************************

  ArqIni := TIniFile.Create(DirSistem+'\SCWin.ini');
  Try
  if (Criptografia(ArqIni.ReadString('P4','D.F','')) = '') or
     (Criptografia(ArqIni.ReadString('P4','D.I','')) = '') then
  begin
   ArqIni.WriteString('P4','D.I',Criptografia(DateToStr(Date)) );

   //#################################################################
   //MARQUE AQUI A QUANTIDADE DE DIAS PARA VALIDAR O SISTEMA
     ArqIni.WriteString('P4','D.F',Criptografia(DateToStr(Date+30)));
   //#################################################################

   ArqIni.WriteString('P4','C',Criptografia(DateToStr(Date)));
   ArqIni.WriteString('P4','C2',Criptografia(DateToStr(Date)));
  end;

  VDataInicio := strToDate(Criptografia((ArqIni.ReadString('P4','D.I',''))));
  VDataFim := strToDate(Criptografia((ArqIni.ReadString('P4','D.F',''))));
  VDataAgora:= Date;
  VContador:= VDataInicio;
  VContador2:= strToDate(Criptografia((ArqIni.ReadString('P4','C2',''))));

  If (VDataAgora <> VContador2) Then
  begin
    ArqIni.WriteString('P4','C',Criptografia(DateToStr(VContador2 + 1)));
    ArqIni.WriteString('P4','C2',Criptografia(DateToStr(Date)));
  end;
If (VDataAgora >= VDataInicio) And (VDataAgora < VDataFim)
  And (VDataAgora >= strToDate(Criptografia(ArqIni.ReadString('P4','C','')))) And
  (VContador2 <= VDataAgora) Then begin

   //Marca no Registro(P3Win.ini) se o programa pode ser Executado!!!
   ArqIni.WriteString('P5','A','1AB212');//Programa é Executado!!!
  end else
   ArqIni.WriteString('P5','A','2B3AC4');//Programa Não é Executado!!!


Finally
  ArqIni.Free;
  FileSetAttr(DirSistem+'\SCWin.ini',7);
  //**************************************
end;
except
end;
end;
procedure TfrmProtSisCafe.Timer1Timer(Sender: TObject);
Var
  ArqIni : TIniFile;
begin
  timer1.Interval := 0;
  //##########################################################
  //verifica se pode executar o Programa Passado pela
  //Procedure Executa(??????);

  GetSystemDirectory(EndSistem,144);//Dir do Sistema
  DirSistem :=StrPas(@EndSistem);//Dir do Sistema em str
  ArqIni := TIniFile.Create(DirSistem+'\SCWin.ini');

  if ArqIni.ReadString('P5','A','') = '1AB212' then begin
  Executa('SisCafe.exe 250498',1);
  end else begin
    ArqIni.Free;
    Application.MessageBox(
      'A Licença Venceu contacte o Suporte Tecnico.',
      'SisCafe',MB_OK+mb_iconinformation );
  end;
  //#########################################################
  close;
end;

end.
