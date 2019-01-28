object AlbumsForm: TAlbumsForm
  Left = 0
  Top = 0
  Caption = 'Albuns'
  ClientHeight = 451
  ClientWidth = 710
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 218
    Width = 710
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 8
    ExplicitTop = -6
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      710
      49)
    object edtSearch: TLabeledEdit
      Left = 8
      Top = 24
      Width = 225
      Height = 21
      EditLabel.Width = 122
      EditLabel.Height = 13
      EditLabel.Caption = 'Search by Album or Artist'
      TabOrder = 0
      TextHint = 'Press <Enter> to search'
      OnKeyDown = edtSearchKeyDown
    end
    object btnNewAlbum: TButton
      Left = 612
      Top = 22
      Width = 88
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Create Album'
      TabOrder = 1
      OnClick = btnNewAlbumClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 710
    Height = 169
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      710
      169)
    object DBGrid1: TDBGrid
      Left = 8
      Top = 7
      Width = 692
      Height = 160
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsAlbuns
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Name'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Artist.Name'
          Title.Caption = 'Artist'
          Width = 200
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 221
    Width = 710
    Height = 230
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      710
      230)
    object Label1: TLabel
      Left = 8
      Top = 3
      Width = 63
      Height = 13
      Alignment = taCenter
      Caption = 'Album Tracks'
    end
    object DBGrid2: TDBGrid
      Left = 8
      Top = 20
      Width = 692
      Height = 201
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsTracks
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
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
          Width = 215
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Genre.Name'
          Title.Caption = 'Genre'
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Composer'
          Title.Caption = 'Composers'
          Width = 252
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Duration'
          Visible = True
        end>
    end
  end
  object adsAlbums: TAureliusDataset
    FieldDefs = <>
    Left = 336
    Top = 48
    object adsAlbumsId: TIntegerField
      FieldName = 'Id'
    end
    object adsAlbumsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 255
    end
    object adsAlbumsArtistName: TStringField
      DisplayWidth = 20
      FieldName = 'Artist.Name'
      Size = 255
    end
    object adsAlbumsTracks: TDataSetField
      FieldName = 'Tracks'
    end
  end
  object dsAlbuns: TDataSource
    DataSet = adsAlbums
    Left = 336
    Top = 103
  end
  object adsTracks: TAureliusDataset
    FieldDefs = <>
    Left = 392
    Top = 264
    object adsTracksId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
    object adsTracksName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 255
    end
    object adsTracksGenreName: TStringField
      DisplayWidth = 20
      FieldName = 'Genre.Name'
      Size = 255
    end
    object adsTracksComposer: TStringField
      DisplayWidth = 30
      FieldName = 'Composer'
      Size = 255
    end
    object adsTracksDuration: TStringField
      FieldName = 'Duration'
      Size = 15
    end
  end
  object dsTracks: TDataSource
    DataSet = adsTracks
    Left = 392
    Top = 312
  end
end
