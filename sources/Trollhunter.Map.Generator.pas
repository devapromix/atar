{
  BeaRLib, base map generation algorithms.
  Authors\maintainers: JustHarry\Apromix
  ***CAVES\ANTNEST ALGORITHM AUTOR - JAKOB DEBSKI***
}

unit Trollhunter.Map.Generator;

interface

type
  TBeaRLibMap = array of Char;
procedure CreateMap(X, Y, ID: Integer; var A: TBeaRLibMap; S: Integer);

const
  G_ANT_NEST = 1;

const
  G_CAVES = 2;

const
  G_VILLAGE = 3;

const
  G_LAKES = 4;

const
  G_LAKES2 = 5;

const
  G_TOWER = 6;

const
  G_HIVE = 7;

const
  G_CITY = 8;

const
  G_MOUNTAIN = 9;

const
  G_FOREST = 10;

const
  G_SWAMP = 11;

const
  G_RIFT = 12;

const
  G_TUNDRA = 13;

const
  G_BROKEN_CITY = 14;

const
  G_BROKEN_VILLAGE = 15;

const
  G_DARK_ROOMS = 16;

const
  G_DOOM_ROOMS = 17; { ! }

const
  G_DARK_CAVE = 18;

const
  G_DARK_GROTTO = 19;

const
  G_RED_ROOMS = 20;

const
  G_DARK_FOREST = 21; { ! }

const
  G_STONY_FIELD = 22;

const
  MAXID = 22;

const
  TILE_WALL = 0;

const
  TILE_FLOOR = 1;

const
  TILE_WATER = 2;

const
  TILE_TREE = 3;

const
  TILE_BUSH = 4;

const
  TILE_GRASS = 5;

const
  TILE_MOUNTAIN = 6;

const
  TILE_DOOR = 7;

const
  TILE_ROAD = 8;

const
  TILE_EMPTY = 9;

const
  TILE_OPEN_DOOR = 10;

const
  TILE_IN = 11;

const
  TILE_OUT = 12;

const
  TILE_STONE = 13;

const
  TILE_LAST = 13;

implementation

uses Windows, SysUtils;

const
  MaxX = 512 - 1;
  MaxY = 512 - 1;
  MinX = 50 - 1;
  MinY = 50 - 1;

type
  TRect = record
    X, Y, W, H: Integer;
  end;

  Tile = record
    Ch: Char;
    Color: Byte;
  end;

  StdArray = array [-100 .. MaxX + 100, -100 .. MaxY + 100] of Byte;

var
  Map: StdArray;
  MapX, MapY: Integer;

const
  tileset: array [0 .. TILE_LAST] of Tile = ((Ch: '#'; Color: 7), (Ch: '.';
    Color: 7), (Ch: '~'; Color: 1), (Ch: 'T'; Color: 10), (Ch: 't'; Color: 10),
    (Ch: ','; Color: 10), (Ch: '^'; Color: 8), (Ch: '+'; Color: 7), (Ch: '%';
    Color: 8), (Ch: ' '; Color: 0), (Ch: '-'; Color: 0), (Ch: '<'; Color: 0),
    (Ch: '>'; Color: 0), (Ch: ';'; Color: 1));

procedure Box(const BoxStrMessage: string);
begin
  MessageBox(0, PChar(BoxStrMessage), 'BeaRLibMG', MB_OK);
end;

function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Sign(X: Integer): Integer;
begin
  if X > 0 then
    Sign := 1
  else if X < 0 then
    Sign := -1
  else
    Sign := 0;
end;

function Rand(A, B: Integer): Integer;
begin
  Result := Round(Random(B - A + 1) + A);
end;

function FillRegion(AX, AY, SX, SY, Tile: Integer;
  Check: Boolean = True): Boolean;
var
  X, Y, X1, Y1, X2, Y2: Integer;
begin
  Result := False;
  X1 := AX - SX;
  Y1 := AY - SY;
  X2 := AX + SX;
  Y2 := AY + SY;
  if Check then
    for Y := Y1 - 1 to Y2 + 1 do
      for X := X1 - 1 to X2 + 1 do
        if (Map[X, Y] <> TILE_WALL) then
          Exit;
  for Y := Y1 to Y2 do
    for X := X1 to X2 do
      Map[X, Y] := Tile;
  Result := True;
end;

procedure DrawLine(X1, Y1, X2, Y2, ID: Integer);
var
  dx, dy, i, SX, SY, Check, e, X, Y: Integer;
begin
  dx := abs(X1 - X2);
  dy := abs(Y1 - Y2);
  SX := Sign(X2 - X1);
  SY := Sign(Y2 - Y1);
  X := X1;
  Y := Y1;
  Check := 0;
  if dy > dx then
  begin
    dx := dx + dy;
    dy := dx - dy;
    dx := dx - dy;
    Check := 1;
  end;
  e := 2 * dy - dx;
  for i := 0 to dx do
  begin
    Map[X, Y] := ID;
    if e >= 0 then
    begin
      if Check = 1 then
        X := X + SX
      else
        Y := Y + SY;
      e := e - 2 * dx;
    end;
    if Check = 1 then
      Y := Y + SY
    else
      X := X + SX;
    e := e + 2 * dy;
  end;
end;

function countnearby(X, Y, ID: Integer): Integer;
var
  res: Integer;
begin
  res := 0;
  if Map[X - 1, Y] = ID then
    res := res + 1;
  if Map[X + 1, Y] = ID then
    res := res + 1;
  if Map[X, Y - 1] = ID then
    res := res + 1;
  if Map[X, Y + 1] = ID then
    res := res + 1;
  if Map[X - 1, Y - 1] = ID then
    res := res + 1;
  if Map[X - 1, Y + 1] = ID then
    res := res + 1;
  if Map[X + 1, Y + 1] = ID then
    res := res + 1;
  if Map[X + 1, Y + 1] = ID then
    res := res + 1;
  countnearby := res;
end;

procedure MapClear(ID: Integer);
var
  i, J: Integer;
begin
  for i := -100 to MaxX + 100 do
    for J := -100 to MaxX + 100 do
      Map[i, J] := ID;
end;

function Dist(X1, Y1, X2, Y2: Integer): Integer;
begin
  Result := Round(sqrt(sqr(X2 - X1) + sqr(Y2 - Y1)));
end;

function FreeSpace(X1, Y1, X2, Y2: Integer): Boolean;
var
  i, J: Integer;
begin
  dec(X1);
  inc(X2);
  dec(Y1);
  inc(Y2);
  FreeSpace := True;
  for i := X1 to X2 do
    for J := Y1 to Y2 do
      if ((tileset[Map[i, J]].Ch <> '.')) then
        FreeSpace := False;
end;

function ReturnPlaceCoord(minvalue, maxvalue: Integer;
  var nx, ny, lenx, leny: Integer): Boolean;
var
  i, J, newx, newy, count: Integer;
begin
  ReturnPlaceCoord := False;
  count := 0;
  i := Random(MapX - maxvalue - 2) + 2;
  J := Random(MapY - maxvalue - 2) + 2;
  newx := Random(maxvalue - minvalue) + 1 + minvalue;
  newy := Random(maxvalue - minvalue) + 1 + minvalue;
  while not(FreeSpace(i, J, i + newx, J + newy)) do
  begin
    i := Random(MapX - maxvalue - 2) + 2;
    J := Random(MapY - maxvalue - 2) + 2;
    newx := Random(maxvalue - minvalue) + 1 + minvalue;
    newy := Random(maxvalue - minvalue) + 1 + minvalue;
    inc(count);
    if count > 100 then
      Exit;
  end;
  nx := i;
  ny := J;
  lenx := newx;
  leny := newy;
  ReturnPlaceCoord := True;
end;

function TileDoor(): Integer;
begin
  Result := TILE_DOOR;
  if (Random(15) <= 1) then
    Result := TILE_OPEN_DOOR;
end;

procedure LakesCreate(X1, Y1, X2, Y2, typ: Integer);
const
  density = 0.60;
var
  i, J: Integer;
var
  res: Integer;
var
  X, Y: Integer;
begin
  X := X2 - X1 + 1;
  Y := Y2 - Y1 + 1;
  for i := 1 to Round(X * Y * density) do
    Map[X1 + Random(X), Y1 + Random(Y)] := TILE_WALL;
  for i := X1 to X2 do
    for J := Y1 to Y2 do
    begin
      if (i = X1) or (J = X1) or (i = X2) or (J = Y2) then
      begin
        Map[i, J] := TILE_FLOOR;
        continue;
      end;
      res := countnearby(i, J, TILE_WALL);
      if (Map[i, J] = TILE_WALL) then
      begin
        if res < 4 then
          Map[i, J] := TILE_FLOOR;
      end
      else
      begin
        if res > 4 then
          Map[i, J] := TILE_WALL;
      end
    end;
  for i := X1 to X2 do
    for J := Y1 to Y2 do
      if countnearby(i, J, TILE_FLOOR) < 3 then
        Map[i, J] := TILE_WALL;
  for res := 1 to 10 do
    for i := X1 to X2 do
      for J := Y1 to Y2 do
        if (countnearby(i, J, TILE_FLOOR) >= 7) then
          Map[i, J] := TILE_FLOOR;

  for i := X1 to X2 do
    for J := Y1 to Y2 do
      if typ = 0 then
      begin
        if Map[i, J] = TILE_WALL then
          Map[i, J] := TILE_FLOOR
        else
          Map[i, J] := TILE_WATER;
      end
      else
      begin
        if Map[i, J] = TILE_WALL then
          Map[i, J] := TILE_WATER
        else
          Map[i, J] := TILE_FLOOR;
      end
end;

function GetTree(): Integer;
begin
  if (Rand(1, 2) = 1) then
    Result := TILE_TREE
  else
    Result := TILE_BUSH;
end;

procedure ForestPartDraw(X1, Y1: Integer);
var
  n, S, e, W, i, J, k: Integer;
begin
  i := X1;
  J := Y1;
  for k := 1 to 20 do
  begin
    n := Random(6);
    e := Random(6);
    S := Random(6);
    W := Random(6);
    if n = 1 then
    begin
      i := i - 1;
      if tileset[Map[i, J]].Ch <> '.' then
        Exit;
      Map[i, J] := GetTree();
    end;
    if S = 1 then
    begin
      i := i + 1;
      if tileset[Map[i, J]].Ch <> '.' then
        Exit;
      Map[i, J] := GetTree();
    end;
    if e = 1 then
    begin
      J := J + 1;
      if tileset[Map[i, J]].Ch <> '.' then
        Exit;
      Map[i, J] := GetTree();
    end;
    if W = 1 then
    begin
      J := J - 1;
      if tileset[Map[i, J]].Ch <> '.' then
        Exit;
      Map[i, J] := GetTree();
    end;
  end;
end;

procedure AddModOnMap(modtype: Integer);
var
  i, J: Integer;
begin
  case modtype of
    1:
      begin
        for i := 1 to MapX do
          for J := 1 to MapY do
            if Map[i, J] = TILE_WALL then
              if Random(100) <= 40 then
                Map[i, J] := TILE_FLOOR;

      end;
    2:
      for i := 1 to MapX * MapY div 25 do
        ForestPartDraw(Random(MapX) + 1, Random(MapY) + 1);
    3:
      for i := 1 to MapX do
        for J := 1 to MapY do
          if Random(100) <= 20 then
            Map[i, J] := TILE_WATER;
  end;

end;

procedure ForestCreate(X, Y, n: Integer);
var
  i: Integer;
begin
  for i := 1 to X * Y div n do
    ForestPartDraw(Random(X) + 1, Random(Y) + 1);
end;

procedure AntNestCreate(X1, Y1, X2, Y2, typ: Integer);
var
  i, J: Integer;
  kx, ky, k, dx, dy: real;
  X, Y, py, px: Integer;
  counter: Integer;
  buffer: StdArray;
begin
  X := X2 - X1 + 1;
  Y := Y2 - Y1 + 1;
  buffer := Map;
  // MapClear(TILE_FLOOR);
  Map[X div 2, Y div 2] := TILE_WALL;
  for i := 0 to (X * Y div 3) do
  begin
    try
      k := (Random(360) + 1) * 3.1419532 / 180;
      kx := (X / 2) + (Y / 2) * sin(k);
      ky := (Y / 2) + (Y / 2) * cos(k);
      dx := 1;
      dy := 1;
      while ((abs(dx) < 10) and (abs(dy) < 10)) do
      begin
        dx := Random(100) + 1;
        dy := Random(100) + 1;
      end;
      dx := dx - 60;
      dy := dy - 60;
      dx := dx / 30;
      dy := dy / 30;
      counter := 0;
      while (True) do
      begin
        if counter + 1 > 10000 then
          break;
        counter := counter + 1;
        kx := kx + dx;
        ky := ky + dy;
        px := Round(kx);
        py := Round(ky);
        if (px < 0) then
        begin
          px := X;
          kx := px;
        end;
        if (px > X) then
        begin
          px := 1;
          kx := px;
        end;
        if (py < 0) then
        begin
          py := Y;
          ky := py;
        end;
        if (py > Y) then
        begin
          py := 1;
          ky := py;
        end;
        if (px = 0) then
          px := Random(X) + 1;
        if (py = 0) then
          py := Random(Y) + 1;
        if ((px > 1) and (Map[px - 1, py] = TILE_WALL)) or
          ((py > 1) and (Map[px, py - 1] = TILE_WALL)) or
          ((px < X) and (Map[px + 1, py] = TILE_WALL)) or
          ((py < Y) and (Map[px, py + 1] = TILE_WALL)) then
        begin
          Map[px, py] := TILE_WALL;
          break;
        end;
      end;
    except
    end;
  end;

  for i := 1 to X do
    for J := 1 to Y do
      if Map[i, J] = TILE_WALL then
        Map[i, J] := TILE_FLOOR
      else
        Map[i, J] := TILE_WALL;

  if typ > 0 then
    for i := 2 to X - 1 do
      for J := 2 to Y - 1 do
        if countnearby(i, J, TILE_WALL) <= 3 then
          Map[i, J] := TILE_FLOOR;
  if typ = 2 then
    for i := 1 to X do
      for J := 1 to Y do
        if Map[i, J] = TILE_WALL then
          Map[i, J] := TILE_FLOOR
        else if Map[i, J] = TILE_FLOOR then
          Map[i, J] := TILE_MOUNTAIN;
  for i := X1 to X2 do
    for J := Y1 to Y2 do
      buffer[i, J] := Map[i - X1 + 1, J - Y1 + 1];
  Map := buffer;

end;

procedure RiftCreate(X, Y: Integer);
var
  i, J: Integer;
begin
  for i := 1 to X * Y div 10 do
    ForestPartDraw(Random(X) + 1, Random(Y) + 1);
  for i := 1 to X do
    for J := 1 to Y do
      if Map[i, J] = TILE_TREE then
        Map[i, J] := TILE_EMPTY
      else
        Map[i, J] := TILE_MOUNTAIN;
end;

procedure TundraCreate(X, Y: Integer);
var
  i, newx, newy, lenx, leny: Integer;
begin
  for i := 1 to X * Y div 100 do
    ForestPartDraw(Random(X) + 1, Random(Y) + 1);
  for i := 1 to X * Y div 100 do
  begin
    if not(ReturnPlaceCoord(10, 15, newx, newy, lenx, leny)) then
      continue;
    if Random(100) <= 50 then
      AntNestCreate(newx, newy, newx + lenx, newy + leny, 2)
    else
      LakesCreate(newx, newy, newx + lenx, newy + leny, 1);
  end;
end;

procedure DrawRoom(X1, Y1, X2, Y2: Integer);
var
  i, X, Y, k: Integer;
  gh: Boolean;
begin
  for i := X1 to X2 do
  begin
    if Map[i, Y1] <> TILE_DOOR then
      Map[i, Y1] := TILE_WALL;
    if Map[i, Y2] <> TILE_DOOR then
      Map[i, Y2] := TILE_WALL;
  end;
  for i := Y1 to Y2 do
  begin
    if Map[X1, i] <> TILE_DOOR then
      Map[X1, i] := TILE_WALL;
    if Map[X2, i] <> TILE_DOOR then
      Map[X2, i] := TILE_WALL;
  end;
  for i := 1 to 30 do
    while True do
    begin
      gh := False;
      X := Random(X2 - X1 - 1) + 1 + i - i;
      Y := Random(Y2 - Y1 - 1) + 1;
      k := Random(5);
      if k = 0 then
        if countnearby(X1 + X, Y1, TILE_DOOR) = 0 then
          if Map[X1 + X, Y1] <> TILE_DOOR then
          begin
            Map[X1 + X, Y1] := TileDoor();
            gh := True;
          end;
      if k = 1 then
        if Map[X1, Y + Y1] <> TILE_DOOR then
          if countnearby(X1, Y1 + Y, TILE_DOOR) = 0 then
          begin
            Map[X1, Y1 + Y] := TileDoor();
            gh := True;
          end;
      if k = 2 then
        if Map[X2, Y1 + Y] <> TILE_DOOR then
          if countnearby(X2, Y1 + Y, TILE_DOOR) = 0 then
          begin
            Map[X2, Y1 + Y] := TileDoor();
            gh := True;
          end;
      if k = 3 then
        if Map[X1 + X, Y2] <> TILE_DOOR then
          if countnearby(X1 + X, Y2, TILE_DOOR) = 0 then
          begin
            Map[X1 + X, Y2] := TileDoor();
            gh := True;
          end;
      if gh then
        Exit;
    end;
end;

procedure CreateRoom(X1, Y1, X2, Y2: Integer; R: Integer = 0);
const
  MaxRoomValue = 3;
var
  count, J: Integer;
begin
  if (X2 - X1) < MaxRoomValue * 2 then
    Exit;
  if (Y2 - Y1) < MaxRoomValue * 2 then
    Exit;
  DrawRoom(X1, Y1, X2, Y2);
  if (R = 0) then
  begin
    J := 0;
    count := 0;
    while (J < MaxRoomValue) or (X2 - (X1 + J) < MaxRoomValue) do
    begin
      J := Random(X2 - X1) + 1;
      inc(count);
      if count > 100 then
        Exit;
    end;
    CreateRoom(X1, Y1, X1 + J, Y2, -1);
    CreateRoom(X1 + J, Y1, X2, Y2, -1);
    Exit;
  end
  else
  begin
    J := 0;
    count := 0;
    while (J < MaxRoomValue) or (Y2 - (Y1 + J) < MaxRoomValue) do
    begin
      J := Random(Y2 - Y1) + 1;
      inc(count);
      if count > 100 then
        Exit;
    end;
    CreateRoom(X1, Y1, X2, Y1 + J);
    CreateRoom(X1, Y1 + J, X2, Y2);
  end;
end;

procedure CreateHouse(X1, Y1, X2, Y2: Integer);
begin
  if (X2 - X1 + 1 <= 8) or (Y2 - Y1 + 1 <= 8) then
    DrawRoom(X1, Y1, X2, Y2)
  else
    CreateRoom(X1, Y1, X2, Y2);
end;

procedure CreateSomething(minvalue, maxvalue: Integer; flag: Boolean);
var
  i, J, count, newx, newy: Integer;
begin
  if not(ReturnPlaceCoord(minvalue, maxvalue, i, J, newx, newy)) then
    Exit;
  if flag = True then
  begin
    if Random(100) <= 25 then
      for count := 1 to 10 do
        ForestPartDraw(Random(newx) + i, Random(newy) + J)
    else if Random(100) <= 20 then
      LakesCreate(i, J, i + newx, J + newy, 1)
    else
      CreateHouse(i, J, i + newx, J + newy);
  end
  else
    CreateHouse(i, J, i + newx, J + newy);
end;

procedure VillageCreate(X, Y: Integer);
var
  i: Integer;
begin
  MapClear(TILE_FLOOR);
  ForestCreate(X, Y, 45);
  for i := 1 to 10 do
    CreateSomething(10, 15, True);
  // if typ = 1 then
  // begin
  AddModOnMap(1);
  AddModOnMap(2);

  // end;
end;

procedure TowerCreate(X, Y: Integer);
const
  waterch = 20;
var
  px, py, rad: Integer;
  k, i, J: Integer;
begin
  px := X div 2;
  py := Y div 2;
  if (Y - py) < (X - px) then
    rad := Y - py
  else
    rad := X - px;
  k := rad - 5;
  while k > 0 do
  begin
    for i := 1 to X do
      for J := 1 to Y do
        if Dist(i, J, px, py) = k then
          Map[i, J] := TILE_WALL;
    k := k - 2;
  end;
  AddModOnMap(1);
  AddModOnMap(1);
  AddModOnMap(2);
  AddModOnMap(3);
end;

procedure SwampCreate(X, Y: Integer);
var
  i, J: Integer;
  buffer: StdArray;
begin
  for i := 1 to X * Y div 1000 do
    CreateSomething(5, 10, False);
  for i := 1 to X * Y div 20 do
    ForestPartDraw(Random(X) + 1, Random(Y) + 1);
  buffer := Map;
  LakesCreate(1, 1, X, Y, 0);
  for i := 1 to X do
    for J := 1 to Y do
      if buffer[i, J] = TILE_WALL then
        Map[i, J] := TILE_WALL
      else if buffer[i, J] = TILE_TREE then
        Map[i, J] := TILE_TREE;
  AddModOnMap(1);
end;

procedure CavesCreate(X, Y: Integer);
const
  density = 0.65;
var
  i, J: Integer;
var
  res: Integer;
begin
  for i := 1 to Round(X * Y * density) do
    Map[Random(X) + 1, Random(Y) + 1] := TILE_WALL;
  for i := 1 to X do
    for J := 1 to Y do
    begin
      if (i <= 1) or (J <= 1) or (i >= X - 1) or (J >= Y - 1) then
      begin
        Map[i, J] := TILE_WALL;
        continue;
      end;
      res := countnearby(i, J, TILE_WALL);
      if (Map[i, J] = TILE_WALL) then
      begin
        if res < 4 then
          Map[i, J] := TILE_FLOOR;
      end
      else
      begin
        if res > 4 then
          Map[i, J] := TILE_WALL;
      end
    end;
  for res := 1 to 10 do
    for i := 2 to X - 1 do
      for J := 2 to Y - 1 do
        if (countnearby(i, J, TILE_FLOOR) < 3) or
          (countnearby(i, J, TILE_WALL) >= 7) then
          Map[i, J] := TILE_WALL;
end;

procedure CityCreate(X, Y, typ: Integer);
var
  px, py, resx, i, J, k: Integer;
var
  buffer: StdArray;
begin
  CreateHouse(1, 1, X div 4, Y div 4);
  px := 1;
  py := 1;
  for i := 1 to X div 4 do
    for J := 1 to Y div 4 do
    begin
      for k := 1 to 4 do
      begin
        buffer[px, py] := Map[i, J];
        py := py + 1;
        if py > Y then
        begin
          px := px + 1;
          py := 1;
        end;
      end;
    end;
  resx := 0;
  for i := 1 to X div 4 do
    for k := 1 to 4 do
    begin
      inc(resx);
      for J := 1 to Y do
        Map[resx, J] := buffer[i, J];
    end;
  for i := 1 to X do
    for J := 1 to Y do
      if (Map[i, J] = TILE_DOOR) or (Map[i, J] = TILE_WALL) then
        Map[i, J] := TILE_ROAD;
  for i := 1 to 1000 do
    CreateSomething(5, 20, False);
  if typ = 1 then
  begin
    AddModOnMap(1);
    AddModOnMap(3);
  end;

end;

// #16
procedure DarkRoomsCreate(AX, AY: Integer);
var
  i, J: Integer;
  V: array of TRect;
  RoomsCount: Integer;
  P, L: TRect;

  procedure LinkRoom(X1, Y1, X2, Y2: Integer);
  var
    B, i, L, AX, AY, LX, LY: Integer;
    R: real;
  begin
    B := 0;
    LX := 0;
    LY := 0;
    L := Max(abs(X1 - X2), abs(Y1 - Y2)) + 1;
    for i := 1 to L do
    begin
      R := i / L;
      AX := X1 + Trunc((X2 - X1) * R);
      AY := Y1 + Trunc((Y2 - Y1) * R);
      if (B = 0) and (Map[AX, AY] = TILE_WALL) then
      begin
        Map[AX, AY] := TileDoor();
        inc(B);
        continue;
      end;
      if (B = 1) and (Map[AX, AY] = TILE_FLOOR) then
      begin
        Map[LX, LY] := TileDoor();
        inc(B);
        continue;
      end;
      Map[AX, AY] := TILE_FLOOR;
      LX := AX;
      LY := AY;
    end;
  end;

begin
  MapClear(TILE_WALL);
  RoomsCount := (AX div 10) * (AY div 10);
  i := 0;
  J := 0;
  L.X := 0;
  L.Y := 0;
  SetLength(V, i + 1);
  while (J <= RoomsCount - 1) do
  begin
    P.X := Rand(2, 7);
    P.Y := Rand(2, 7);
    V[i].X := Rand(2 + P.X, AX - P.X - 3);
    V[i].Y := Rand(2 + P.Y, AY - P.Y - 3);
    if FillRegion(V[i].X, V[i].Y, P.X, P.X, TILE_FLOOR) then
    begin
      if (L.X > 0) and (L.Y > 0) then
        LinkRoom(V[i].X, V[i].Y, L.X, L.Y);
      L.X := V[i].X;
      L.Y := V[i].Y;
      inc(i);
      SetLength(V, i + 1);
    end;
    inc(J);
  end;
end;

// #17
procedure DoomRoomsCreate(AX, AY: Integer);
var
  i, L, C: Integer;
  V: array of TRect;
  X1, Y1, W1, H1, X2, Y2, W2, H2: Integer;

  procedure AddTile(X, Y: Integer);
  begin
    if (Map[X, Y] = TILE_FLOOR) then
      Exit;
    if (Map[X, Y] = TILE_WALL) then
      Map[X, Y] := TILE_FLOOR;
  end;

  procedure ClearArts();
  var
    X, Y: Integer;
  begin
    for Y := 1 to AY - 1 do
      for X := 1 to AX - 1 do
      begin
        if (Map[X, Y] = TILE_DOOR) or (Map[X, Y] = TILE_OPEN_DOOR) then
          if (((Map[X - 1, Y] = TILE_WALL) and (Map[X + 1, Y] = TILE_WALL) and
            (Map[X, Y - 1] = TILE_FLOOR) and (Map[X, Y + 1] = TILE_FLOOR)) or
            ((Map[X, Y - 1] = TILE_WALL) and (Map[X, Y + 1] = TILE_WALL)) and
            (Map[X - 1, Y] = TILE_FLOOR) and (Map[X + 1, Y] = TILE_FLOOR)) then
            continue
          else
            Map[X, Y] := TILE_FLOOR;
      end;
    for Y := 1 to AY - 1 do
      for X := 1 to AX - 1 do
        if (Map[X, Y] = TILE_FLOOR) then
        begin
          if ((Map[X - 1, Y] = TILE_WALL) and (Map[X + 1, Y] = TILE_WALL) and
            (Map[X, Y + 1] = TILE_WALL)) then
            Map[X, Y] := TILE_WALL;
          if ((Map[X - 1, Y] = TILE_WALL) and (Map[X + 1, Y] = TILE_WALL) and
            (Map[X, Y - 1] = TILE_WALL)) then
            Map[X, Y] := TILE_WALL;
          if ((Map[X, Y - 1] = TILE_WALL) and (Map[X, Y + 1] = TILE_WALL) and
            (Map[X + 1, Y] = TILE_WALL)) then
            Map[X, Y] := TILE_WALL;
          if ((Map[X, Y - 1] = TILE_WALL) and (Map[X, Y + 1] = TILE_WALL) and
            (Map[X - 1, Y] = TILE_WALL)) then
            Map[X, Y] := TILE_WALL;
        end;
  end;

  function AddRooms(X1, Y1, W1, H1, TILE_FLOOR: Integer): Boolean;
  begin
    Result := FillRegion(X1, Y1, W1, H1, TILE_FLOOR);
    if Result and (Rand(1, 1) = 1) and (W1 > 4) and (H1 > 4) then
    begin
      SetLength(V, L + 1);
      V[L].X := X1;
      V[L].Y := Y1;
      V[L].W := W1;
      V[L].H := H1;
      inc(L);
    end;
  end;

  procedure AddInRoom(i: Integer);
  begin
    case Rand(1, 2) of
      // 1: CreateSomething(4, 20, False);
      2:
        DrawRoom(V[i].X - Rand(2, 4), V[i].Y - Rand(2, 4), V[i].X + Rand(2, 4),
          V[i].Y + Rand(2, 4));
    end;
  end;

  procedure LinkRooms(X1, Y1, W1, H1, X2, Y2, W2, H2: Integer);
  var
    X, Y: Integer;
    A, B: Boolean;
  begin
    A := False;
    B := False;
    case Rand(0, 2) of
      1:
        A := True;
      2:
        B := True;
    else
      begin
        A := True;
        B := True;
      end;
    end;
    if A then
    begin
      { v. 1 }
      if (X1 < X2) then
      begin
        for X := X1 to X2 - W2 - 2 do
          AddTile(X, Y2);
        Map[X2 - W2 - 1, Y2] := TileDoor();
      end
      else
      begin
        for X := X2 + W2 + 2 to X1 do
          AddTile(X, Y2);
        Map[X2 + W2 + 1, Y2] := TileDoor();
      end;
      if (Y1 < Y2) then
      begin
        for Y := Y1 + H1 + 2 to Y2 do
          AddTile(X1, Y);
        Map[X1, Y1 + H1 + 1] := TileDoor();
      end
      else
      begin
        for Y := Y2 to Y1 - H1 - 2 do
          AddTile(X1, Y);
        Map[X1, Y1 - H1 - 1] := TileDoor();
      end;
    end;
    if B then
    begin
      { v. 2 }
      if (X1 < X2) then
      begin
        for X := X1 + W1 + 2 to X2 do
          AddTile(X, Y1);
        Map[X1 + W1 + 1, Y1] := TileDoor();
      end
      else
      begin
        for X := X2 to X1 - W1 - 2 do
          AddTile(X, Y1);
        Map[X1 - W1 - 1, Y1] := TileDoor();
      end;
      if (Y1 < Y2) then
      begin
        for Y := Y1 to Y2 - H2 - 2 do
          AddTile(X2, Y);
        Map[X2, Y2 - H2 - 1] := TileDoor();
      end
      else
      begin
        for Y := Y2 + H2 + 2 to Y1 do
          AddTile(X2, Y);
        Map[X2, Y2 + H2 + 1] := TileDoor();
      end;
    end;
  end;

begin
  L := 0;
  W1 := Rand(2, 9);
  H1 := Rand(2, 9);
  X1 := Rand(20, AX - 20);
  Y1 := Rand(20, AY - 20);
  MapClear(TILE_WALL);
  AddRooms(X1, Y1, W1, H1, TILE_FLOOR);
  C := (AX div 2) * (AY div 2);
  for i := 0 to C do
  begin
    W2 := Rand(2, 10);
    H2 := Rand(2, 10);
    X2 := Rand(W2 * 2 + 1, AX - (W2 * 2 + 1));
    Y2 := Rand(H2 * 2 + 1, AY - (H2 * 2 + 1));
    if (X1 = X2) then
      inc(X2, Rand(2, 3));
    if (Y1 = Y2) then
      inc(Y2, Rand(2, 3));
    if AddRooms(X2, Y2, W2, H2, TILE_FLOOR) then
    begin
      LinkRooms(X1, Y1, W1, H1, X2, Y2, W2, H2);
      X1 := X2;
      Y1 := Y2;
      W1 := W2;
      H1 := H2;
    end;
  end;
  if (L > 0) then
    for i := 0 to L - 1 do
      AddInRoom(i);

  { //
    for Y := 1 to AY - 1 do
    for X := 1 to AX - 1 do
    if (CountNearby(X, Y, TILE_WALL) <= 3) then
    Map[X, Y] := TILE_FLOOR; }

  ClearArts();
end;

// #18
procedure DarkCaveCreate(AX, AY: Integer; flag: Boolean);
type
  CellState = (csEdge, csChaos, csIn, csOut, csFloor);
  StateMapArray = array [-100 .. MaxX + 100, -100 .. MaxY + 100] of CellState;

var
  StateMap: StateMapArray;
  A, B, X, Y, i, J: Integer;
  MinX, MaxX, MinY, MaxY: Integer;

  procedure ClearStateMap;
  var
    i, J: Integer;
  begin
    for i := -100 to MaxX + 100 do
      for J := -100 to MaxX + 100 do
      begin
        if ((i <= 1) or (i >= AX)) or ((J <= 1) or (J >= AY)) then
          StateMap[i, J] := csEdge
        else
          StateMap[i, J] := csChaos;
      end;
  end;

  procedure Make(var X, Y: Integer; flag: Boolean);
  var
    i, dx, dy: Integer;
  begin
    for i := 0 to 9999 do
    begin
      dx := Rand(-1, 1);
      dy := Rand(-1, 1);
      if (MinX > 2) and (Rand(1, 3) = 1) then
        dx := -1;
      if (MaxX < AX - 1) and (Rand(1, 3) = 1) then
        dx := 1;
      if (MinY > 2) and (Rand(1, 3) = 1) then
        dy := -1;
      if (MaxY < AY - 1) and (Rand(1, 3) = 1) then
        dy := 1;
      if (StateMap[dx + X, dy + Y] = csChaos) then
      begin
        X := dx + X;
        Y := dy + Y;
        MinX := Min(X, MinX);
        MaxX := Max(X, MaxX);
        MinY := Min(Y, MinY);
        MaxY := Max(Y, MaxY);
        StateMap[X, Y] := csFloor;
        if flag and (StateMap[X + 1, Y] = csChaos) then
          StateMap[X + 1, Y] := csFloor;
        if flag and (StateMap[X, Y + 1] = csChaos) then
          StateMap[X, Y + 1] := csFloor;
      end;
    end;
  end;

begin
  repeat
    ClearStateMap;
    MinX := AX;
    MinY := AY;
    MaxX := 0;
    MaxY := 0;
    A := Rand(2, AX - 1);
    B := Rand(2, AY - 1);
    StateMap[A, B] := csIn;
    X := A;
    Y := B;
    Make(X, Y, flag);
  until ((MinX = 2) and (MinY = 2) and (MaxX = AX - 1) and (MaxY = AY - 1) and
    (A <> X) and (B <> Y));
  StateMap[X, Y] := csOut;
  // Создаем тайловую карту из StateMap
  MapClear(TILE_WALL);
  for i := -100 to MaxX + 100 do
    for J := -100 to MaxX + 100 do
      case StateMap[i, J] of
        csEdge, csChaos:
          Map[i, J] := TILE_WALL;
        csIn:
          Map[i, J] := TILE_IN;
        csOut:
          Map[i, J] := TILE_OUT;
        csFloor:
          Map[i, J] := TILE_FLOOR;
      end;
end;

// #20
procedure RedRoomsCreate(AX, AY: Integer);
var
  i: Integer;

  function InsRoom: Boolean;
  var
    X, Y, W, H: Integer;
  begin
    X := Rand(1, AX - 1);
    Y := Rand(1, AY - 1);
    W := Rand(1, 3);
    H := Rand(1, 3);
    Result := FillRegion(X, Y, W, H, TILE_FLOOR);
  end;

begin
  MapClear(TILE_WALL);
  for i := 0 to 20 do
    InsRoom;
end;

// #21
procedure DarkForestCreate(X, Y: Integer);
begin
  MapClear(TILE_FLOOR);
  ForestCreate(X, Y, 15);
end;

// #22
procedure StonyFieldCreate(X, Y: Integer);
var
  i, J: Integer;
begin
  MapClear(TILE_FLOOR);
  TundraCreate(X, Y);
  for i := 1 to X do
    for J := 1 to Y do
      if (Map[i, J] = TILE_TREE) then
      begin
        if (Rand(1, 5) = 1) then
          Map[i, J] := GetTree
        else
          Map[i, J] := TILE_STONE;
      end
      else
        Map[i, J] := TILE_FLOOR;
end;

procedure CreateMap(X, Y, ID: Integer; var A: TBeaRLibMap; S: Integer);
var
  i, J: Integer;
begin
  if ((ID <= 0) or (ID > MAXID) or (X < MinX) or (Y < MinY) or (X > MaxX) or
    (Y > MaxY)) then
    Exit;
  MapClear(TILE_FLOOR);
  MapX := X;
  MapY := Y;
  Randomize;
  case ID of
    G_ANT_NEST:
      AntNestCreate(1, 1, X, Y, 0);
    G_CAVES:
      CavesCreate(X, Y);
    G_LAKES:
      LakesCreate(1, 1, X, Y, 0);
    G_LAKES2:
      LakesCreate(1, 1, X, Y, 1);
    G_TOWER:
      TowerCreate(X, Y);
    G_HIVE:
      AntNestCreate(1, 1, X, Y, 1);
    G_CITY:
      CityCreate(X, Y, 0);
    G_MOUNTAIN:
      AntNestCreate(1, 1, X, Y, 2);
    G_FOREST:
      ForestCreate(X, Y, 30);
    G_VILLAGE:
      VillageCreate(X, Y);
    G_SWAMP:
      SwampCreate(X, Y);
    G_RIFT:
      RiftCreate(X, Y);
    G_TUNDRA:
      TundraCreate(X, Y);
    G_BROKEN_CITY:
      CityCreate(X, Y, 1);
    G_BROKEN_VILLAGE:
      VillageCreate(X, Y);
    G_DARK_ROOMS:
      DarkRoomsCreate(X, Y);
    G_DOOM_ROOMS:
      DoomRoomsCreate(X, Y);
    G_DARK_CAVE:
      DarkCaveCreate(X, Y, False);
    G_DARK_GROTTO:
      DarkCaveCreate(X, Y, True);
    G_RED_ROOMS:
      RedRoomsCreate(X, Y);
    G_DARK_FOREST:
      DarkForestCreate(X, Y);
    G_STONY_FIELD:
      StonyFieldCreate(X, Y);
  end; // case

  try
    case ID of
      G_ANT_NEST, G_CAVES, G_HIVE, G_DARK_ROOMS, G_DOOM_ROOMS:
        begin
          for i := 1 to X do
          begin
            Map[i, 1] := TILE_WALL;
            Map[i, Y] := TILE_WALL;
          end;
          for i := 1 to Y do
          begin
            Map[1, i] := TILE_WALL;
            Map[X, i] := TILE_WALL;
          end;
        end;
      G_FOREST, G_DARK_FOREST, G_VILLAGE:
        begin
          for i := 1 to X do
          begin
            Map[i, 1] := GetTree();
            Map[i, Y] := GetTree();
          end;
          for i := 1 to Y do
          begin
            Map[1, i] := GetTree();
            Map[X, i] := GetTree();
          end;
        end;
    end;
    for i := 0 to X - 1 do
      for J := 0 to Y - 1 do
        A[i * Y + J] := tileset[Map[i + 1][J + 1]].Ch;
  except
  end;
end;

end.
