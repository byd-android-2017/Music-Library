unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Menus, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  Aurelius.Engine.ObjectManager,
  Aurelius.Drivers.Interfaces,
  Aurelius.Bind.Dataset,
  MusicEntities;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    PageControl1: TPageControl;
    tsAuditLog: TTabSheet;
    tsSqlLog: TTabSheet;
    Entities1: TMenuItem;
    Artists1: TMenuItem;
    Genres1: TMenuItem;
    tsAlbums: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Artists1Click(Sender: TObject);
    procedure Genres1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Connection: IDBConnection;
    procedure ShowAlbumsForm;
    procedure ShowAuditLogForm;
    procedure ShowSqlMonitorForm;
  public
  end;

var
  MainForm: TMainForm;

implementation

uses
  SQLiteConnectionModule,
  DatabaseUtils,
  View.Artists, View.Albuns, View.Genres, AuditLogViewer, SqlMonitor;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Connection := TSQLiteConnection.CreateConnection;
  UpdateDatabase(Connection);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ShowSqlMonitorForm;
  ShowAuditLogForm;
  ShowAlbumsForm;
end;

procedure TMainForm.ShowAlbumsForm;
var
  Form: TAlbumsForm;
begin
  Form := TAlbumsForm.Create(Application, TObjectManager.Create(Connection), True);
  Form.Parent := tsAlbums;
  Form.Align := alClient;
  Form.BorderStyle := bsNone;
  Form.Show;
end;

procedure TMainForm.ShowAuditLogForm;
var
  Form: TAuditLogForm;
begin
  Form := TAuditLogForm.GetInstance;
  Form.Parent := tsAuditLog;
  Form.Align := alClient;
  Form.BorderStyle := bsNone;
  Form.Show;
end;

procedure TMainForm.ShowSqlMonitorForm;
var
  Form: TSqlMonitorForm;
begin
  Form := TSqlMonitorForm.GetInstance;
  Form.Parent := tsSqlLog;
  Form.Align := alClient;
  Form.BorderStyle := bsNone;
  Form.Show;
end;

procedure TMainForm.Artists1Click(Sender: TObject);
begin
  TArtistsForm.Display(TObjectManager.Create(Connection), True);
end;

procedure TMainForm.Genres1Click(Sender: TObject);
begin
  TGenresForm.Display(TObjectManager.Create(Connection), True);
end;



end.
