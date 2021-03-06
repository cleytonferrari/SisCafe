unit untFerramentas;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, IniFiles,Mask, Registry,DBCtrls, ExtCtrls, Buttons;

function VerificaCPF(num: string): boolean;
function VerificaData(Data : String):boolean;
procedure GetBuildInfo(var v1, v2, v3, v4:word);
function GetVersionInfo: String;
function IdadeAtual(Nasc : TDate): Integer;
function RemoveEspaco(StrE:String):String;
function Criptografia(mStr: string): string;
function StrToPChar(const Str: string): PChar;
function SaveLogError(Const AUnitError, ASimbolError, ADescription, ATypeError, ASQLError, AInsError: string): integer;

implementation

function VerificaCPF(num: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
  d1,d2: integer;
  digitado, calculado: string;
begin
  try
  n1:=StrToInt(num[1]);
  n2:=StrToInt(num[2]);
  n3:=StrToInt(num[3]);
  n4:=StrToInt(num[4]);
  n5:=StrToInt(num[5]);
  n6:=StrToInt(num[6]);
  n7:=StrToInt(num[7]);
  n8:=StrToInt(num[8]);
  n9:=StrToInt(num[9]);
  d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:=11-(d1 mod 11);
  if d1>=10 then d1:=0;
    d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
    d2:=11-(d2 mod 11);
  if d2>=10 then d2:=0;
    calculado:=inttostr(d1)+inttostr(d2);
    digitado:=num[10]+num[11];
  if calculado=digitado then
    VerificaCPF:=true
    else
    VerificaCPF:=false;
  except
   on EConvertError do
    VerificaCPF:=false;
  end;
end;

function VerificaData(Data : String):boolean;
begin
  try
  StrToDate(Data);
  Result := True;
  except
  on EConvertError do
    Result:=False;
end;
end;

procedure GetBuildInfo(var v1, v2, v3, v4: word);
Var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize:= GetFileVersionInfoSize(PChar(ParamStr(0)),Dummy);
  GetMem(VerInfo,VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)),0,VerInfoSize,VerInfo);
  VerQueryValue(VerInfo,'\',Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    v1:= dwFileVersionMS shr 16;
    v2:= dwFileVersionMS and $FFFF;
    v3:= dwFileVersionLS shr 16;
    v4:= dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function GetVersionInfo: String;
Var
  v1,v2,v3,v4 : Word;
begin
  GetBuildInfo(v1,v2,v3,v4);
  Result:= IntToStr(v1) + '.'
     + IntToStr(v2) + '.'
     + IntToStr(v3) + '.'
     + IntToStr(v4);
end;

function IdadeAtual(Nasc : TDate): Integer;
Var AuxIdade, Meses : String;
  MesesFloat : Real;
  IdadeInc, IdadeReal : Integer;
begin
  AuxIdade := Format('%0.2f', [(Date - Nasc) / 365.6]);
  Meses := FloatToStr(Frac(StrToFloat(AuxIdade)));
  if AuxIdade = '0' then
  begin
  Result := 0;
  Exit;
  end;
  if Meses[1] = '-' then
  begin
  Meses := FloatToStr(StrToFloat(Meses) * -1);
  end;
  Delete(Meses, 1, 2);
  if Length(Meses) = 1 then
  begin
  Meses := Meses + '0';
  end;
  if (Meses <> '0') And (Meses <> '') then
  begin
  MesesFloat := Round(((365.6 * StrToInt(Meses)) / 100) / 30.47)
  end
  else
  begin
  MesesFloat := 0;
  end;
  if MesesFloat <> 12 then
  begin
  IdadeReal := Trunc(StrToFloat(AuxIdade)); // + MesesFloat;
  end
  else
  begin
  IdadeInc := Trunc(StrToFloat(AuxIdade));
  Inc(IdadeInc);
  IdadeReal := IdadeInc;
  end;
  Result := IdadeReal;
end;

function RemoveEspaco(StrE:String):String;
Var Str:String;
n,i:Integer;
begin
  n:=  Length(StrE);
  for i:=1 to n do begin
    if StrE[i] <> #32 then
      Str:=Str+StrE[i];
  result:=Str;
end;
end;

function Criptografia(mStr: string): string;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
  mChave:String;
begin
  mChave:='cDiaBjUefGxZLhvmNoPstqR';
  Result := mStr;
  TamanhoString := Length(mStr);
  TamanhoChave := Length(mChave);
  for i := 1 to TamanhoString do
  begin
  pos := (i mod TamanhoChave);
  if pos = 0 then
  pos := TamanhoChave;
  posLetra := ord(Result[i]) xor ord(mChave[pos]);
  if posLetra = 0 then
  posLetra := ord(Result[i]);
  Result[i] := chr(posLetra);
  end;
end;

function StrToPChar(const Str: string): PChar;
{Converte String em Pchar}
type
  TRingIndex = 0..7;
var
  Ring: array[TRingIndex] of PChar;
  RingIndex: TRingIndex;
  Ptr: PChar;
begin
  Ptr := @Str[Length(Str)];
  Inc(Ptr);
  if Ptr^ = #0 then
  begin
  Result := @Str[1];
  end
  else
  begin
  Result := StrAlloc(Length(Str)+1);
  RingIndex := (RingIndex + 1) mod (High(TRingIndex) + 1);
  StrPCopy(Result,Str);
  StrDispose(Ring[RingIndex]);
  Ring[RingIndex]:= Result;
  end;
end;
//Gera log
function SaveLogError(Const AUnitError, ASimbolError, ADescription, ATypeError, ASQLError, AInsError: string): integer;
var
  VMemory: TMemoryStatus;
  VLogFile: TextFile;
  VLogFileName: string;
  vcount : Integer;
begin
  VMemory.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(VMemory);
  VLogFileName := GetCurrentDir+'\Sistema_Log.log';
  try
  AssignFile(VLogFile,VLogFileName);
  if FileExists(VLogFileName) then
  begin
  Append(VLogFile);
  Writeln(VLogFile,'');
Writeln(VLogFile,'--------------------------------------------------------------');
  Writeln(VLogFile,'');
  end
  else
  begin
  Rewrite(VLogFile);
  Writeln(VLogFile,'AL Software - Desenvolvendo seu Futuro');
  Writeln(VLogFile,'Contato:');
  Writeln(VLogFile,'   Cleyton Ferrari   Fone: 69 9975-0504  Email: cleytonferrari@hotmail.com');
  Writeln(VLogFile,'   Anderson Lopes    Fone: 69 9988-4966  Email: andersonlopes14@msn.com');
  Writeln(VLogFile,'Rua Rond?nia,  n? 3716  -  Centro');
  Writeln(VLogFile,'CEP: 78956-000   -   Alto Para?so - RO');
Writeln(VLogFile,'==============================================================');
  Writeln(VLogFile,'');
  end;
  Writeln(VLogFile,format('DATE/TIME............: %s',[DateTimeToStr(Now)]));
  Writeln(VLogFile,format('Unit Error...........: %s',[AUnitError]));
  Writeln(VLogFile,format('Call Symbol..........: %s',[ASimbolError]));
  Writeln(VLogFile,format('Error type...........: %s',[ATypeError]));
  Writeln(VLogFile,format('Description..........: %s',[ADescription]));
  Writeln(VLogFile,format('SQL Error............: %s',[ASQLError]));
  Writeln(VLogFile,format('Instruction error....: %s',[AInsError]));
  Writeln(VLogFile,'');
  Writeln(VLogFile,format('Memory free..........: %.0f bytes',[(VMemory.dwAvailPhys / 1024)])); // bytes livres de mem?ria f?sica
  Writeln(VLogFile,format('Total PageFile.......: %.0f bytes',[(VMemory.dwTotalPageFile / 1024)])); // bytes livres de pagina??o de arquivo // bytes de pagina??o de arquivo
  Writeln(VLogFile,format('Avail PageFile.......: %.0f bytes',[(VMemory.dwAvailPageFile / 1024)])); // bytes em uso de espa?o de endere?o
  Writeln(VLogFile,format('Total Virtual .......: %.0f bytes',[(VMemory.dwTotalVirtual / 1024)]));
  Writeln(VLogFile,format('Avail virtual free...: %.0f bytes',[(VMemory.dwAvailVirtual / 1024)])); // bytes livres
  CloseFile(VLogFile);
  result := IOResult;
  except
  result := IOResult;
  result := -1;
  end;
end;

end.

