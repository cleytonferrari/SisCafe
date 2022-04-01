unit untRelSacaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls;

type
  TfrmRelSacaria = class(TForm)
    QReport: TQuickRep;
    QRBand1: TQRBand;
    QuadradoBorda: TQRShape;
    lblTitulo: TQRLabel;
    linha: TQRShape;
    logo: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    bandValores: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand3: TQRBand;
    QRShape7: TQRShape;
    lblSisCafe: TQRLabel;
    lblVersaoTXT: TQRLabel;
    lblVersao: TQRLabel;
    QRBand2: TQRBand;
    QRExpr1: TQRExpr;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    procedure QReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelSacaria: TfrmRelSacaria;

implementation

uses untEmprestimo, untDM, untFerramentas;

{$R *.dfm}

procedure TfrmRelSacaria.QReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblVersao.Caption :=  GetVersionInfo;
end;

end.
