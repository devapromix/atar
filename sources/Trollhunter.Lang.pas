unit Trollhunter.Lang;

interface

uses
  System.Classes,
  Trollhunter.Item,
  Trollhunter.Creature,
  Trollhunter.Map;

const
  ItemName: array [0 .. ItemsCount, 0 .. 2] of string = (

    ('GOLDCOINS', 'Gold Coin', 'Золото'), ('KEY', 'Key', 'Ключ'),
    ('MINIPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('MINILIFEPOTION', 'Minor Healing Potion', 'Малый Эликсир Здоровья'),
    ('MINIMANAPOTION', 'Minor Mana Potion', 'Малый Эликсир Маны'),
    ('MINIMEGAPOTION', 'Minor Rejuvenation Potion',
    'Малый Эликсир Восстановления'), ('MINIOILPOTION', 'Minor Oil Potion',
    'Малое Кузнечное Масло'), ('NORMPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('NORMLIFEPOTION', 'Light Healing Potion', 'Легкий Эликсир Здоровья'),
    ('NORMMANAPOTION', 'Light Mana Potion', 'Легкий Эликсир Маны'),
    ('NORMMEGAPOTION', 'Light Rejuvenation Potion',
    'Легкий Эликсир Восстановления'), ('NORMOILPOTION', 'Light Oil Potion',
    'Легкое Кузнечное Масло'), ('BASEPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('BASELIFEPOTION', 'Healing Potion', 'Эликсир Здоровья'),
    ('BASEMANAPOTION', 'Mana Potion', 'Эликсир Маны'),
    ('BASEMEGAPOTION', 'Rejuvenation Potion', 'Эликсир Восстановления'),
    ('BASEOILPOTION', 'Oil Potion', 'Кузнечное Масло'),
    ('NANOPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('NANOLIFEPOTION', 'Greater Healing Potion', 'Большой Эликсир Здоровья'),
    ('NANOMANAPOTION', 'Greater Mana Potion', 'Большой Эликсир Маны'),
    ('NANOMEGAPOTION', 'Greater Rejuvenation Potion',
    'Большой Эликсир Восстановления'), ('NANOOILPOTION', 'Greater Oil Potion',
    'Большое Кузнечное Масло'), ('BIGPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('BIGLIFEPOTION', 'Super Healing Potion', 'Супер Эликсир Здоровья'),
    ('BIGMANAPOTION', 'Super Mana Potion', 'Супер Эликсир Маны'),
    ('BIGMEGAPOTION', 'Super Rejuvenation Potion',
    'Супер Эликсир Восстановления'), ('BIGOILPOTION', 'Super Oil Potion',
    'Супер Кузнечное Масло'), ('SLEDGEHAMMER', 'Sledge Hammer',
    'Кузнечный Mолот'), ('STONEHAMMER', 'Stone Hammer', 'Каменный Молот'),
    ('HATCHET', 'Hatchet', 'Топор Лесоруба'),
    ('WARAXE', 'War Axe', 'Топор Войны'), ('LARGEAXE', 'Large Axe',
    'Большой Топор'), ('BROADAXE', 'Broad Axe', 'Broad Axe'),
    ('BATTLEAXE', 'Battle Axe', 'Боевой Топор'), ('GREATAXE', 'Great Axe',
    'Большой Топор'), ('GIANTAXE', 'Giant Axe', 'Гигантский Топор'),
    ('SHORTSWORD', 'Short Sword', 'Короткий Меч'),
    ('SMALLSHIELD', 'Small Shield', 'Малый Щит'),
    ('LARGESHIELD', 'Large Shield', 'Большой Щит'),
    ('TOWERSHIELD', 'Tower Shield', 'Башенный Щит'),
    ('GOTHICSHIELD', 'Gothic Shield', 'Готический Щит'),
    ('LEATHERARMOR', 'Leather Armor', 'Кожаный Доспех'),
    ('STUDDEDLEATHER', 'Studded Leather', 'Клепаный Доспех'),
    ('RINGMAIL', 'Ring Mail', 'Кольчужный Доспех'), ('SCALEMAIL', 'Scale Mail',
    'Чешуйчатый Доспех'), ('CAP', 'Cap', 'Шлем'), ('HELM', 'Helm', 'Шлем'),
    ('MESHBOOTS', 'Mesh Boots', 'Меховые Сапоги'), ('HEAVYBOOTS', 'Heavy Boots',
    'Тяжелые Сапоги'), ('EARTHRING', 'Earth Ring', 'Кольцо Земли'),
    ('FIRERING', 'Fire Ring', 'Кольцо Огня'), ('TAMARILIS', 'Tamarilis',
    'Taмарилис'), ('ARROW', 'Quiver of Arrows', 'Колчан Стрел'),
    ('HUNTBOW', 'Hunter''s Bow', 'Лук Охотника'),
    ('LONGBOW', 'Long Bow', 'Длинный Лук'), ('BOLT', 'Case of Bolts',
    'Колчан Болтов'), ('LIGHTCROSSBOW', 'Light Crossbow', 'Легкий Арбалет'),
    ('SIEGECROSSBOW', 'Siege Crossow', 'Осадный Арбалет'),
    // Scrolls
    ('SCROLLA', 'Scroll of Summon', 'Свиток Призыва'),
    ('SCROLLB', 'Scroll of Power Cure', 'Свиток Восстановления'),
    ('SCROLLC', 'Scroll of Teleportation', 'Свиток Телепортации'),
    ('SCROLLD', 'Scroll of Unlocking', 'Свиток Отпирания'),
    ('SCROLLE', 'Scroll of Identify', 'Свиток Идентификации'),
    ('SCROLLF', 'Scroll of Portal', 'Свиток Портала'),
    ('SCROLLG', 'Scroll of Wizard Eye', 'Свиток Глаза Чародея'),
    ('SCROLLH', 'Scroll of Dispel Effects', 'Свиток Снятие Эффектов'),
    ('SCROLLI', 'Scroll of Repair', 'Свиток Ремонта'),
    // Potions
    ('POTIONA', 'Antidote Potion', 'Эликсир Противоядия'),
    ('POTIONB', 'Full Healing Potion', 'Эликсир Полного Здоровья'),
    ('POTIONC', 'Full Mana Potion', 'Эликсир Полной Маны'),
    ('POTIOND', 'Full Rejuvenation Potion', 'Эликсир Полного Восстановления'),
    ('POTIONE', 'Strength Potion', 'Эликсир Силы'),
    ('POTIONF', 'Dexterity Potion', 'Эликсир Ловкости'),
    ('POTIONG', 'Intelligence Potion', 'Эликсир Интеллекта'),
    ('POTIONH', 'Speed Potion', 'Эликсир Проворности'),
    // Bag of Stones
    //
    ('#', '#', '#'));

type
  TLanguageString = class(TObject)
  private
    FId: TStringList;
    FEn: TStringList;
    FRu: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AId, AEn, ARu: string);
    property ID: TStringList read FId write FId;
    property En: TStringList read FEn write FEn;
    property Ru: TStringList read FRu write FRu;
  end;

type
  TLanguage = class(TObject)
  private
    FCurrentLanguageIndex: Byte;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromResources;
    property CurrentLanguageIndex: Byte read FCurrentLanguageIndex
      write FCurrentLanguageIndex;
    function GetLang(const AIdent: string): string; overload;
    function GetLang(const AIdent: Integer): string; overload;
    function GetItemLang(const AItemIdent: string): string;
    procedure ChangeLanguage;
    function LanguageName: string;
  end;

var
  Language: TLanguage;

implementation

uses
  System.SysUtils,
  System.JSON,
  Vcl.Dialogs,
  Trollhunter.Zip,
  Trollhunter.Utils,
  Trollhunter.Error,
  Trollhunter.Creatures,
  Trollhunter.MainForm;

var
  LanguageString: TLanguageString;

  { TLanguageString }

procedure TLanguageString.Add(const AId, AEn, ARu: string);
begin
  FId.Add(AId);
  FEn.Add(AEn);
  FRu.Add(ARu);
end;

procedure TLanguageString.Clear;
begin
  FId.Clear;
  FEn.Clear;
  FRu.Clear;
end;

constructor TLanguageString.Create;
begin
  FId := TStringList.Create;
  FEn := TStringList.Create;
  FRu := TStringList.Create;
end;

destructor TLanguageString.Destroy;
begin
  FreeAndNil(FId);
  FreeAndNil(FEn);
  FreeAndNil(FRu);
  inherited;
end;

{ TLanguage }

procedure TLanguage.ChangeLanguage;
begin
  if (FCurrentLanguageIndex = 0) then
    FCurrentLanguageIndex := 1
  else
    FCurrentLanguageIndex := 0;
end;

constructor TLanguage.Create;
begin
  LanguageString := TLanguageString.Create;
  FCurrentLanguageIndex := 0;
end;

destructor TLanguage.Destroy;
begin
  FreeAndNil(LanguageString);
  inherited;
end;

function TLanguage.GetLang(const AIdent: Integer): string;
begin
  Result := GetLang(AIdent.ToString);
end;

function TLanguage.GetLang(const AIdent: string): string;
var
  I: Integer;
begin
  Result := '';
  I := LanguageString.FId.IndexOf(AIdent);
  if I < 0 then
    Exit;
  if (FCurrentLanguageIndex = 0) then
    Result := LanguageString.En[I]
  else
    Result := LanguageString.Ru[I];
end;

function TLanguage.GetItemLang(const AItemIdent: string): string;
var
  LColorTag, LItemIndex: Integer;
  LColorPrefix: string;
begin
  Result := '';
  LItemIndex := Items.ItemIndex(AItemIdent);
  // Scrolls and Potions
  LColorTag := DungeonItems[LItemIndex].ColorTag;
  with Creatures.PC do
  begin
    if (LColorTag > 0) and (DungeonItems[LItemIndex].Category = dsPotion) and
      not Potions.IsDefined(LColorTag) then
    begin
      Result := '#r' + Potions.GetColorName(LColorTag) + ' ' +
        Language.GetLang(222) + '$';
      Exit;
    end;
    if (LColorTag > 0) and (DungeonItems[LItemIndex].Category = dsScroll) and
      not Scrolls.IsDefined(LColorTag) then
    begin
      Result := '#r' + Language.GetLang(221) + ' ' + '"' +
        Scrolls.GetName(LColorTag) + '"';
      Exit;
    end;
  end;
  // Items
  case DungeonItems[LItemIndex].Category of
    dsPotion:
      LColorPrefix := '#g';
    dsScroll:
      LColorPrefix := '#b';
  else
    LColorPrefix := '#w';
  end;
  Result := LColorPrefix + GetLang(AItemIdent) + '$';
end;

function TLanguage.LanguageName: string;
begin
  case FCurrentLanguageIndex of
    0:
      Result := 'English';
    1:
      Result := 'Russian';
    2:
      Result := 'Ukrainian';
  end;
end;

procedure TLanguage.LoadFromResources;

  procedure LoadFromFile(const AFileName: string);
  var
    LStringList: TStringList;
    LJSONObject: TJSONObject;
    LJSONArray: TJSONArray;
    LZip: TZip;
    I: Integer;
    ID, En, Ru: string;
  begin
    try
      LStringList := TStringList.Create;
      try
        LZip := TZip.Create(MainForm);
        try
          LStringList.Text := LZip.ExtractTextFromFileUTF8
            (Path + 'resources.res', AFileName);
          LJSONArray := TJSONObject.ParseJSONValue(LStringList.Text)
            as TJSONArray;
          try
            for I := 0 to LJSONArray.Count - 1 do
            begin
              LJSONObject := LJSONArray.Items[I] as TJSONObject;
              ID := LJSONObject.GetValue('id').Value;
              En := LJSONObject.GetValue('en').Value;
              Ru := LJSONObject.GetValue('ru').Value;
              LanguageString.Add(ID, En, Ru);
            end;
          finally
            FreeAndNil(LJSONArray);
          end;
        finally
          FreeAndNil(LZip);
        end;
      finally
        FreeAndNil(LStringList);
      end;
    except
      on E: Exception do
        Error.Add('Lang.LoadFromFile', E.Message);
    end;
  end;

begin
  try
    if not FileExists(Path + 'resources.res') then
      Exit;
    LanguageString.Clear;
    LoadFromFile('languages.json');
    LoadFromFile('languages.maps.json');
    LoadFromFile('languages.items.json');
    LoadFromFile('languages.creatures.json');
  except
    on E: Exception do
      Error.Add('Lang.LoadFromResources', E.Message);
  end;
end;

procedure SaveItLang;
var
  SL: TStringList;
  I: Integer;
  S: string;
begin
  S := ',';
  SL := TStringList.Create;
  SL.WriteBOM := False;
  try
    SL.Append('[');
    for I := 0 to ItemsCount - 1 do
    begin
      SL.Append('	{');
      SL.Append('		"id": "' + ItemName[I][0] + '",');
      SL.Append('		"en": "' + ItemName[I][1] + '",');
      SL.Append('		"ru": "' + ItemName[I][2] + '",');
      SL.Append('		"uk": ""');
      if I = ItemsCount - 1 then
        S := '';
      SL.Append('	}' + S);
    end;
    SL.Append(']');
    SL.SaveToFile(Path + 'languages.items.json', TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

initialization

Language := TLanguage.Create;
Language.LoadFromResources;

SaveItLang;

finalization

FreeAndNil(Language);

end.
