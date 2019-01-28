object AlbumForm: TAlbumForm
  Left = 0
  Top = 0
  Caption = 'Album'
  ClientHeight = 342
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    546
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 209
    Top = 7
    Width = 26
    Height = 13
    Caption = 'Artist'
  end
  object Label2: TLabel
    Left = 9
    Top = 7
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object edtName: TDBEdit
    Left = 9
    Top = 24
    Width = 185
    Height = 21
    DataField = 'Name'
    DataSource = dsAlbum
    TabOrder = 0
  end
  object cbArtists: TDBLookupComboBox
    Left = 209
    Top = 24
    Width = 185
    Height = 21
    DataField = 'Artist'
    DataSource = dsAlbum
    KeyField = 'Self'
    ListField = 'Name'
    ListSource = dsArtists
    TabOrder = 1
  end
  object DBGrid2: TDBGrid
    AlignWithMargins = True
    Left = 9
    Top = 58
    Width = 528
    Height = 243
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsTracks
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 165
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GenreLookup'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Composer'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Milliseconds'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 462
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 381
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 4
    OnClick = Button2Click
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 310
    Width = 120
    Height = 25
    DataSource = dsTracks
    VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object adsTracks: TAureliusDataset
    DatasetField = adsAlbumTracks
    FieldDefs = <>
    Left = 52
    Top = 144
    object adsTracksId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
    object adsTracksName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Required = True
      Size = 255
    end
    object adsTracksComposer: TStringField
      DisplayWidth = 20
      FieldName = 'Composer'
      Size = 255
    end
    object adsTracksMilliseconds: TIntegerField
      FieldName = 'Milliseconds'
    end
    object adsTracksGenre: TAureliusEntityField
      FieldName = 'Genre'
    end
    object adsTracksGenreLookup: TStringField
      DisplayLabel = 'Genre'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'GenreLookup'
      LookupDataSet = adsGenres
      LookupKeyFields = 'Self'
      LookupResultField = 'Name'
      KeyFields = 'Genre'
      Size = 255
      Lookup = True
    end
  end
  object dsTracks: TDataSource
    DataSet = adsTracks
    Left = 52
    Top = 96
  end
  object dsArtists: TDataSource
    DataSet = adsArtists
    Left = 136
    Top = 96
  end
  object adsArtists: TAureliusDataset
    FieldDefs = <>
    Left = 136
    Top = 144
  end
  object dsAlbum: TDataSource
    DataSet = adsAlbum
    Left = 224
    Top = 96
  end
  object adsAlbum: TAureliusDataset
    FieldDefs = <>
    BeforePost = adsAlbumBeforePost
    Left = 224
    Top = 144
    object adsAlbumName: TStringField
      FieldName = 'Name'
      Required = True
      Size = 255
    end
    object adsAlbumArtist: TAureliusEntityField
      FieldName = 'Artist'
      Required = True
    end
    object adsAlbumTracks: TDataSetField
      FieldName = 'Tracks'
    end
    object adsAlbumArtistLookup: TStringField
      DisplayLabel = 'Artist'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'ArtistLookup'
      LookupDataSet = adsArtists
      LookupKeyFields = 'Self'
      LookupResultField = 'Name'
      KeyFields = 'Artist'
      Size = 255
      Lookup = True
    end
  end
  object dsGenres: TDataSource
    DataSet = adsGenres
    Left = 312
    Top = 96
  end
  object adsGenres: TAureliusDataset
    FieldDefs = <>
    Left = 312
    Top = 144
  end
end
