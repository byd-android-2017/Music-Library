program MusicLibraryVCL;

uses
  Vcl.Forms,
  AuditLogViewer in 'AuditLogViewer.pas' {AuditLogForm},
  DatabaseUtils in 'DatabaseUtils.pas',
  MusicEntities in 'MusicEntities.pas',
  SQLiteConnectionModule in 'SQLiteConnectionModule.pas' {SQLiteConnection: TDataModule},
  SqlMonitor in 'SqlMonitor.pas' {SqlMonitorForm},
  View.Album in 'View.Album.pas' {AlbumForm},
  View.Albuns in 'View.Albuns.pas' {AlbumsForm},
  View.Artists in 'View.Artists.pas' {ArtistsForm},
  View.Genres in 'View.Genres.pas' {GenresForm},
  View.Main in 'View.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
