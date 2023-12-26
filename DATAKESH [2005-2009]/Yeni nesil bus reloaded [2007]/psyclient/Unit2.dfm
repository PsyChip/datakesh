object Form2: TForm2
  Left = 200
  Top = 89
  Width = 738
  Height = 505
  ActiveControl = ListView1
  Caption = 'Dosya Y'#246'neticisi'
  Color = 1315860
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 730
    Height = 453
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    Columns = <>
    Ctl3D = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    LargeImages = ImageList1
    ReadOnly = True
    ParentFont = False
    PopupMenu = PopupMenu1
    SmallImages = ImageList1
    StateImages = ImageList1
    TabOrder = 0
    OnDblClick = ListView1DblClick
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 648
  end
  object PopupMenu1: TPopupMenu
    Left = 648
    Top = 32
    object indir1: TMenuItem
      Caption = 'indir'
      OnClick = indir1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Shellexecute1: TMenuItem
      Caption = 'Shellexecute'
      OnClick = Shellexecute1Click
    end
    object CreateProcess1: TMenuItem
      Caption = 'CreateProcess'
      OnClick = CreateProcess1Click
    end
    object Winexec1: TMenuItem
      Caption = 'Winexec'
      OnClick = Winexec1Click
    end
    object GizliCalistir1: TMenuItem
      Caption = 'Gizli Shellexec'
      OnClick = GizliCalistir1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Yenile1: TMenuItem
      Caption = 'Yenile'
      OnClick = Yenile1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Kopyala1: TMenuItem
      Caption = 'Kopyala'
      OnClick = Kopyala1Click
    end
    object Sil1: TMenuItem
      Caption = 'Sil'
      OnClick = Sil1Click
    end
    object YenidenAdlandr1: TMenuItem
      Caption = 'Yeniden Adland'#305'r'
      OnClick = YenidenAdlandr1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object zellikler1: TMenuItem
      Caption = #214'zellikler'
      OnClick = zellikler1Click
    end
  end
  object MainMenu1: TMainMenu
    object Diz1: TMenuItem
      Caption = 'S'#305'rala'
      object reGre1: TMenuItem
        AutoCheck = True
        Caption = 'T'#252're G'#246're'
        Checked = True
      end
    end
    object Grnm1: TMenuItem
      Caption = 'G'#246'r'#252'n'#252'm'
      object ikon1: TMenuItem
        Caption = 'B'#252'y'#252'k'
        OnClick = ikon1Click
      end
      object Kk1: TMenuItem
        Caption = 'K'#252#231#252'k'
        OnClick = Kk1Click
      end
    end
  end
end
