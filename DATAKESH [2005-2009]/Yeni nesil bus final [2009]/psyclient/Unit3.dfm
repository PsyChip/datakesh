object Form3: TForm3
  Left = 227
  Top = 309
  BorderStyle = bsNone
  ClientHeight = 26
  ClientWidth = 534
  Color = clBlack
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    Left = 8
    Top = 6
    Width = 4
    Height = 13
    Color = clBlack
    Font.Charset = TURKISH_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object FlatButton9: TFlatButton
    Left = 496
    Top = 5
    Width = 26
    Height = 17
    Color = -1
    ColorFocused = clGreen
    ColorDown = clMaroon
    ColorBorder = clLime
    ColorHighLight = clBlack
    Caption = 'X'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentColor = False
    TabOrder = 0
    OnClick = FlatButton9Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 456
  end
end
