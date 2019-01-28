unit AuditLogViewer;

interface

uses
  Generics.Collections, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Aurelius.Mapping.Explorer, Aurelius.Events.Manager;

type
  TAuditLogForm = class(TForm)
    BevelBottom: TBevel;
    Memo: TMemo;
    PanelBottom: TPanel;
    btClear: TButton;
    cbEnable: TCheckBox;
    procedure btClearClick(Sender: TObject);
    procedure cbEnableClick(Sender: TObject);
  private
    class var
      FInstance: TAuditLogForm;
  private
    FInsertedProc: TInsertedProc;
    FDeletedProc: TDeletedProc;
    FUpdatedProc: TUpdatedProc;
    FCollectionItemAddedProc: TCollectionItemAddedProc;
    FCollectionItemRemovedProc: TCollectionItemRemovedProc;
    procedure InsertedHandler(Args: TInsertedArgs);
    procedure DeletedHandler(Args: TDeletedArgs);
    procedure UpdatedHandler(Args: TUpdatedArgs);
    procedure CollectionItemAddedHandler(Args: TCollectionItemAddedArgs);
    procedure CollectionItemRemovedHandler(Args: TCollectionItemRemovedArgs);
  private
    procedure Log(const S: string);
    procedure BreakLine;
    function EntityDesc(Entity: TObject; Manager: TObject): string;
    procedure SubscribeListeners;
    procedure UnsubscribeListeners;
  public
    class function GetInstance: TAuditLogForm;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Aurelius.Engine.ObjectManager, Aurelius.Global.Utils;

{$R *.dfm}

procedure TAuditLogForm.BreakLine;
begin
  Memo.Lines.Add('================================================');
end;

procedure TAuditLogForm.btClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TAuditLogForm.cbEnableClick(Sender: TObject);
begin
  if cbEnable.Checked then
    SubscribeListeners
  else
    UnsubscribeListeners;
end;

procedure TAuditLogForm.CollectionItemAddedHandler(Args: TCollectionItemAddedArgs);
begin
  Log(Format('Collection Item %s added to %s.%s',
    [EntityDesc(Args.Item, Args.Manager),
     EntityDesc(Args.Parent, Args.Manager),
     Args.MemberName]));
end;

procedure TAuditLogForm.CollectionItemRemovedHandler(Args: TCollectionItemRemovedArgs);
begin
  Log(Format('Collection Item %s removed from %s.%s',
    [EntityDesc(Args.Item, Args.Manager),
     EntityDesc(Args.Parent, Args.Manager),
     Args.MemberName]));
end;

constructor TAuditLogForm.Create(AOwner: TComponent);
begin
  inherited;
  FInsertedProc := InsertedHandler;
  FDeletedProc := DeletedHandler;
  FUpdatedProc := UpdatedHandler;
  FCollectionItemAddedProc := CollectionItemAddedHandler;
  FCollectionItemRemovedProc := CollectionItemRemovedHandler;
  SubscribeListeners;
end;

procedure TAuditLogForm.DeletedHandler(Args: TDeletedArgs);
begin
  Log(Format('Deleted: %s', [EntityDesc(Args.Entity, Args.Manager)]));
  BreakLine;
end;

function TAuditLogForm.EntityDesc(Entity, Manager: TObject): string;
var
  IdValue: Variant;
  IdString: string;
begin
  IdValue :=  TObjectManager(Manager).Explorer.GetIdValue(Entity);
  IdString := TUtils.VariantToString(IdValue);
  Result := Format('%s(%s)', [Entity.ClassName, IdString]);
end;

class function TAuditLogForm.GetInstance: TAuditLogForm;
begin
  if FInstance = nil then
    FInstance := TAuditLogForm.Create(Application);
  Result := FInstance;
end;

procedure TAuditLogForm.InsertedHandler(Args: TInsertedArgs);
begin
  Log(Format('Inserted: %s', [EntityDesc(Args.Entity, Args.Manager)]));
  BreakLine;
end;

procedure TAuditLogForm.Log(const S: string);
begin
  Memo.Lines.Add(S);
end;

procedure TAuditLogForm.SubscribeListeners;
var
  E: TManagerEvents;
begin
  E := TMappingExplorer.Default.Events;
  E.OnInserted.Subscribe(FInsertedProc);
  E.OnUpdated.Subscribe(FUpdatedProc);
  E.OnDeleted.Subscribe(FDeletedProc);
  E.OnCollectionItemAdded.Subscribe(FCollectionItemAddedProc);
  E.OnCollectionItemRemoved.Subscribe(FCollectionItemRemovedProc);
end;

procedure TAuditLogForm.UnsubscribeListeners;
var
  E: TManagerEvents;
begin
  E := TMappingExplorer.Default.Events;
  E.OnInserted.Unsubscribe(FInsertedProc);
  E.OnUpdated.Unsubscribe(FUpdatedProc);
  E.OnDeleted.Unsubscribe(FDeletedProc);
  E.OnCollectionItemAdded.Unsubscribe(FCollectionItemAddedProc);
  E.OnCollectionItemRemoved.Unsubscribe(FCollectionItemRemovedProc);
end;

procedure TAuditLogForm.UpdatedHandler(Args: TUpdatedArgs);
var
  Pair: TPair<string, Variant>;
  OldValue: Variant;
begin
  Log(Format('Updated: %s', [EntityDesc(Args.Entity, Args.Manager)]));
  for Pair in Args.NewColumnValues do
    if not (Args.OldColumnValues.TryGetValue(Pair.Key, OldValue) and (OldValue = Pair.Value)) then
      Log(Format('   %s Changed from "%s" to "%s"',
        [Pair.Key, TUtils.VariantToString(OldValue), TUtils.VariantToString(Pair.Value)]));
  BreakLine;
end;

end.
