unit uSceneStatistics;

interface

uses Classes, Graphics, uScene, uScenes, uSceneBaseGame;

type
  TSceneStatistics = class(TSceneBaseGame)
  private
    Y: Integer;
    procedure Add; overload;
    procedure Add(S, P: string); overload;
    procedure Add(S: string; P: Integer); overload;
  public
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    constructor Create;
    destructor Destroy; override;
  end;

var
  SceneStatistics: TSceneStatistics;

implementation

{ TSceneStatistics }

uses SysUtils, uGraph, uColor, uBox, uError;

procedure TSceneStatistics.Add(S, P: string);
begin
  with Graph.Surface.Canvas do
  begin
    if (S <> '') then
      TextOut(Graph.CharWidth * 3, Y * Graph.CharHeight, S + ':');
    TextOut(Graph.CharWidth * 20, Y * Graph.CharHeight, P);
    Inc(Y);
  end;
end;

procedure TSceneStatistics.Add;
begin
  Add('', '');
end;

procedure TSceneStatistics.Add(S: string; P: Integer);
begin
  Add(S, IntToStr(P));
end;

constructor TSceneStatistics.Create;
begin
  inherited Create(301);
end;

destructor TSceneStatistics.Destroy;
begin

  inherited;
end;

procedure TSceneStatistics.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TSceneStatistics.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSceneStatistics.Render;
begin
  inherited;
  Y := 2;
  try
    with Graph.Surface.Canvas do
    begin
      Font.Color := cRdYellow;
    end;

    Graph.Render;
  except
    on E: Exception do
      Error.Add('SceneStatistics.Render', E.Message);
  end;
end;

initialization

SceneStatistics := TSceneStatistics.Create;

finalization

SceneStatistics.Free;

end.
