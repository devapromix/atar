﻿unit Trollhunter.Town;

interface

const
  TownsAmount = 25;

type
  TTown = class(TObject)
  private
    FName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    procedure Gen;
  end;

type
  TTowns = class(TObject)
  private
    FTown: array [0 .. TownsAmount - 1] of TTown;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Save;
    procedure Load;
    procedure Gen;
  end;

implementation

uses
  SysUtils,
  Classes,
  Dialogs,
  Trollhunter.Error;

{ TTown }

constructor TTown.Create;
begin
  FName := '';
end;

destructor TTown.Destroy;
begin

  inherited;
end;

procedure TTown.Gen;
var
  S: array [0 .. 1] of TStringList;
  I: Integer;
begin
  // Name
  for I := 0 to 1 do
    S[I] := TStringList.Create;
  S[0].DelimitedText :=
    '"Abs","Angb","Vorg","Adv","Afon","Agr","Ast","As","S","Abn","Adst",' +
    '"Shind","Kenosh","Sam","Semor","Timor","Turm","Ketin","Dun","Kem",' +
    '"Lum","Lon","Lim","Kid","Til","Bin","Cog","Dez","Erav","Fah","Foz",' +
    '"Fin","Fern","Jam","Hen","Holm","Kor","Lan","Modr","Nurg","Orm","Ont",' +
    '"Om","Od","Olm","Org","Omid","Ot","Osirn","Odir","Ohus","Omar","Ovuk",' +
    '"Pax","Pir","Pard","Rim","Sen","Son","Sim","Sar","Tud","Ur","Vox","Wan",' +
    '"Wur","Wil","Wex","Wart","Xuum","Xod","Xir","Xef","Xorm","Xaad","Xis",' +
    '"Xan","Xeen","Yin","Yam","Zer","Zom","Zon","Zak","Zot","Zalm","Zarn"';
  S[1].DelimitedText :=
    '"and","ant","ar","ard","end","elm","ond","om","or","old","ord","on",' +
    '"an","ont","ort","urd","emor","im","arun","arum","ang","ern","erl","ir"';
  try
    Name := '';
    for I := 0 to 1 do
    begin
      Name := Name + S[I][Random(S[I].Count - 1)];
      S[I].Free;
    end;

  except
    on E: Exception do
      Error.Add('Town.Gen', E.Message);
  end;
end;

{ TTowns }

procedure TTowns.Clear;
var
  I: Integer;
begin
  for I := 0 to TownsAmount - 1 do
  begin
    FTown[I].Name := '';
  end;
end;

constructor TTowns.Create;
var
  I: Integer;
begin
  for I := 0 to TownsAmount - 1 do
    FTown[I] := TTown.Create;
end;

destructor TTowns.Destroy;
var
  I: Integer;
begin
  for I := 0 to TownsAmount - 1 do
    FTown[I].Free;
  inherited;
end;

procedure TTowns.Gen;
var
  I: Integer;

  function HasName(const AName: string): Boolean;
  var
    J: Integer;
  begin
    Result := False;
    for J := 0 to I - 1 do
      if FTown[J].Name = AName then
      begin
        Result := True;
        Break;
      end;
  end;

begin
  try
    for I := 0 to TownsAmount - 1 do
      repeat
        FTown[I].Gen;
      until not HasName(FTown[I].Name);

    //
    { N := '';
      for I := 0 to TownsAmount - 1 do
      N := N + ' ' + FTown[I].Name;
      ShowMessage(N); }

  except
    on E: Exception do
      Error.Add('Towns.Gen', E.Message);
  end;
end;

procedure TTowns.Load;
begin

end;

procedure TTowns.Save;
begin

end;

end.
