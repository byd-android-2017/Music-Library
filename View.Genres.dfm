object GenresForm: TGenresForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Genres'
  ClientHeight = 373
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    226
    373)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 10
    Top = 45
    Width = 206
    Height = 316
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsGenres
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 163
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 10
    Top = 10
    Width = 204
    Height = 25
    DataSource = dsGenres
    VisibleButtons = [nbFirst, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    TabOrder = 1
  end
  object adsGenres: TAureliusDataset
    FieldDefs = <>
    Left = 64
    Top = 72
    object adsGenresId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
    object adsGenresName: TStringField
      DisplayWidth = 15
      FieldName = 'Name'
      Size = 100
    end
  end
  object dsGenres: TDataSource
    DataSet = adsGenres
    Left = 16
    Top = 72
  end
end
