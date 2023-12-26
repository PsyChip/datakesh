object Form4: TForm4
  Left = 621
  Top = 143
  Width = 358
  Height = 375
  Caption = 'Pencere Y'#246'neticisi'
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
    Width = 350
    Height = 343
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    Font.Charset = TURKISH_CHARSET
    Font.Color = clLime
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 8
    object Kapat1: TMenuItem
      Caption = 'Etkinle$tir'
      OnClick = Kapat1Click
    end
    object Flash1: TMenuItem
      Caption = 'Flash'
      OnClick = Flash1Click
    end
    object Sakla1: TMenuItem
      Caption = 'Sakla'
      OnClick = Sakla1Click
    end
    object Gster1: TMenuItem
      Caption = 'G'#246'ster'
      OnClick = Gster1Click
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
    object Kapat2: TMenuItem
      Caption = 'Kapat'
      OnClick = Kapat2Click
    end
  end
end
