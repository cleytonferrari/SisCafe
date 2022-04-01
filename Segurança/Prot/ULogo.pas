unit ULogo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg;

type
  TfrmLogo = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogo: TfrmLogo;

implementation

{$R *.dfm}

procedure TfrmLogo.FormShow(Sender: TObject);
begin
  timer1.Interval := 2500;
end;

procedure TfrmLogo.Timer1Timer(Sender: TObject);
begin
  close;
end;

end.
