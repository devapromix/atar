unit Trollhunter.Creature.Pattern;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TCreaturePattern = class(TObject)
  private
    FId: string;
    FLevel: Integer;
    FDecor: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: string read FId write FId;
    property Level: Integer read FLevel write FLevel;
    property Decor: string read FDecor write FDecor;
  end;

type
  TCreaturePatterns = class(TObject)
  private
    FPatterns: TObjectList<TCreaturePattern>;
    procedure Serialize;
    procedure Deserialize;
  public
    constructor Create;
    destructor Destroy; override;
    property Patterns: TObjectList<TCreaturePattern> read FPatterns
      write FPatterns;
    function GetPattern(const AIndex: Integer = -1): TCreaturePattern;
  end;

var
  CreaturePatterns: TCreaturePatterns;

implementation

uses
  System.SysUtils,
  System.JSON,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON,
  Trollhunter.Utils,
  Trollhunter.Log,
  Trollhunter.Lang,
  Trollhunter.Error,
  Trollhunter.MainForm,
  Trollhunter.Zip,
  Trollhunter.Map,
  Trollhunter.Creatures,
  Trollhunter.Creature;

{ TCreaturePattern }

constructor TCreaturePattern.Create;
begin

end;

destructor TCreaturePattern.Destroy;
begin

  inherited;
end;

{ TCreaturePatterns }

constructor TCreaturePatterns.Create;
begin
  FPatterns := TObjectList<TCreaturePattern>.Create;
end;

destructor TCreaturePatterns.Destroy;
begin
  FreeAndNil(FPatterns);
  inherited;
end;

function TCreaturePatterns.GetPattern(const AIndex: Integer = -1)
  : TCreaturePattern;
begin
  if AIndex > -1 then
    Result := Patterns[AIndex]
  else
    Result := Patterns[Trollhunter.Creatures.Creatures.PC.Dungeon]
end;

procedure TCreaturePatterns.Serialize;
var
  LStringList: TStringList;
  LJSON: TJSONValue;
  LCreaturePattern: TCreaturePattern;
  I: Integer;
begin
  Patterns.Clear;
  for I := 0 to CreaturesCount - 1 do
  begin
    LCreaturePattern := TCreaturePattern.Create;
    LCreaturePattern.Id := DungeonCreatures[I].Id;
    LCreaturePattern.Level := DungeonCreatures[I].Level;
    LCreaturePattern.Decor := DungeonCreatures[I].Decor;
    Patterns.Add(LCreaturePattern);
  end;
  LStringList := TStringList.Create;
  LStringList.WriteBOM := False;
  try
    LJSON := TNeon.ObjectToJSON(CreaturePatterns);
    try
      LStringList.Text := TNeon.Print(LJSON, True);
      LStringList.SaveToFile(Path + 'creatures.json', TEncoding.UTF8);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
  end;
end;

procedure NextSerialize;
var
  LStringList: TStringList;
  LJSON: TJSONValue;
begin
  LStringList := TStringList.Create;
  LStringList.WriteBOM := False;
  try
    LJSON := TNeon.ObjectToJSON(CreaturePatterns);
    try
      LStringList.Text := TNeon.Print(LJSON, True);
      LStringList.SaveToFile(Path + 'crpats.json', TEncoding.UTF8);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
  end;
end;

procedure TCreaturePatterns.Deserialize;
var
  LStringList: TStringList;
  LJSON: TJSONValue;
  LConfig: INeonConfiguration;
  LZip: TZip;
begin
  LStringList := TStringList.Create;
  LStringList.WriteBOM := False;
  LZip := TZip.Create(MainForm);
  try
    LStringList.Text := LZip.ExtractTextFromFile(Path + 'resources.res',
      'creatures.json');
    LJSON := TJSONObject.ParseJSONValue(LStringList.Text);
    try
      LConfig := TNeonConfiguration.Default;
      TNeon.JSONToObject(CreaturePatterns, LJSON, LConfig);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
    LZip.Free;
  end;
end;

initialization

CreaturePatterns := TCreaturePatterns.Create;
CreaturePatterns.Serialize;
// CreaturePatterns.Patterns.Clear;
// CreaturePatterns.Deserialize;
// NextSerialize;

finalization

FreeAndNil(CreaturePatterns);

end.
