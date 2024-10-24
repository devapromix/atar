unit Dragonhunter.Item.Random;

interface

uses
  Classes,
  Graphics,
  Trollhunter.Color;

type
  TRandItemRec = record
    Name: string;
    Color: Integer;
    Defined: Integer;
  end;

const
  ItemRandomCount = 12;

type
  TRandItem = array [1 .. ItemRandomCount] of TRandItemRec;

type
  TRandItems = class(TObject)
  private
    FCount: Byte;
    FStringList: TStringList;
    RandItem: TRandItem;
    procedure Gen;
    procedure Save;
    procedure Load;
    procedure Clear;
    function GenName: string;
    function GetText: string;
    procedure SetText(const Value: string);
    function IsThisColor(const AColor: Integer): Boolean;
    function IsThisName(const AName: string): Boolean;
  public
    constructor Create(const ACount: Byte);
    destructor Destroy; override;
    property Text: string read GetText write SetText;
    property Count: Byte read FCount;
    function GetColor(const AIndex: Integer): Integer;
    function GetColorName(const AIndex: Integer): string;
    function GetName(const AIndex: Integer): string;
    function IsDefined(const AIndex: Integer): Boolean;
    procedure SetDefined(const AIndex: Integer);
  end;

implementation

uses
  SysUtils,
  Trollhunter.Utils,
  Trollhunter.Lang;

type
  TType = record
    Color: Integer;
    LangId: Integer;
  end;
  {
    const
    AllowColors: array [1 .. ItemRandomCount] of TType = (
    //
    (Color:cGolden;LangId:), cIndigo,
    cJade, cAzure, cLight, cDark, cGray, cBrown, cFxBlack, cFxWhite, cSkyBlue,
    cLtYellow); }

  { TRandItems }

procedure TRandItems.Clear;
var
  LIndex: Integer;
begin
  for LIndex := 1 to ItemRandomCount do
    with RandItem[LIndex] do
    begin
      Name := '';
      Color := 0;
      Defined := 0;
    end;
end;

constructor TRandItems.Create(const ACount: Byte);
begin
  FStringList := TStringList.Create;
  FCount := ACount;
  Self.Gen;
end;

destructor TRandItems.Destroy;
begin
  FreeAndNil(FStringList);
  inherited;
end;

function TRandItems.IsThisColor(const AColor: Integer): Boolean;
var
  LIndex: Integer;
begin
  Result := False;
  for LIndex := 1 to Count do
    if (RandItem[LIndex].Color = AColor) then
    begin
      Result := True;
      Exit;
    end;
end;

function TRandItems.IsThisName(const AName: string): Boolean;
var
  LIndex: Integer;
begin
  Result := False;
  for LIndex := 1 to Count do
    if (RandItem[LIndex].Name = AName) then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TRandItems.Gen;
var
  LIndex, LColor: Integer;
  LName: string;
begin
  Clear;
  for LIndex := 1 to Count do
  begin
    {repeat
      LColor := AllowColors[Rand(1, ItemRandomCount)];
    until not IsThisColor(LColor);  }
    repeat
      LName := UpperCase(GenName.Trim);
    until not IsThisName(LName);
    with RandItem[LIndex] do
    begin
      Name := LName;
      Color := LColor;
      Defined := 0;
    end;
  end;
end;

function TRandItems.GenName: string;
var
  LStringList: array [0 .. 1] of TStringList;
  LIndex: Integer;
begin
  for LIndex := 0 to 1 do
    LStringList[LIndex] := TStringList.Create;
  LStringList[0].DelimitedText :=
    '"Elivi","Kilim","Kalim","Valin","Elim","Elid","Tolen","Fillis","Romul",' +
    '"Ened","Eres","Moliz","Revid","Nasum","Teles","Narom","Danif","Tulis",' +
    '"Tarus","Elazom","Treves","Eliminar","Relic","Firim","Sevi","Runus"';
  LStringList[1].DelimitedText :=
    '"sanum","noriz","laar","maar","torum","doris","darum","sarim","nodum",' +
    '"virum","loran","taar","torin","tiris","nirnum","nirus","dorus","borus",' +
    '"ronum","sorez","sarum","daris","lorim","nadus","sevirum","zorum","narum"';
  Result := '';
  for LIndex := 0 to 1 do
  begin
    Result := Result + LStringList[LIndex]
      [Random(LStringList[LIndex].Count - 1)] + ' ';
    FreeAndNil(LStringList[LIndex]);
  end;
end;

function TRandItems.GetColor(const AIndex: Integer): Integer;
begin
  Result := RandItem[AIndex].Color;
end;

function TRandItems.GetColorName(const AIndex: Integer): string;
begin
  Result := '';
  case GetColor(AIndex) of
    cGolden:
      Result := Language.GetLang(250);
    cIndigo:
      Result := Language.GetLang(251);
    cJade:
      Result := Language.GetLang(252);
    cAzure:
      Result := Language.GetLang(253);
    cLight:
      Result := Language.GetLang(254);
    cDark:
      Result := Language.GetLang(255);
    cGray:
      Result := Language.GetLang(256);
    cBrown:
      Result := Language.GetLang(257);
    cFxBlack:
      Result := Language.GetLang(258);
    cFxWhite:
      Result := Language.GetLang(259);
    cSkyBlue:
      Result := Language.GetLang(260);
    cLtYellow:
      Result := Language.GetLang(261);
  end;
end;

function TRandItems.GetName(const AIndex: Integer): string;
begin
  Result := RandItem[AIndex].Name;
end;

function TRandItems.GetText: string;
begin
  Self.Save;
  Result := FStringList.Text;
end;

function TRandItems.IsDefined(const AIndex: Integer): Boolean;
begin
  Result := RandItem[AIndex].Defined = 1;
end;

procedure TRandItems.Load;
var
  LIndex, LItemIndex: Integer;
  LExpString: TExplodeResult;
begin
  Clear;
  LItemIndex := 1;
  LExpString := nil;
  for LIndex := 0 to FStringList.Count - 1 do
  begin
    LExpString := Explode('/', FStringList[LIndex]);
    if (Trim(LExpString[0]) <> '') then
      with RandItem[LItemIndex] do
      begin
        Name := LExpString[0];
        Color := StrToInt(LExpString[1]);
        Defined := StrToInt(LExpString[2]);
      end;
    Inc(LItemIndex);
  end;
end;

procedure TRandItems.Save;
var
  LIndex: Integer;
begin
  FStringList.Clear;
  for LIndex := 1 to Count do
    with RandItem[LIndex] do
      FStringList.Append(Format('%s/%d/%d', [Name, Color, Defined]));
end;

procedure TRandItems.SetDefined(const AIndex: Integer);
begin
  RandItem[AIndex].Defined := 1;
end;

procedure TRandItems.SetText(const Value: string);
begin
  FStringList.Text := Value;
  Self.Load;
end;

end.
