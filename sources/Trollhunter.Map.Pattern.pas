unit Trollhunter.Map.Pattern;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TMapPat = class(TObject)
  private
    FId: string;
    FLevel: Integer;
    FItems: string;
    FCreatures: string;
    FUnderground: Boolean;
    FVillage: Boolean;
    FGenId: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: string read FId write FId;
    property Level: Integer read FLevel write FLevel;
    property Items: string read FItems write FItems;
    property Creatures: string read FCreatures write FCreatures;
    property Underground: Boolean read FUnderground write FUnderground;
    property Village: Boolean read FVillage write FVillage;
    property GenId: Integer read FGenId write FGenId;
  end;

type
  TMapPats = class(TObject)
  private
    FMapPatList: TObjectList<TMapPat>;
  public
    constructor Create;
    destructor Destroy; override;
    property MapPatList: TObjectList<TMapPat> read FMapPatList
      write FMapPatList;
    procedure LoadFromResources;
  end;

var
  MapPats: TMapPats;

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
  Trollhunter.Zip;

{ TSkill }

constructor TMapPat.Create;
begin

end;

destructor TMapPat.Destroy;
begin

  inherited;
end;

{ TMapPats }

constructor TMapPats.Create;
begin
  FMapPatList := TObjectList<TMapPat>.Create;
end;

destructor TMapPats.Destroy;
begin
  FreeAndNil(FMapPatList);
  inherited;
end;

procedure TMapPats.LoadFromResources;
var
  LStringList: TStringList;
  LZip: TZip;
  LMapPat: TMapPat;
  LJSONObject: TJSONObject;
  LMapPats: TJSONArray;
  I: Integer;
begin
  try
    if not FileExists(Path + 'resources.res') then
      Exit;
    LStringList := TStringList.Create;
    try
      LZip := TZip.Create(MainForm);
      try
        LStringList.Text := LZip.ExtractTextFromFile(Path + 'resources.res',
          'maps.json');
        LMapPats := TJSONObject.ParseJSONValue(LStringList.Text) as TJSONArray;
        try
          for I := 0 to LMapPats.Count - 1 do
          begin
            LJSONObject := LMapPats.Items[I] as TJSONObject;
            LMapPat := TMapPat.Create;
            LMapPat.Id := LJSONObject.GetValue('id').GetValue<string>;
            LMapPat.Level := LJSONObject.GetValue('level').GetValue<Integer>;
            LMapPat.Items := LJSONObject.GetValue('items').Value;
            LMapPat.Creatures := LJSONObject.GetValue('creatures').Value;
            LMapPat.Underground := LJSONObject.GetValue('underground').GetValue<Boolean>;
            LMapPat.Village := LJSONObject.GetValue('village').GetValue<Boolean>;
            LMapPat.GenId := LJSONObject.GetValue('genid').GetValue<Integer>;
            MapPats.MapPatList.Add(LMapPat);
          end;
        finally
          FreeAndNil(LMapPats);
        end;
      finally
        FreeAndNil(LZip);
      end;
    finally
      FreeAndNil(LStringList);
    end;
  except
    on E: Exception do
      Error.Add('MapPats.LoadFromResources', E.Message);
  end;
end;

procedure Serialize;
var
  LStringList: TStringList;
  LJSON: TJSONValue;
begin
  LStringList := TStringList.Create;
  LStringList.WriteBOM := False;
  try
    LJSON := TNeon.ObjectToJSON(MapPats);
    try
      LStringList.Text := TNeon.Print(LJSON, True);
      LStringList.SaveToFile(Path + 'mappats.json', TEncoding.UTF8);
    finally
      LJSON.Free;
    end;
  finally
    LStringList.Free;
  end;
end;

initialization

MapPats := TMapPats.Create;
MapPats.LoadFromResources;
Serialize;

finalization

FreeAndNil(MapPats);

end.
