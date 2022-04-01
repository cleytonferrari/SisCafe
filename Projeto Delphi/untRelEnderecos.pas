unit untRelEnderecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls;

type
  TfrmRelEnderecos = class(TForm)
    QReport: TQuickRep;
    QRBand1: TQRBand;
    QuadradoBorda: TQRShape;
    lblTitulo: TQRLabel;
    linha: TQRShape;
    logo: TQRImage;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRShape7: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    lblSisCafe: TQRLabel;
    lblVersaoTXT: TQRLabel;
    lblVersao: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEnderecos: TfrmRelEnderecos;

implementation

uses untFerramentas, untDM;

{$R *.dfm}

procedure TfrmRelEnderecos.QReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblVersao.Caption :=  GetVersionInfo;
end;

end.
