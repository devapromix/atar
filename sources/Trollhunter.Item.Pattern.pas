unit Trollhunter.Item.Pattern;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TItemPattern = class(TObject)
  private
    FId: string;
    FAdvSprite: string;
    FRarity: string;
    FLevel: Integer;
    FColor: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: string read FId write FId;
    property AdvSprite: string read FAdvSprite write FAdvSprite;
    property Rarity: string read FRarity write FRarity;
    property Level: Integer read FLevel write FLevel;
    property Color: string read FColor write FColor;
  end;

type
  TItemPatterns = class(TObject)
  private
    FPatterns: TObjectList<TItemPattern>;
    procedure Deserialize;
    procedure Serialize;
  public
    constructor Create;
    destructor Destroy; override;
    property Patterns: TObjectList<TItemPattern> read FPatterns write FPatterns;
    function GetPattern(const AIndex: Integer): TItemPattern;
  end;

var
  ItemPatterns: TItemPatterns;

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
  Trollhunter.Item;

{ TMapPattern }

constructor TItemPattern.Create;
begin

end;

destructor TItemPattern.Destroy;
begin

  inherited;
end;

{ TItemPatterns }

constructor TItemPatterns.Create;
begin
  FPatterns := TObjectList<TItemPattern>.Create;
end;

procedure TItemPatterns.Deserialize;
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
      'items.json');
    LJSON := TJSONObject.ParseJSONValue(LStringList.Text);
    try
      LConfig := TNeonConfiguration.Default;
      TNeon.JSONToObject(ItemPatterns, LJSON, LConfig);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
    LZip.Free;
  end;
end;

destructor TItemPatterns.Destroy;
begin
  FreeAndNil(FPatterns);
  inherited;
end;

function TItemPatterns.GetPattern(const AIndex: Integer): TItemPattern;
begin
  Result := Patterns[AIndex];
end;

procedure TItemPatterns.Serialize;
var
  LStringList: TStringList;
  LJSON: TJSONValue;
  LItemPattern: TItemPattern;
  I: Integer;
begin
  Patterns.Clear;
  for I := 0 to ItemsCount - 1 do
  begin
    LItemPattern := TItemPattern.Create;
    LItemPattern.Id := DungeonItems[I].Sprite;
    LItemPattern.AdvSprite := DungeonItems[I].AdvSprite;
    LItemPattern.Rarity := 'NORMAL';
    LItemPattern.Level := 1;
    LItemPattern.Rarity := 'NONE';
    Patterns.Add(LItemPattern);
  end;

  LStringList := TStringList.Create;
  LStringList.WriteBOM := False;
  try
    LJSON := TNeon.ObjectToJSON(ItemPatterns);
    try
      LStringList.Text := TNeon.Print(LJSON, True);
      LStringList.SaveToFile(Path + 'items.json', TEncoding.UTF8);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
  end;
end;

initialization

ItemPatterns := TItemPatterns.Create;
ItemPatterns.Deserialize;
ItemPatterns.Serialize;

finalization

FreeAndNil(ItemPatterns);

end.
