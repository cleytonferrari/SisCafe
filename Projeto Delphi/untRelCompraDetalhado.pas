unit untRelCompraDetalhado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, DB, IBCustomDataSet, IBTable,
  IBQuery;

type
  TfrmRelCompraDetalhado = class(TForm)
    QReport: TQuickRep;
    QRBand1: TQRBand;
    QuadradoBorda: TQRShape;
    lblTitulo: TQRLabel;
    linha: TQRShape;
    logo: TQRImage;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    bandCompra: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand3: TQRBand;
    QRShape7: TQRShape;
    lblSisCafe: TQRLabel;
    lblVersaoTXT: TQRLabel;
    lblVersao: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    qryItensCompraRel: TIBQuery;
    qryCompraRel: TIBQuery;
    qryCompraRelNOME_RAZAOSOCIAL: TIBStringField;
    qryCompraRelCOMPRA_ID: TIntegerField;
    qryCompraRelDATA: TDateField;
    qryCompraRelOPCAO: TIBStringField;
    qryCompraRelFUNRURAL: TIBBCDField;
    qryItensCompraRelCOMPRA_ID: TIntegerField;
    qryItensCompraRelAPROVEITAMENTO: TIBBCDField;
    qryItensCompraRelQUANTIDADE: TIBBCDField;
    qryItensCompraRelPRODUTO_ID: TIntegerField;
    qryItensCompraRelUND: TIBStringField;
    qryItensCompraRelDESCRICAO: TIBStringField;
    qryItensCompraRelVALORCOMPRA: TIBBCDField;
    qryItensCompraRelVALORTOTAL: TIBBCDField;
    QRSubDetail1: TQRSubDetail;
    GroupHeaderBand1: TQRBand;
    dsRelCompraDetalhado: TDataSource;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    GroupFooterBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel6: TQRLabel;
    QRShape2: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
    qryCompraRelFORNECEDOR_ID: TIntegerField;
    procedure QReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCompraDetalhado: TfrmRelCompraDetalhado;

implementation

uses untFerramentas, untDM;

{$R *.dfm}

procedure TfrmRelCompraDetalhado.QReportBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
   lblVersao.Caption :=  GetVersionInfo;
end;

end.
