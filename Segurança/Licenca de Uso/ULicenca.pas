unit ULicenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask,Registry,iniFiles, ExtCtrls;

type
  TForm1 = class(TForm)
    EditData: TMaskEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    procedure Executa(Arquivo: String; Estado: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function PasswordInputBox(const ACaption, APrompt: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  reg:TRegIniFile;
  EndSistem : Array[0..144] of Char;
  DirSistem:String;

implementation

uses UFerramentas;

{$R *.dfm}

{ TForm1 }

procedure TForm1.Executa(Arquivo: String; Estado: Integer);
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

procedure TForm1.FormCreate(Sender: TObject);
var
ArqIni : TIniFile;
begin
try
  //cria SCWin.ini **************************
  //Na Primeira Execu??o se nao existir o SCWin.ini ele entao ? criado
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

procedure TForm1.Button1Click(Sender: TObject);
var
 ArqIni : TIniFile;
 VDataAgora,VDataInicio,VDataFim:TDateTime;
 VContador,VContador2:TDateTime;
begin
if PasswordInputBox('Senha','Digite a senha:') = 'siscafe' then begin
try
  StrToDate(EditData.EditText);
except
  ShowMessage('Data Inv?lida!!!');
  Exit;
end;

try
  FileSetAttr(DirSistem+'\SCWin.ini',0);
//  showmessage(DirSistem+'\SCWin.ini');
  //**************************************
  ArqIni := TIniFile.Create(DirSistem+'\SCWin.ini');
  Try

   ArqIni.WriteString('P4','D.I',Criptografia(DateToStr(Date)) );

   ArqIni.WriteString('P4','D.F',Criptografia(DateToStr(StrToDate(EditData.EditText ))));

   ArqIni.WriteString('P4','C',Criptografia(DateToStr(Date)));
   ArqIni.WriteString('P4','C2',Criptografia(DateToStr(Date)));

   //Marca no Registro(PEscWin.ini) se o programa pode ser Executado!!!
   ArqIni.WriteString('P5','A','1AB212');//Programa ? Executado!!!

Finally
  ArqIni.Free;
  FileSetAttr(DirSistem+'\SCWin.ini',7);
  //**************************************
  ShowMessage('Licen?a Gravada com Sucesso!!!');
end;
except
end;
end else
 ShowMessage('A Senha informada n?o ? Valida!!!');

end;

function TForm1.PasswordInputBox(const ACaption, APrompt: string): string;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  Value: string;
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  Result := '';
  Form := TForm.Create(Application);
  with Form do
  try
    Canvas.Font := Font;
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(DialogUnits));
    DialogUnits.X := DialogUnits.X div 52;
    BorderStyle := bsDialog;
    Caption := ACaption;
    ClientWidth := MulDiv(180, DialogUnits.X, 4);
    ClientHeight := MulDiv(63, DialogUnits.Y, 8);
    Position := poScreenCenter;
    Prompt := TLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      AutoSize := True;
      Left := MulDiv(8, DialogUnits.X, 4);
      Top := MulDiv(8, DialogUnits.Y, 8);
      Caption := APrompt;
    end;
    Edit := TEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := MulDiv(19, DialogUnits.Y, 8);
      Width := MulDiv(164, DialogUnits.X, 4);
      MaxLength := 255;
      PasswordChar := '*';
      SelectAll;
    end;
    ButtonTop := MulDiv(41, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(50, DialogUnits.X, 4);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'OK';
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(38, DialogUnits.X, 4),ButtonTop, ButtonWidth,ButtonHeight);
    end;
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'Cancelar';
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(92, DialogUnits.X, 4),ButtonTop, ButtonWidth,ButtonHeight);
    end;
    if ShowModal = mrOk then
    begin
      Value := Edit.Text;
      Result := Value;
    end;
  finally
    Form.Free;
    Form:=nil;
  end;

end;

end.
