/// <summary>
///  唱片编辑浏览窗体
/// </summary>

unit View.Albuns;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Data.DB, Aurelius.Bind.Dataset, Vcl.StdCtrls, Vcl.ExtCtrls,
  Aurelius.Engine.ObjectManager, Aurelius.Bind.BaseDataset;

type
  TAlbumsForm = class(TForm)
    adsAlbums: TAureliusDataset;
    dsAlbuns: TDataSource;
    adsTracks: TAureliusDataset;
    dsTracks: TDataSource;
    adsAlbumsId: TIntegerField;
    adsAlbumsName: TStringField;
    adsAlbumsArtistName: TStringField;
    adsTracksId: TIntegerField;
    adsTracksName: TStringField;
    adsTracksGenreName: TStringField;
    adsTracksComposer: TStringField;
    adsAlbumsTracks: TDataSetField;
    Panel1: TPanel;
    edtSearch: TLabeledEdit;
    btnNewAlbum: TButton;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    Splitter1: TSplitter;
    adsTracksDuration: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnNewAlbumClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  strict private
    FManager: TObjectManager;
    FOwnsManager: Boolean;

    /// <summary>
    /// 根据唱片名或艺术家名加载唱片数据集。
    /// </summary>
    /// <param name="SelectedId">
    ///   当前选择对象标识
    /// </param>
    procedure LoadData(SelectedId: Integer = 0);

    /// <summary>
    /// 显示唱片编辑窗体。
    /// </summary>
    procedure EditAlbum;
  public
    /// <summary>
    /// 显示唱片编辑浏览窗体。
    /// </summary>
    /// <param name="AOwner">
    ///   拥有者
    /// </param>
    /// <param name="AManager">
    ///   实体对象管理器。
    /// </param>
    /// <param name="AOwnsManager">
    ///   是否拥有实体对象管理器，即管理它的生命周期。
    /// </param>
    constructor Create(AOwner: TComponent; AManager: TObjectManager; //
        AOwnsManager: Boolean); reintroduce;

    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses
  System.UITypes,
  Aurelius.Criteria.Linq, Aurelius.Criteria.Base,
  MusicEntities, View.Album;

constructor TAlbumsForm.Create(AOwner: TComponent; AManager: TObjectManager;
  AOwnsManager: Boolean);
begin
  inherited Create(AOwner);
  FManager := AManager;
  FOwnsManager := AOwnsManager;
end;

destructor TAlbumsForm.Destroy;
begin
  adsAlbums.Close;
  adsTracks.Close;
  if FOwnsManager then
    FManager.Free;
  inherited;
end;

procedure TAlbumsForm.FormShow(Sender: TObject);
begin
  inherited;
  LoadData;
end;

procedure TAlbumsForm.LoadData(SelectedId: Integer = 0);
var
  Criteria: TCriteria;
  Term: string;
begin
  if (SelectedId = 0) and (adsAlbums.Current<TAlbum> <> nil) then
    SelectedId := adsAlbums.Current<TAlbum>.Id;

  adsAlbums.Close;
  adsTracks.Close;
  FManager.Clear;

  Criteria := FManager.Find<TAlbum>.OrderBy('Name');

  Term := UpperCase(edtSearch.Text);
  if Term <> '' then
    Criteria
      .CreateAlias('Artist', 'a')
      .Add(
        Linq['Name'].Upper.Contains(Term) or Linq['a.Name'].Upper.Contains(Term)
      );
  adsAlbums.SetSourceCriteria(Criteria);

  adsAlbums.Open;
  if SelectedId <> 0 then
    adsAlbums.Locate('Id', SelectedId, []);

  adsTracks.DatasetField := (adsAlbums.FieldByName('Tracks') as TDataSetField);
  adsTracks.Open;
end;

procedure TAlbumsForm.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    LoadData;
end;

procedure TAlbumsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{ Create Album }

procedure TAlbumsForm.btnNewAlbumClick(Sender: TObject);
var
  album: TAlbum;
  track: TTrack;
  Edited: Boolean;
begin
  album := TAlbum.Create;
  try
    Edited := TAlbumForm.Edit(album, FManager);
    if Edited then
    begin
      edtSearch.Clear;
      FManager.Save(album);
    end;
  finally
    for track in album.Tracks do
      if not FManager.IsAttached(track) then
        track.Free;
    if not FManager.IsAttached(album) then
      album.Free;
  end;

  if Edited then
    LoadData(album.Id);
end;

procedure TAlbumsForm.DBGrid1DblClick(Sender: TObject);
begin
  EditAlbum;
end;

procedure TAlbumsForm.EditAlbum;
var
  album: TAlbum;
  track: TTrack;
begin
  album := adsAlbums.Current<TAlbum>;
  if not Assigned(album) then Exit;

  if TAlbumForm.Edit(album, FManager) then
  begin
    FManager.Flush(album);
  end
  else
  begin
    for track in album.Tracks do
      if not FManager.IsAttached(track) then
        track.Free;
  end;

  adsAlbums.Locate('Id', album.Id, [])
end;

end.
