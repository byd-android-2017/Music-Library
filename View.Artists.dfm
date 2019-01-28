object ArtistsForm: TArtistsForm
  Left = 0
  Top = 0
  ActiveControl = edtSearch
  BorderIcons = [biSystemMenu]
  Caption = 'Artists'
  ClientHeight = 380
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    274
    380)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 10
    Top = 91
    Width = 254
    Height = 277
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsArtists
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 210
        Visible = True
      end>
  end
  object edtSearch: TLabeledEdit
    Left = 10
    Top = 23
    Width = 254
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'Search by Name'
    TabOrder = 0
    TextHint = 'Press <Enter> to search for an artist'
    OnKeyPress = edtSearchKeyPress
  end
  object DBNavigator1: TDBNavigator
    Left = 10
    Top = 53
    Width = 204
    Height = 25
    DataSource = dsArtists
    VisibleButtons = [nbFirst, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    TabOrder = 2
  end
  object adsArtists: TAureliusDataset
    FieldDefs = <>
    OnFilterRecord = adsArtistsFilterRecord
    Left = 32
    Top = 160
    object adsArtistsId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
    object adsArtistsName: TStringField
      FieldName = 'Name'
      Required = True
    end
  end
  object dsArtists: TDataSource
    DataSet = adsArtists
    Left = 32
    Top = 216
  end
end
