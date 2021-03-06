unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, ActnList, jpeg, inifiles, Buttons;

type
  TfrmPrincipal = class(TForm)
    BarraStatus: TStatusBar;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Bairros1: TMenuItem;
    Endereos1: TMenuItem;
    AcoesPrincipal: TActionList;
    actCadBairros: TAction;
    actCadEndereco: TAction;
    actCadFornecedor: TAction;
    Fornecedor1: TMenuItem;
    actSacaria: TAction;
    Movimentao1: TMenuItem;
    ControledeSacaria1: TMenuItem;
    actEmprestimo: TAction;
    Controledeempr1: TMenuItem;
    Image1: TImage;
    actSobre: TAction;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    actCadCliente: TAction;
    Cliente1: TMenuItem;
    actCadProduto: TAction;
    Produto1: TMenuItem;
    actCompra: TAction;
    CompradeProdutos1: TMenuItem;
    actVenda: TAction;
    VendadeProdutos1: TMenuItem;
    Relatrios1: TMenuItem;
    actRelEndereco: TAction;
    Endereos2: TMenuItem;
    actRelFornecedor: TAction;
    Fornecedor2: TMenuItem;
    actRelCliente: TAction;
    Cliente2: TMenuItem;
    actRelProduto: TAction;
    actRelProduto1: TMenuItem;
    actRelSacaria: TAction;
    EmprestimoFinanceiro1: TMenuItem;
    actRelEmprestimo: TAction;
    EmprestimoSacaria1: TMenuItem;
    actRelCompraDetalhado: TAction;
    Compra1: TMenuItem;
    actRelVendaDetalhada: TAction;
    Venda1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure actCadBairrosExecute(Sender: TObject);
    procedure actCadEnderecoExecute(Sender: TObject);
    procedure actCadFornecedorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSacariaExecute(Sender: TObject);
    procedure actEmprestimoExecute(Sender: TObject);
    procedure actSobreExecute(Sender: TObject);
    procedure actCadClienteExecute(Sender: TObject);
    procedure actCadProdutoExecute(Sender: TObject);
    procedure actCompraExecute(Sender: TObject);
    procedure actVendaExecute(Sender: TObject);
    procedure actRelEnderecoExecute(Sender: TObject);
    procedure actRelFornecedorExecute(Sender: TObject);
    procedure actRelClienteExecute(Sender: TObject);
    procedure actRelProdutoExecute(Sender: TObject);
    procedure actRelEmprestimoExecute(Sender: TObject);
    procedure actRelSacariaExecute(Sender: TObject);
    procedure actRelCompraDetalhadoExecute(Sender: TObject);
    procedure actRelVendaDetalhadaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  ResultadoPesquisa2 : String;
    //Variaveis das Configura??es do Sistema
  CorEditEnter  :TColor;
  CorEditExit   :TColor;
  CorEditDisable:TColor;
  CorLabel      :TColor;
  CorLabelError :TColor;
  //Relatorio
  Rel_Cancelar:Boolean=False;
  Rel_Completo:Boolean=False;
  Rel_DI, Rel_DF, Rel_CodFornecedor, Rel_CodCompra : String;
  Rel_opcao, Rel_Tipo: Integer;


implementation

uses untCadBairros, untCadEnderecos, UntCadFornecedor, untSacaria,
  untEmprestimo, untFerramentas, untSobre, untCadCliente, untCadProduto,
  untCompra, untVenda, untRelEnderecos, untDM, untRelFornecedor,
  untRelCliente, untRelProduto, untRelEmprestimo, untRelSacaria,
  untRelCompraDetalhado, IBQuery, untRelCompraDetalhadoForm,
  untRelVendaDetalhadaForm, untRelVendaDetalhada;

{$R *.dfm}
{$R WindowsXP.Res}

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
ArqIni : TIniFile;
BD : String;
begin
  ArqIni := tIniFile.Create(GetCurrentDir+'\SisCafe.ini');
  Try
  BD := ArqIni.ReadString('DADOS', 'BD', BD);
  Finally
  ArqIni.Free;
  end;
  BarraStatus.Panels[3].Text := 'Servidor ['+BD+']';
  ShortDateFormat:= 'dddd, dd" de "mmmm" de "yyyy';
  BarraStatus.Panels[1].Text := DateToStr(Date);
  ShortDateFormat:= 'dd/mm/yyyy';
  BarraStatus.Panels[4].Text := 'Vers?o -  '+GetVersionInfo+'   ';


//###############################################
//        CONFIGURA??ES DO PAINEL DE CONFIGURA??O
  CorEditEnter  := clMoneyGreen;
  CorEditExit   := clWhite;
  CorEditDisable:= clBtnFace;
  CorLabel      := clBlack;
  CorLabelError := clRed;
end;

procedure TfrmPrincipal.actCadBairrosExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCadBairros := TfrmCadBairros.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCadBairros.ShowModal;
  finally
   frmCadBairros.Release;
   frmCadBairros := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCadBairros.Free;
end;

procedure TfrmPrincipal.actCadEnderecoExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCadEnderecos := TfrmCadEnderecos.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCadEnderecos.ShowModal;
  finally
   frmCadEnderecos.Release;
   frmCadEnderecos := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCadEnderecos.Free;
end;

procedure TfrmPrincipal.actCadFornecedorExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCadFornecedor := TfrmCadFornecedor.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCadFornecedor.ShowModal;
  finally
   frmCadFornecedor.Release;
   frmCadFornecedor := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCadFornecedor.Free;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ShortDateFormat:= 'dd/mm/yyyy';
end;

procedure TfrmPrincipal.actSacariaExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmSacaria := TfrmSacaria.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmSacaria.ShowModal;
  finally
   frmSacaria.Release;
   frmSacaria := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmSacaria.Free;
end;

procedure TfrmPrincipal.actEmprestimoExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmemprestimo := TfrmEmprestimo.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmEmprestimo.ShowModal;
  finally
   frmEmprestimo.Release;
   frmEmprestimo := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmEmprestimo.Free;
end;

procedure TfrmPrincipal.actSobreExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmSobre := TfrmSobre.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmSobre.ShowModal;
  finally
   frmSobre.Release;
   frmSobre := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmSobre.Free;
end;

procedure TfrmPrincipal.actCadClienteExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCadCliente := TfrmCadCliente.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCadCliente.ShowModal;
  finally
   frmCadCliente.Release;
   frmCadCliente := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCadCliente.Free;
end;

procedure TfrmPrincipal.actCadProdutoExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCadProduto := TfrmCadProduto.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCadProduto.ShowModal;
  finally
   frmCadProduto.Release;
   frmCadProduto := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCadProduto.Free;
end;

procedure TfrmPrincipal.actCompraExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmCompra := TfrmCompra.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmCompra.ShowModal;
  finally
   frmCompra.Release;
   frmCompra := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmCompra.Free;
end;

procedure TfrmPrincipal.actVendaExecute(Sender: TObject);
begin
  //Carrega form na mem?ria
  frmVenda := TfrmVenda.Create(Application);
  //Mostra form em modo exclusivo
  try
   frmVenda.ShowModal;
  finally
   frmVenda.Release;
   frmVenda := nil;
  end;
  //Aguarda a execu??o e depois Libera a Mem?ria
  frmVenda.Free;
end;

procedure TfrmPrincipal.actRelEnderecoExecute(Sender: TObject);
begin
   //monta relatorio
   with DM do begin
    qryRelEnderecos.Close;
    qryRelEnderecos.SQL.Clear;
    //
    qryRelEnderecos.SQL.Add ('SELECT * FROM ENDERECOCOMPLETO ORDER BY ENDERECOS_ID ');
    qryRelEnderecos.Open;
    if qryRelEnderecos.RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelEnderecos := TfrmRelEnderecos.Create(Application);
    try
      frmRelEnderecos.Qreport.Preview;
    finally
      frmRelEnderecos.Release;
      frmRelEnderecos :=  nil;
    end;
      frmRelEnderecos.Free;

end;

procedure TfrmPrincipal.actRelFornecedorExecute(Sender: TObject);
begin
   //monta relatorio
   with DM do begin
    qryRelFornecedor.Close;
    qryRelFornecedor.SQL.Clear;
    //
    qryRelFornecedor.SQL.Add ('SELECT * FROM FORNECEDORENDERECO ORDER BY NOME_RAZAOSOCIAL ');
    qryRelFornecedor.Open;
    if qryRelFornecedor.RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelFornecedor := TfrmRelFornecedor.Create(Application);
    try
      frmRelFornecedor.Qreport.Preview;
    finally
      frmRelFornecedor.Release;
      frmRelFornecedor :=  nil;
    end;
      frmRelFornecedor.Free;
end;

procedure TfrmPrincipal.actRelClienteExecute(Sender: TObject);
begin
   //monta relatorio
   with DM do begin
    qryRelCliente.Close;
    qryRelCliente.SQL.Clear;
    //
    qryRelCliente.SQL.Add ('SELECT * FROM CLIENTEENDERECO ORDER BY NOME_RAZAOSOCIAL ');
    qryRelCliente.Open;
    if qryRelCliente.RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelCliente := TfrmRelCliente.Create(Application);
    try
      frmRelCliente.Qreport.Preview;
    finally
      frmRelCliente.Release;
      frmRelCliente :=  nil;
    end;
      frmRelCliente.Free;
end;

procedure TfrmPrincipal.actRelProdutoExecute(Sender: TObject);
begin
   //monta relatorio
   with DM.qryRelProduto do begin
    Close;
    SQL.Clear;
    SQL.Add ('SELECT * FROM PRODUTO ORDER BY PRODUTO_ID');
    Open;
    if RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelProduto := TfrmRelProduto.Create(Application);
    try
      frmRelProduto.Qreport.Preview;
    finally
      frmRelProduto.Release;
      frmRelProduto :=  nil;
    end;
      frmRelProduto.Free;
end;

procedure TfrmPrincipal.actRelEmprestimoExecute(Sender: TObject);
begin
   //monta relatorio
   with DM.qryRelEmprestimo  do begin
    Close;
    SQL.Clear;
    SQL.Add ('SELECT * FROM FORNECEDOR WHERE EMPRESTIMO <> 0 ORDER BY NOME_RAZAOSOCIAL');
    Open;
    if RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelEmprestimo := TfrmRelEmprestimo.Create(Application);
    try
      frmRelEmprestimo.Qreport.Preview;
    finally
      frmRelEmprestimo.Release;
      frmRelEmprestimo :=  nil;
    end;
      frmRelEmprestimo.Free;
end;

procedure TfrmPrincipal.actRelSacariaExecute(Sender: TObject);
begin
   //monta relatorio
   with DM.qryRelSacaria  do begin
    Close;
    SQL.Clear;
    SQL.Add ('SELECT * FROM FORNECEDOR WHERE SACARIA <> 0 ORDER BY NOME_RAZAOSOCIAL');
    Open;
    if RecordCount < 1 then begin
      Application.MessageBox(
        'N?o Existe Dados Para o Montar o Relat?rio!',
        'Aviso' ,MB_OK + MB_ICONINFORMATION);
     exit;
    end;

   end;

      frmRelSacaria := TfrmRelSacaria.Create(Application);
    try
      frmRelSacaria.Qreport.Preview;
    finally
      frmRelSacaria.Release;
      frmRelSacaria :=  nil;
    end;
      frmRelSacaria.Free;
end;

procedure TfrmPrincipal.actRelCompraDetalhadoExecute(Sender: TObject);
begin
    frmRelCompraDetalhadoForm := TfrmRelCompraDetalhadoForm.Create(Application);
    try
      frmRelCompraDetalhadoForm.ShowModal;
    finally
      frmRelCompraDetalhadoForm.Release;
      frmRelCompraDetalhadoForm :=  nil;
    end;
      frmRelCompraDetalhadoForm.Free;

    if (Rel_Cancelar = False) then begin //Se nao clicar em Cancelar entra
       frmRelCompraDetalhado := TfrmRelCompraDetalhado.Create(Application);
       //monta relatorio
       with frmRelCompraDetalhado.qryCompraRel do begin
        Close;
        SQL.Clear;
        SQL.Add ('select fornecedor.nome_razaosocial, fornecedor.fornecedor_id, compra.compra_id,');
        SQL.Add ('compra.data, compra.opcao, compra.funrural from compra, fornecedor ');
            SQL.Add ('where compra.fornecedor_id = fornecedor.fornecedor_id ');
        Case Rel_opcao of
        0: begin
            //Por codigo do Fornecedor
            SQL.Add (' and compra.fornecedor_id = '+Rel_CodFornecedor);
           end;
        1: begin
            //Por Data da compra
            SQL.Add (' and ((compra.data >= :DI) and (data <= :DF ))');
            ParamByName('DI').AsDate := StrToDate(Rel_DI);
            ParamByName('DF').AsDate := StrToDate(Rel_DF);

           end;
        2: begin
            //Por codigo da compra
            SQL.Add (' and compra.compra_id = '+Rel_CodCompra);
           end;
        3: begin
            //Completo
            SQL.Add (' ');
           end;
        end;
        Case Rel_Tipo of
        0: begin
             //Compra do Deposito
            SQL.Add (' and compra.opcao = ''COMPRA EM DEPOSITO''');
           end;
        1: begin
            //Compras
            SQL.Add (' and compra.opcao = ''COMPRA''');

           end;
        2: begin
            //Deposito
            SQL.Add (' and compra.opcao = ''DEPOSITO''');
           end;
        3: begin
            //Retiraca
            SQL.Add (' and compra.opcao = ''RETIRADA''');
           end;
        4: begin
            //Todos
            SQL.Add (' ');
           end;
        end;

        Open;
        if RecordCount < 1 then begin
          Application.MessageBox(
            'N?o Existe Dados Para o Montar o Relat?rio!',
            'Aviso' ,MB_OK + MB_ICONINFORMATION);
         exit;
        end;
       end;

       frmRelCompraDetalhado.qryItensCompraRel.Open;

        try
          frmRelCompraDetalhado.Qreport.Preview;
        finally
          frmRelCompraDetalhado.Release;
          frmRelCompraDetalhado :=  nil;
        end;
          frmRelCompraDetalhado.Free;

   end; //Opcao do IF
end;

procedure TfrmPrincipal.actRelVendaDetalhadaExecute(Sender: TObject);
begin
    frmRelVendaDetalhadaForm := TfrmRelVendaDetalhadaForm.Create(Application);
    try
      frmRelVendaDetalhadaForm.ShowModal;
    finally
      frmRelVendaDetalhadaForm.Release;
      frmRelVendaDetalhadaForm :=  nil;
    end;
      frmRelVendaDetalhadaForm.Free;

    if (Rel_Cancelar = False) then begin //Se nao clicar em Cancelar entra
       frmRelVendaDetalhada := TfrmRelVendaDetalhada.Create(Application);
       //monta relatorio
       with frmRelVendaDetalhada.qryCompraRel do begin
        Close;
        SQL.Clear;
        SQL.Add ('select cliente.nome_razaosocial, cliente.cliente_id, venda.venda_id,');
        SQL.Add ('venda.data from venda, cliente ');
            SQL.Add ('where venda.cliente_id = cliente.cliente_id ');

        Case Rel_opcao of
        0: begin
            //Por codigo do Fornecedor
            SQL.Add (' and venda.cliente_id = '+Rel_CodFornecedor);
           end;
        1: begin
            //Por Data da compra
            SQL.Add (' and ((data >= :DI) and (data <= :DF ))');
            ParamByName('DI').AsDate := StrToDate(Rel_DI);
            ParamByName('DF').AsDate := StrToDate(Rel_DF);

           end;
        2: begin
            //Por codigo da compra
            SQL.Add (' and venda.venda_id = '+Rel_CodCompra);
           end;
        3: begin
            //Completo
            SQL.Add (' ');
           end;
        end;

        Open;
        if RecordCount < 1 then begin
          Application.MessageBox(
            'N?o Existe Dados Para o Montar o Relat?rio!',
            'Aviso' ,MB_OK + MB_ICONINFORMATION);
         exit;
        end;
       end;

       frmRelVendaDetalhada.qryItensCompraRel.Open;

        try
          frmRelVendaDetalhada.Qreport.Preview;
        finally
          frmRelVendaDetalhada.Release;
          frmRelVendaDetalhada :=  nil;
        end;
          frmRelVendaDetalhada.Free;

   end; //Opcao do IF
end;

end.
