object frmProtSisCafe: TfrmProtSisCafe
  Left = 305
  Top = 238
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 89
  ClientWidth = 182
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Relogio01: TTimer
    Interval = 0
    OnTimer = Relogio01Timer
    Left = 72
    Top = 16
  end
  object Timer1: TTimer
    Interval = 3500
    OnTimer = Timer1Timer
    Left = 112
    Top = 16
  end
end
