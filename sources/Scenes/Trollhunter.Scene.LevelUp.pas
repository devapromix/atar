﻿unit Trollhunter.Scene.LevelUp;

interface

uses
  Classes,
  Trollhunter.Scene,
  Trollhunter.Scene.BaseGame;

type
  TSceneLevelUp = class(TSceneBaseGame)
  private
    FCount: Integer;
    FWidth: Integer;
    FCursorPos: Integer;
    FSelCursorPos: Integer;
    procedure AtrItem(I: Integer; S: string);
    function PossibleImproveAttribute: Boolean;
  public
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    constructor Create;
    destructor Destroy; override;
  end;

var
  SceneLevelUp: TSceneLevelUp;

implementation

uses
  Graphics,
  SysUtils,
  System.StrUtils,
  Trollhunter.Graph,
  Trollhunter.Creatures,
  Trollhunter.Scenes,
  Trollhunter.Scene.Game,
  Trollhunter.Color,
  Trollhunter.Error,
  Trollhunter.Log,
  Trollhunter.Lang,
  Trollhunter.Utils;

{ TSceneLevelUp }

function TSceneLevelUp.PossibleImproveAttribute: Boolean;
begin
  Result := False;
end;

constructor TSceneLevelUp.Create;
begin
  inherited Create(4);
  FCursorPos := 0;
  FCount := 4;
end;

procedure TSceneLevelUp.AtrItem(I: Integer; S: string);
var
  LStr: string;
begin
  LStr := IfThen(PossibleImproveAttribute, '+ 1');
  try
    with Graph.Surface.Canvas do
    begin
      case I of
        0:
          S := S + #32 + IntToStr(Creatures.PC.Prop.Strength);
        1:
          S := S + #32 + IntToStr(Creatures.PC.Prop.Dexterity);
        2:
          S := S + #32 + IntToStr(Creatures.PC.Prop.Intelligence);
        3:
          S := S + #32 + IntToStr(Creatures.PC.Prop.Speed);
      end;
      if (FCursorPos = FSelCursorPos) then
      begin
        Font.Color := cAcColor;
        Font.Style := [fsBold];
        Graph.RenderMenuLine(FSelCursorPos + 1, FWidth, False, 50, cDkGray);
      end
      else
      begin
        Font.Color := cBgColor;
        Font.Style := [];
      end;
      TextOut((Graph.Width div 2) - (TextWidth(S) div 2),
        (FSelCursorPos * Graph.CharHeight) + FWidth + Graph.CharHeight, S);
      Font.Color := cLtBlue;
      if (FSelCursorPos = FCursorPos) then
        TextOut((Graph.Width div 2) - (TextWidth(S) div 2) +
          ((Length(S) + 1) * Graph.CharWidth),
          (FSelCursorPos * Graph.CharHeight) + FWidth + Graph.CharHeight, LStr);
      Inc(FSelCursorPos);
    end;
  except
    on E: Exception do
      Error.Add('SceneLevelUp.AtrItem', E.Message);
  end;
end;

destructor TSceneLevelUp.Destroy;
begin

  inherited;
end;

procedure TSceneLevelUp.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  try
    case Key of
      38, 40:
        begin
          FCursorPos := FCursorPos + (Key - 39);
          FCursorPos := ClampCycle(FCursorPos, 0, FCount - 1);
          Render;
        end;
      13:
        if PossibleImproveAttribute then
          with Creatures.PC do
          begin
            case FCursorPos of
              0:
                AddStrength;
              1:
                AddDexterity;
              2:
                AddIntelligence;
              3:
                AddSpeed;
            end;
            Calc;
            Log.Apply;
            Scenes.Scene := SceneGame;
          end;
    end;
  except
    on E: Exception do
      Error.Add('SceneLevelUp.KeyDown (#' + IntToStr(Key) + ')', E.Message);
  end;
end;

procedure TSceneLevelUp.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSceneLevelUp.Render;
var
  LIndex: Integer;
begin
  inherited;
  try
    FSelCursorPos := 0;
    FWidth := (Graph.Height div 2) - (FCount * Graph.CharHeight div 2);
    with Graph.Surface.Canvas do
    begin
      for LIndex := 0 to FCount - 1 do
        AtrItem(LIndex, GetLang(LIndex + 15));
      FWidth := FWidth div Graph.CharHeight;
      Font.Style := [];
      Font.Color := cBgColor;
      Graph.Text.TextCenter(FWidth - 3, GetLang(60));
      Graph.Text.TextCenter(FWidth - 2, GetLang(62));
      Graph.Text.TextCenter(FWidth - 1, GetLang(63));
      Font.Style := [];
    end;
    Graph.Render;
  except
    on E: Exception do
      Error.Add('SceneLevelUp.Render', E.Message);
  end;
end;

initialization

SceneLevelUp := TSceneLevelUp.Create;

finalization

SceneLevelUp.Free;

end.
