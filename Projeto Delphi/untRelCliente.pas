unit untRelCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls;

type
  TfrmRelCliente = class(TForm)
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
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRShape2: TQRShape;
    QRBand3: TQRBand;
    QRShape7: TQRShape;
    lblSisCafe: TQRLabel;
    lblVersaoTXT: TQRLabel;
    lblVersao: TQRLabel;
    procedure QReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCliente: TfrmRelCliente;

implementation

uses untDM, untFerramentas;

{$R *.dfm}

procedure TfrmRelCliente.QReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblVersao.Caption :=  GetVersionInfo;
end;

end.
