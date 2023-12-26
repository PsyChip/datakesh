object Form3: TForm3
  Left = 372
  Top = 111
  Width = 280
  Height = 587
  Caption = 'i$lem y'#246'neticisi'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 272
    Height = 555
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    Font.Charset = TURKISH_CHARSET
    Font.Color = clLime
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 18
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    object Gebert1: TMenuItem
      Caption = 'Gebert!'
      OnClick = Gebert1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Yenile1: TMenuItem
      Caption = 'Yenile'
      OnClick = Yenile1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Yeniilem1: TMenuItem
      Caption = 'Program Calistir'
      OnClick = Yeniilem1Click
    end
  end
end
