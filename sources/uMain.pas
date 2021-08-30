unit uMain;

interface                           

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, ExtCtrls;

type       
  TfMain = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);        
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    Procedure WindowMessage(Var Msg:TMessage); message WM_SYSCOMMAND;
    Procedure MouseClick(var Msg:TMessage); message WM_USER + 1;
  public
    { Public declarations }
    procedure ActionIcon(n:Integer;Icon:TIcon);
    Procedure OnMinimizeProc(Sender:TObject);
  end;

var
  fMain: TfMain;     

implementation

uses Types, uScenes, uCreatures, uGraph, uSceneMenu, uMap, uUtils, uBox,
  uScreenshot, uGame, uSceneLevelUp, uLostMemory;

{$R *.dfm}  
                               
procedure TfMain.FormCreate(Sender: TObject);
begin
  Application.OnMinimize := OnMinimizeProc;
  Graph := TGraph.Create(GetParams.X, GetParams.Y, GetParamFontSize, Canvas);
  Scenes.Scene := SceneMenu;
end;

procedure TfMain.FormPaint(Sender: TObject);   
begin
  Scenes.Render;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Scenes.KeyDown(Key, Shift);
end;
                                                                                   
procedure TfMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Scenes.KeyPress(Key);
end;      

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Graph.Free;
  Game.Save;   
end;

procedure TfMain.ActionIcon(n: Integer; Icon: TIcon);
var
  Nim: TNotifyIconData;
begin
  with Nim do    
  begin
    cbSize := System.SizeOf(Nim);
    Wnd := fMain.Handle;
    uID := 1;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    hicon := Icon.Handle;
    uCallbackMessage := wm_user + 1;
    szTip := 'AtarRL';
  end;
  case n of
    1: Shell_NotifyIcon(Nim_Add,@Nim);
    2: Shell_NotifyIcon(Nim_Delete,@Nim);
    3: Shell_NotifyIcon(Nim_Modify,@Nim);
  end;
end;

procedure TfMain.MouseClick(var Msg: TMessage);
var
  P: TPoint;
begin
  GetCursorPos(P);
  case Msg.LParam of
    WM_RBUTTONUP:
    begin
      //SetForegroundWindow(Handle); 
      //PopupMenu1.Popup(P.X, P.Y); 
      PostMessage(Handle, WM_NULL, 0, 0);
    end;
    WM_LBUTTONUP, WM_LBUTTONDBLCLK:
    begin
      ActionIcon (2, Application.Icon);
      ShowWindow(Handle, SW_SHOWNORMAL);
      ShowWindow(Application.Handle, SW_SHOWNORMAL);
      SetForegroundWindow(Handle);
    end;  
  end;
end;

procedure TfMain.OnMinimizeProc(Sender: TObject);
begin
  PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TfMain.WindowMessage(var Msg: TMessage);
begin
  if Msg.WParam = SC_MINIMIZE then
  begin
    ActionIcon (1, Application.Icon);
    ShowWindow(Handle, SW_HIDE);
    ShowWindow(Application.Handle, SW_HIDE);
  end else inherited;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not ParamDebug then 
    CanClose := (Scenes.Scene = SceneMenu);
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  if (Scenes.Scene = SceneMenu) then Scenes.Render;
end;

end.
