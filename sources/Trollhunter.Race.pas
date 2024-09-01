unit Trollhunter.Race;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Trollhunter.Skill;

{  const
  // High Elf
  NameLangID: 187; BeginDescr: 347; EndDescr: 365; Strength: - 4;
  Dexterity: 0; Intelligence: 4; Speed: 0; RHWeapon: (ID: 'SHORTSWORD';
  Count: 1); LHWeapon: (ID: ''; Count: 0);
  Skills: ((Skill: skMagic; Level: 10), (Skill: skTrap; Level: 10));), (
  // Night Elf
  NameLangID: 188; BeginDescr: 348; EndDescr: 366; Strength: 1; Dexterity: 2;
  Intelligence: - 2; Speed: - 1; RHWeapon: (ID: 'HUNTBOW'; Count: 1);
  LHWeapon: (ID: 'ARROW'; Count: 75);
  Skills: ((Skill: skBow; Level: 10), (Skill: skTrap; Level: 10));), (
  // Dark Elf
  NameLangID: 189; BeginDescr: 349; EndDescr: 367; Strength: - 3;
  Dexterity: 2; Intelligence: 0; Speed: 1; RHWeapon: (ID: 'LIGHTCROSSBOW';
  Count: 1); LHWeapon: (ID: 'BOLT'; Count: 75);
  Skills: ((Skill: skCrossBow; Level: 10), (Skill: skTrap; Level: 10));), (
  // Deep Dwarf
  NameLangID: 190; BeginDescr: 350; EndDescr: 368; Strength: 1; Dexterity: 1;
  Intelligence: 0; Speed: - 2; RHWeapon: (ID: 'HATCHET'; Count: 1);
  LHWeapon: (ID: 'SMALLSHIELD'; Count: 1);
  Skills: ((Skill: skAxe; Level: 10), (Skill: skShield; Level: 10));), (
  // Cave Dwarf
  NameLangID: 191; BeginDescr: 351; EndDescr: 369; Strength: - 1;
  Dexterity: 4; Intelligence: - 2; Speed: - 1; RHWeapon: (ID: 'STONEHAMMER';
  Count: 1); LHWeapon: (ID: ''; Count: 0);
  Skills: ((Skill: skMace; Level: 15), (Skill: skTrap; Level: 5));)); }

type
  TRace = class(TObject)
  private
    FSprite: string;
    FNameID: Integer;
    FEndDescr: Integer;
    FBeginDescr: Integer;
    FStrength: Integer;
    FIntelligence: Integer;
    FPerception: Integer;
    FSpeed: Integer;
    FDexterity: Integer;
    FEquipment: TStringList;
    FSkills: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    property Sprite: string read FSprite write FSprite;
    property Name: Integer read FNameID write FNameID;
    property BeginDescr: Integer read FBeginDescr write FBeginDescr;
    property EndDescr: Integer read FEndDescr write FEndDescr;
    property Strength: Integer read FStrength write FStrength;
    property Dexterity: Integer read FDexterity write FDexterity;
    property Intelligence: Integer read FIntelligence write FIntelligence;
    property Perception: Integer read FPerception write FPerception;
    property Speed: Integer read FSpeed write FSpeed;
    property Equipment: TStringList read FEquipment write FEquipment;
    property Skills: TStringList read FSkills write FSkills;
  end;

  TRaces = class(TObject)
  private
    FRaceList: TObjectList<TRace>;
  public
    constructor Create;
    destructor Destroy; override;
    property RaceList: TObjectList<TRace> read FRaceList write FRaceList;
    procedure Load;
  end;

var
  Races: TRaces;

implementation

uses
  Vcl.Dialogs,
  System.SysUtils,
  System.JSON,
  Trollhunter.Error,
  Trollhunter.Zip,
  Trollhunter.Utils,
  Trollhunter.MainForm;

{ TRace }

constructor TRace.Create;
begin
  FEquipment := TStringList.Create;
  FSkills := TStringList.Create;
end;

destructor TRace.Destroy;
begin
  FreeAndNil(FSkills);
  FreeAndNil(FEquipment);
  inherited;
end;

{ TRaces }

constructor TRaces.Create;
begin
  FRaceList := TObjectList<TRace>.Create;
end;

destructor TRaces.Destroy;
begin
  FreeAndNil(FRaceList);
  inherited;
end;

procedure TRaces.Load;
var
  I, J, K: Integer;
  LZip: TZip;
  LStringList: TStringList;
  LJSONObject: TJSONObject;
  LRaces, LEquipment, LSkills: TJSONArray;
  LRace: TRace;
begin
  try
    if not FileExists(Path + 'resources.res') then
      Exit;
    LStringList := TStringList.Create;
    try
      LZip := TZip.Create(MainForm);
      try
        LStringList.Text := LZip.ExtractTextFromFile(Path + 'resources.res',
          'races.json');
        LRaces := TJSONObject.ParseJSONValue(LStringList.Text) as TJSONArray;
        try
          for I := 0 to LRaces.Count - 1 do
          begin
            LJSONObject := LRaces.Items[I] as TJSONObject;
            LRace := TRace.Create;
            LRace.Sprite := LJSONObject.GetValue('sprite').Value;
            LRace.Name := LJSONObject.GetValue('name').Value.ToInteger;
            LRace.BeginDescr := LJSONObject.GetValue('begin_descr')
              .Value.ToInteger;
            LRace.EndDescr := LJSONObject.GetValue('end_descr').Value.ToInteger;
            LRace.Strength := LJSONObject.GetValue('strength').Value.ToInteger;
            LRace.Dexterity := LJSONObject.GetValue('dexterity')
              .Value.ToInteger;
            LRace.Intelligence := LJSONObject.GetValue('intelligence')
              .Value.ToInteger;
            LRace.Perception := LJSONObject.GetValue('perception')
              .Value.ToInteger;
            LRace.Speed := LJSONObject.GetValue('speed').Value.ToInteger;
            // Equipment
            LEquipment := LJSONObject.GetValue<TJSONArray>('equipment');
            for J := 0 to LEquipment.Count - 1 do
            begin
              LRace.Equipment.Append(LEquipment.Items[J].Value);
            end;
            // Skills
            LSkills := LJSONObject.GetValue<TJSONArray>('skills');
            for K := 0 to LSkills.Count - 1 do
            begin
              LRace.Skills.Append(LSkills.Items[K].Value);
            end;

            Races.RaceList.Add(LRace);
          end;
        finally
          FreeAndNil(LRaces);
        end;
      finally
        FreeAndNil(LZip);
      end;

    finally
      FreeAndNil(LStringList);
    end;
  except
    on E: Exception do
      Error.Add('Race.Load', E.Message);
  end;
end;

initialization

Races := TRaces.Create;
Races.Load;

finalization

FreeAndNil(Races);

end.
