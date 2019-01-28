/// <summary>
///  SQL¸ú×Ù´°Ìå
/// </summary>

unit SqlMonitor;

interface

uses
  Generics.Collections, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Aurelius.Mapping.Explorer, Aurelius.Events.Manager;

type
  TSqlMonitorForm = class(TForm)
    BevelBottom: TBevel;
    Memo: TMemo;
    PanelBottom: TPanel;
    btClear: TButton;
    cbEnable: TCheckBox;
    procedure btClearClick(Sender: TObject);
    procedure cbEnableClick(Sender: TObject);
  private
    class var
      FInstance: TSqlMonitorForm;
  private
    FSqlExecutingProc: TSQLExecutingProc;
    procedure SqlExecutingHandler(Args: TSQLExecutingArgs);
  private
    procedure Log(const S: string);
    procedure BreakLine;
    procedure SubscribeListeners;
    procedure UnsubscribeListeners;
  public
    /// <summary>
    /// µ¥Àý£º·µ»ØSQL¸ú×Ù´°ÌåÊµÀý
    /// </summary>
    class function GetInstance: TSqlMonitorForm;

    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Global.Utils;

{$R *.dfm}

class function TSqlMonitorForm.GetInstance: TSqlMonitorForm;
begin
  if FInstance = nil then
    FInstance := TSqlMonitorForm.Create(Application);
  Result := FInstance;
end;

constructor TSqlMonitorForm.Create(AOwner: TComponent);
begin
  inherited;
  FSqlExecutingProc := SqlExecutingHandler;
  SubscribeListeners;
end;

procedure TSqlMonitorForm.SubscribeListeners;
var
  E: TManagerEvents;
begin
  E := TMappingExplorer.Default.Events;
  E.OnSQLExecuting.Subscribe(FSqlExecutingProc);
end;

procedure TSqlMonitorForm.SqlExecutingHandler(Args: TSQLExecutingArgs);
var
  Param: TDBParam;
begin
  Log(Args.SQL);

  if Assigned(Args.Params) then
  begin
    for Param in Args.Params do
      Log(Param.ToString);
  end;

  BreakLine;
end;

procedure TSqlMonitorForm.Log(const S: string);
begin
  Memo.Lines.Add(S);
end;

procedure TSqlMonitorForm.BreakLine;
begin
  Memo.Lines.Add('================================================');
end;

procedure TSqlMonitorForm.btClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TSqlMonitorForm.cbEnableClick(Sender: TObject);
begin
  if cbEnable.Checked then
    SubscribeListeners
  else
    UnsubscribeListeners;
end;

procedure TSqlMonitorForm.UnsubscribeListeners;
var
  E: TManagerEvents;
begin
  E := TMappingExplorer.Default.Events;
  E.OnSqlExecuting.Unsubscribe(FSqlExecutingProc);
end;

end.
