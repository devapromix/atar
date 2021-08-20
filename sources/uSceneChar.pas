unit uSceneChar;

interface

uses Classes, Graphics, uScene, uScenes, uSceneBaseGame;

type
  TSceneChar = class(TSceneBaseGame)
  private
    Y: Integer;
    function Space(C: Byte): string;
    procedure Add; overload;
    procedure Add(S, P: string); overload;
    procedure Add(B: Graphics.TBitmap; S, P: string); overload;
    procedure Add(S: string; P: Integer); overload;
    procedure Add(B: Graphics.TBitmap; S: string; P: Integer); overload;
//    procedure Calendar;
    procedure RenderSkills;
  public
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    constructor Create;
    destructor Destroy; override;
  end;

var
  SceneChar: TSceneChar;

implementation

uses SysUtils, uError, uGraph, uUtils, uSceneGame, uCreatures, uSceneInv,
  uItem, uColor, uLang, uMap, uSkill;

{ TSceneChar }

procedure TSceneChar.Add(S, P: string);
begin
  with Graph.Surface.Canvas do
  begin
    if (S <> '') then
      TextOut(Graph.CharWidth * 3, Y * Graph.CharHeight, S + ':');
    TextOut(Graph.CharWidth * 20, Y * Graph.CharHeight, P);
    Inc(Y);
  end;
end;

procedure TSceneChar.Add(S: string; P: Integer);
begin
  Add(S, IntToStr(P));
end;

procedure TSceneChar.Add;
begin
  Add('', '');
end;

procedure TSceneChar.Add(B: Graphics.TBitmap; S: string; P: Integer);
begin
  with Graph.Surface.Canvas do
    Draw(Graph.CharWidth, Y * Graph.CharHeight, B);
  Add(S, P);
end;

procedure TSceneChar.Add(B: Graphics.TBitmap; S, P: string);
begin
  with Graph.Surface.Canvas do
    Draw(Graph.CharWidth, Y * Graph.CharHeight, B);
  Add(S, P);
end;

{procedure TSceneChar.Calendar;
begin
  with Creatures.PC do
  with Graph.Surface.Canvas do
  begin
    Text.DrawOut(60, 10, 'Day: ' + IntToStr(Day));
    Text.DrawOut(60, 11, 'Week: ' + IntToStr(Week));
    Text.DrawOut(60, 12, 'Month: ' + IntToStr(Month));
    Text.DrawOut(60, 13, 'Year: ' + IntToStr(Year));
  end;
end;}

constructor TSceneChar.Create;
begin
  inherited Create(8);
end;

destructor TSceneChar.Destroy;
begin

  inherited;
end;

procedure TSceneChar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    32: Scenes.Scene := SceneInv;
  end;
end;

procedure TSceneChar.KeyPress(var Key: Char);
begin
  inherited;        

end;

procedure TSceneChar.Render;
var
  S: string;
begin
  inherited;
  Y := 2;
  try
    with Graph.Surface.Canvas do
    begin
      Font.Color := cRdYellow;
      Add(GetLang(37), Creatures.PC.Name);
      Add(GetLang(180), GetLang(Creatures.PC.Race + 182));
      Add(GetLang(30), Creatures.PC.Prop.Level);
      Add(Graph.Bars.EXP, GetLang(31), Format('%d/%d', [Creatures.PC.Prop.Exp, Creatures.PC.MaxExp(Creatures.PC.Prop.Level)]));
      Add();
      Add(GetLang(15), Creatures.PC.Prop.Strength);
      Add(GetLang(16), Creatures.PC.Prop.Dexterity);
      Add(GetLang(17), Creatures.PC.Prop.Will);
      Add(GetLang(18), Creatures.PC.Prop.Speed);
      Add();
      Add(Graph.Bars.LIFE, GetLang(22), Format('%d/%d', [Creatures.PC.Life.Cur, Creatures.PC.Life.Max]));
      Add(Graph.Bars.MANA, GetLang(23), Format('%d/%d', [Creatures.PC.Mana.Cur, Creatures.PC.Mana.Max]));
      Add();
      Add(Graph.Bars.DAMAGE, GetLang(32), Format('%d-%d', [Creatures.PC.Prop.MinDamage, Creatures.PC.Prop.MaxDamage]));
      Add(Graph.Bars.PROTECT, GetLang(33), Creatures.PC.Prop.Protect);
      Add();
      Add(GetLang(66), Creatures.PC.GetRadius);
      Add(GetLang(34), Creatures.PC.Kills);
      Add(GetLang(35), Creatures.PC.Turns);
      Add(GetLang(36), Creatures.PC.Rating);
      Add();
      // Location
      if ParamDebug then S := ' (' + IntToStr(Creatures.PC.Dungeon) + ')' else S := '';
      Add(GetLang(110), GetMapLang(Map.Info.ID) + S);
      Add();
      Draw(Graph.Surface.Width - 72, Graph.CharHeight, SceneInv.Hero);
    end;
    Graph.Text.BarOut('space', GetLang(25), False);
    RenderSkills;
//    Calendar();
    Graph.Render;
  except
    on E: Exception do Error.Add('SceneChar.Render', E.Message);
  end;
end;

procedure TSceneChar.RenderSkills;
var
  S4, X, Y: Word;
  Q: TSkillItem;
  I: Byte;
begin
  S4 := ((Graph.Surface.Width div 4) div Graph.CharWidth);
  X := 2; Y := 6;
  for I := 0 to Creatures.PC.Skill.Count do
  begin
    Q := Creatures.PC.Skill.GetSkill(I);
    Graph.Surface.Canvas.Brush.Color := cDkGray;
    Graph.Text.DrawOut(S4 * X, Y, Space(S4));
    Graph.Surface.Canvas.Font.Color := cRdYellow;
    Graph.Surface.Canvas.Brush.Color := cBlack;
    Graph.Text.DrawOut(S4 * X, Y - 1, GetLang(I + 201));
    Graph.Text.DrawOut(S4 * X + (S4 - (Length(IntToStr(Q.Level)))), Y - 1, IntToStr(Q.Level));
    Graph.Surface.Canvas.Brush.Color := cRdYellow;
    Graph.Text.DrawOut(S4 * X, Y, Space(Round(Q.Exp * S4 / SkillMaxExp)));   
    if ParamDebug and (Q.Exp > 0) then
    begin
      Graph.Surface.Canvas.Font.Color := cRdGray;
      Graph.Text.DrawOut(S4 * X, Y, IntToStr(Q.Exp));
    end;  
    Graph.Surface.Canvas.Brush.Color := cBlack;
    // Line
    Graph.Surface.Canvas.Pen.Width := 1;
    Graph.Surface.Canvas.Pen.Color := cBlack;
    Graph.Surface.Canvas.MoveTo(S4 * 3 * Graph.CharWidth - 1, Y * Graph.CharHeight);
    Graph.Surface.Canvas.LineTo(S4 * 3 * Graph.CharWidth - 1, (Y * Graph.CharHeight) + Graph.CharHeight);
    //
    Inc(X);
    if (X > 3) then
    begin
      Inc(Y, 2);
      X := 2;
    end;
  end;
end;

function TSceneChar.Space(C: Byte): string;
var
  I: Byte;
begin
  Result := ''; 
  for I := 1 to C do 
    Result := Result + #32;
end;

initialization
  SceneChar := TSceneChar.Create;

finalization
  SceneChar.Free;

end.
