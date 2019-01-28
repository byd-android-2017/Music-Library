/// <summary>
///  艺术家编辑浏览窗体
/// </summary>

unit View.Artists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Aurelius.Engine.ObjectManager, Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset;

type
  TArtistsForm = class(TForm)
    DBGrid1: TDBGrid;
    adsArtists: TAureliusDataset;
    dsArtists: TDataSource;
    adsArtistsId: TIntegerField;
    adsArtistsName: TStringField;
    edtSearch: TLabeledEdit;
    DBNavigator1: TDBNavigator;
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure adsArtistsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    FOwnsManager: Boolean;
  public
    /// <summary>
    /// 显示艺术家编辑浏览窗体。
    /// </summary>
    /// <param name="AManager">
    ///   实体对象管理器。
    /// </param>
    /// <param name="AOwnsManager">
    ///   是否拥有实体对象管理器，即管理它的生命周期。
    /// </param>
    class procedure Display(AManager: TObjectManager; AOwnsManager: Boolean);

    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses
  MusicEntities;

class procedure TArtistsForm.Display(AManager: TObjectManager; AOwnsManager: Boolean);
var
  Form: TArtistsForm;
begin
  Form := TArtistsForm.Create(Application);
  try
    Form.FOwnsManager := AOwnsManager;
    Form.adsArtists.Close;
    Form.adsArtists.Manager := AManager;
    Form.adsArtists.SetSourceCriteria(AManager.Find<TArtist>.OrderBy('Name'));
    Form.adsArtists.Open;
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

destructor TArtistsForm.Destroy;
begin
  adsArtists.Close;
  if FOwnsManager then
    adsArtists.Manager.Free;

  inherited;
end;


procedure TArtistsForm.adsArtistsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := Pos(UpperCase(edtSearch.Text), UpperCase(Dataset.FieldByName('Name').AsString)) > 0;
end;

procedure TArtistsForm.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    adsArtists.Filtered := False;
    adsArtists.Filtered := edtSearch.Text <> '';
  end;
end;

end.
