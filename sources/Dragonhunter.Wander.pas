unit Dragonhunter.Wander;

interface

uses
  System.Types;

type
  TWander = class(TObject)
  public
  var
    WanderMode: Boolean;
  private
    FTarget: TPoint;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    procedure Finish(const IsClear: Boolean = False);
    procedure Process;
    property Target: TPoint read FTarget write FTarget;
    function IsFound: Boolean;
    procedure Render;
  end;

var
  Wander: TWander;

implementation

{ TWander }

uses
  System.Math,
  Vcl.Graphics,
  Trollhunter.Utils,
  Trollhunter.Graph,
  Trollhunter.Creatures,
  Dragonhunter.Terminal,
  Dragonhunter.AStar,
  Trollhunter.Map,
  Dragonhunter.Item, Trollhunter.Color;

function IsFreeCell(AX, AY: Integer): Boolean; stdcall;
begin
  Result := Creatures.PC.FreeCell(AX, AY);
end;

constructor TWander.Create;
begin
  WanderMode := False;
end;

destructor TWander.Destroy;
begin

  inherited;
end;

procedure TWander.Finish(const IsClear: Boolean = False);
begin
  WanderMode := False;
  if IsClear then
  begin
    FTarget.X := 0;
    FTarget.Y := 0;
  end;
end;

procedure TWander.Process;
var
  NX, NY: Integer;
begin
  NX := 0;
  NY := 0;
  if not DoAStar(Map.Width, Map.Height, Creatures.PC.Pos.X, Creatures.PC.Pos.Y,
    FTarget.X, FTarget.Y, @IsFreeCell, NX, NY) then
    Exit;
  if (NX <= 0) and (NY <= 0) or IsFound then
  begin
    Finish;
    Exit;
  end;
  Creatures.PC.SetPosition(NX, NY);
end;

procedure TWander.Render;
var
  X, Y, DX, DY: Integer;
begin
  with Graph.Surface.Canvas do
  begin
    for X := Trollhunter.Creatures.Creatures.PC.Pos.X -
      Graph.RW to Trollhunter.Creatures.Creatures.PC.Pos.X + Graph.RW do
      for Y := Trollhunter.Creatures.Creatures.PC.Pos.Y -
        Graph.RH to Trollhunter.Creatures.Creatures.PC.Pos.Y + Graph.RH do
      begin
        if (X < 0) or (Y < 0) or (X > MapSide - 1) or (Y > MapSide - 1) then
          Continue;
        if ((Wander.Target.X <> 0) and (Wander.Target.Y <> 0)) then
          if ((Wander.Target.X = X) and (Wander.Target.Y = Y)) then
          begin
            DX := (X - (Trollhunter.Creatures.Creatures.PC.Pos.X - Graph.RW))
              * TileSize;
            DY := (Y - (Trollhunter.Creatures.Creatures.PC.Pos.Y - Graph.RH)) *
              TileSize + Graph.CharHeight;
            Brush.Style := bsClear;
            Pen.Color := cLtYellow;
            Rectangle(DX, DY, DX + TileSize, DY + TileSize);
          end;
      end;
  end;

end;

function TWander.IsFound: Boolean;
var
  X, Y, I: Integer;
begin
  Result := False;
  with Creatures.PC do
  begin
    for X := Pos.X - GetRadius to Pos.X + GetRadius do
      for Y := Pos.Y - GetRadius to Pos.Y + GetRadius do
      begin
        if (X < 0) or (Y < 0) or (X > MapSide - 1) or (Y > MapSide - 1) then
          Continue;
        if (GetDist(Pos.X, Pos.Y, X, Y) > GetRadius - 1) then
          Continue;
        for I := High(Items.Item) downto 0 do
          if (X = Items.Item[I].Pos.X) and (Y = Items.Item[I].Pos.Y) then
          begin
            FTarget := Items.Item[I].Pos;
            Exit(True);
          end;
      end;
  end;
end;

procedure TWander.Start;
begin
  WanderMode := True;
  FTarget.X := 0;
  FTarget.Y := 0;
  while not Creatures.PC.FreeCell(FTarget.X, FTarget.Y) do
  begin
    FTarget.X := RandomRange(0, MapSide - 1);
    FTarget.Y := RandomRange(0, MapSide - 1);
  end;
end;

initialization

Wander := TWander.Create;

finalization

Wander.Free;

end.
