/// <summary>
///  曲风编辑浏览窗体
/// </summary>

unit View.Genres;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Aurelius.Bind.Dataset, Aurelius.Engine.ObjectManager, Aurelius.Bind.BaseDataset;

type
  TGenresForm = class(TForm)
    DBGrid1: TDBGrid;
    adsGenres: TAureliusDataset;
    dsGenres: TDataSource;
    adsGenresId: TIntegerField;
    adsGenresName: TStringField;
    DBNavigator1: TDBNavigator;
  private
    FOwnsManager: Boolean;
  public
    /// <summary>
    /// 显示曲风编辑浏览窗体。
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

{ TViewGenres }

destructor TGenresForm.Destroy;
begin
  adsGenres.Close;
  if FOwnsManager then
    adsGenres.Manager.Free;

  inherited;
end;

class procedure TGenresForm.Display(AManager: TObjectManager; AOwnsManager: Boolean);
var
  Form: TGenresForm;
begin
  Form := TGenresForm.Create(Application);
  try
    Form.FOwnsManager := AOwnsManager;
    Form.adsGenres.Manager := AManager;
    Form.adsGenres.SetSourceCriteria(AManager.Find<TGenre>.OrderBy('Name'));
    Form.adsGenres.Open;
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

end.
