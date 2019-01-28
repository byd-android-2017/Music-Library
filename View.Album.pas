/// <summary>
///  ³ªÆ¬±à¼­´°Ìå
/// </summary>

unit View.Album;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  MusicEntities, System.Generics.Collections, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask,
  Aurelius.Engine.ObjectManager,
  Aurelius.Bind.BaseDataset, Aurelius.Bind.Dataset;

type
  TAlbumForm = class(TForm)
    edtName: TDBEdit;
    cbArtists: TDBLookupComboBox;
    Label1: TLabel;
    DBGrid2: TDBGrid;
    adsTracks: TAureliusDataset;
    adsTracksId: TIntegerField;
    adsTracksName: TStringField;
    adsTracksComposer: TStringField;
    adsTracksMilliseconds: TIntegerField;
    dsTracks: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    dsArtists: TDataSource;
    adsArtists: TAureliusDataset;
    dsAlbum: TDataSource;
    adsAlbum: TAureliusDataset;
    dsGenres: TDataSource;
    adsGenres: TAureliusDataset;
    adsAlbumName: TStringField;
    adsAlbumArtist: TAureliusEntityField;
    adsAlbumTracks: TDataSetField;
    adsTracksGenre: TAureliusEntityField;
    adsTracksGenreLookup: TStringField;
    adsAlbumArtistLookup: TStringField;
    DBNavigator1: TDBNavigator;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure adsAlbumBeforePost(DataSet: TDataSet);
  private
    procedure SetAlbum(AAlbum: TAlbum; AManager: TObjectManager);
  public
    class function Edit(AAlbum: TAlbum; AManager: TObjectManager): Boolean;
  end;

implementation

{$R *.dfm}

procedure TAlbumForm.SetAlbum(AAlbum: TAlbum; AManager: TObjectManager);
begin
  adsGenres.Close;
  adsGenres.SetSourceCriteria(AManager.Find<TGenre>.OrderBy('Name'));
  adsGenres.Open;

  adsArtists.Close;
  adsArtists.SetSourceCriteria(AManager.Find<TArtist>.OrderBy('Name'));
  adsArtists.Open;

  adsAlbum.Close;
  adsAlbum.SetSourceObject(AAlbum);
  adsAlbum.Open;
  adsAlbum.Edit;
end;

procedure TAlbumForm.adsAlbumBeforePost(DataSet: TDataSet);
begin
  if adsAlbum.FieldByName('Name').AsString = '' then
    raise Exception.Create('Field "Name" must have a value');
end;

procedure TAlbumForm.Button1Click(Sender: TObject);
begin
  adsAlbum.Cancel;
end;

procedure TAlbumForm.Button2Click(Sender: TObject);
begin
  adsAlbum.Post;
  ModalResult := mrOk;
end;

class function TAlbumForm.Edit(AAlbum: TAlbum;
  AManager: TObjectManager): Boolean;
var
  Form: TAlbumForm;
begin
  Form := TAlbumForm.Create(Application);
  try
    Form.SetAlbum(AAlbum, AManager);
    Result := Form.ShowModal = mrOk;
  finally
    Form.Free;
  end;
end;

end.
