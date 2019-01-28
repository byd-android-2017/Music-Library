object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Music Library VCL'
  ClientHeight = 458
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 740
    Height = 458
    ActivePage = tsAlbums
    Align = alClient
    TabOrder = 0
    object tsAlbums: TTabSheet
      Caption = 'Albums'
      ImageIndex = 2
    end
    object tsAuditLog: TTabSheet
      Caption = 'Audit Log'
    end
    object tsSqlLog: TTabSheet
      Caption = 'SQL Log'
      ImageIndex = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 312
    Top = 64
    object Entities1: TMenuItem
      Caption = 'Entities'
      object Artists1: TMenuItem
        Caption = 'Artists'
        OnClick = Artists1Click
      end
      object Genres1: TMenuItem
        Caption = 'Genres'
        OnClick = Genres1Click
      end
    end
  end
end
