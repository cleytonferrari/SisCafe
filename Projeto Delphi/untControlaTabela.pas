unit untControlaTabela;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IBDatabase,ExtCtrls, Buttons, IBTable,Db, Mask, DBCtrls, IBQuery;

  Procedure NovoRegistro (TabelaDM:TDataSet);
  function AutoGen(DataBaseEnd:TIBDataBase;Generator: String): Integer;
  function AutoInc(DataBaseEnd:TIBDataBase;
      NomeTabela, NomeCampo: String): Integer;
  Procedure SalvarRegistro(TabelaDM:TDataSet);
  Procedure CancelarRegistro(TabelaDM:TDataSet);
  Procedure EditarRegistro(TabelaDM:TDataSet);
  Procedure ExcluirRegistro(TabelaDM:TDataSet);
implementation

uses untPrincipal, untDM, untFerramentas;

Procedure NovoRegistro (TabelaDM:TDataSet);
Begin
Try
  TabelaDM.Open;
  TabelaDM.Append;
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','Procedure NovoRegistro (TabelaDM:TDataSet)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar criar um Novo Registro!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso'  ,MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

//Pega o generator da tabela e acrecenta mais um e retorna o valor
function AutoGen(DataBaseEnd:TIBDataBase;Generator: String): Integer;
var
  int : integer;
  vQry : TIBQuery;
begin
Try
 vQry := TIBQuery.Create(Application);
  with vQry do begin
    Database := DataBaseEnd;
    SQL.Clear;

    SQL.Add('Select gen_id(' + Generator +',1) from rdb$database');

    Open;
    int:= FieldByName('gen_id').asInteger;
    Result := int;
    free;
  end; {with vQry}
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','function AutoGen(DataBaseEnd:TIBDataBase;Generator: String): Integer', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar criar a Auto-Numera??o para o registro!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

function AutoInc(DataBaseEnd:TIBDataBase;
      NomeTabela, NomeCampo: String): Integer;
var
  int : integer;
  vQry : TIBQuery;
begin
Try
 vQry := TIBQuery.Create(Application);
  with vQry do begin
    Database := DataBaseEnd;
    SQL.Clear;
    SQL.Add('Select Max(' + NomeCampo +') as Proximo');
    SQL.Add('From '+ NomeTabela);
    Open;
    int:= FieldByName('Proximo').asInteger + 1;
    Result := int;
    free;
  end; {with vQry}
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','function AutoInc(DataBaseEnd:TIBDataBase)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar criar a Auto-Numera??o para o registro!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

Procedure SalvarRegistro(TabelaDM:TDataSet);
begin
try
  TabelaDM.Post;
  TabelaDM.Close;
  Application.MessageBox(
  'Registro Salvo com Sucesso!!!',
  'Aviso',MB_OK+MB_ICONINFORMATION);
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','Procedure SalvarRegistro (TabelaDM:TDataSet)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar Salvar o Registro Atual!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

Procedure CancelarRegistro(TabelaDM:TDataSet);
begin
try
  TabelaDM.Cancel;
  TabelaDM.Close;
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','Procedure CencalarRegistro (TabelaDM:TDataSet)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar Cancelar o Registro Atual!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

Procedure EditarRegistro(TabelaDM:TDataSet);
begin
try
  TabelaDM.Edit;
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','Procedure EditarRegistro (TabelaDM:TDataSet)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar colocar o Registro em modo de Edi??o!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

Procedure ExcluirRegistro(TabelaDM:TDataSet);
begin
try
  if Application.MessageBox
  ('Confirma Exclus?o?','Excluir?',Mb_YesNo+mb_IconQuestion) = mrYes then
begin
  TabelaDM.Delete;
  TabelaDM.Close;
end
else
  TabelaDM.Close;
except
  on E: Exception do
  begin
    SaveLogError('untControlaTabela','Procedure ExcluirRegistro (TabelaDM:TDataSet)', E.Message, E.ClassName, '', '');
    Application.MessageBox(
    'Erro ao tentar Excluir o Registro Atual!!!'+#13#13+
    'Voc? deve reiniciar o Sistema e tentar novamente.',
    'Aviso',MB_OK+mb_iconerror );
    application.terminate;
  end;
end;
end;

end.

