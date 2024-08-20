unit Trollhunter.RandItems;

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
  RandItemCount = 12;

type
  TRandItem = array [1 .. RandItemCount] of TRandItemRec;

const
  AllowColors: array [1 .. RandItemCount] of Integer = (cGolden, cIndigo, cJade,
    cAzure, cLight, cDark, cGray, cBrown, cFxBlack, cFxWhite, cSkyBlue,
    cLtYellow);

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
  public
    constructor Create(const ACount: Byte);
    destructor Destroy; override;
    property Text: string read GetText write SetText;
    property Count: Byte read FCount;
    function GetColor(const AIndex: Integer): Integer;
    function GetColorName(Index: Integer): string;
    function GetName(Index: Integer): string;
    function IsDefined(Index: Integer): Boolean;
    procedure SetDefined(Index: Integer);
  end;

implementation

uses
  SysUtils,
  Trollhunter.Utils,
  Trollhunter.Lang;

{ TRandItems }

procedure TRandItems.Clear;
var
  LIndex: Byte;
begin
  for LIndex := 1 to RandItemCount do
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
  LIndex: Byte;
begin
  Result := False;
  for LIndex := 1 to Count do
    if (RandItem[LIndex].Color = AColor) then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TRandItems.Gen;
var
  LIndex, LColor: Integer;
begin
  Clear;
  for LIndex := 1 to Count do
  begin
    repeat
      LColor := AllowColors[Rand(1, RandItemCount)];
    until not IsThisColor(LColor);
    with RandItem[LIndex] do
    begin
      Name := GenName;
      Color := LColor;
      Defined := 0;
    end;
  end;
end;

function TRandItems.GenName: string;
const
  S = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  I: Byte;
begin
  Result := '';
  for I := 1 to 7 do
    Result := Result + S[Rand(1, 26)];
end;

function TRandItems.GetColor(const AIndex: Integer): Integer;
begin
  Result := RandItem[AIndex].Color;
end;

function TRandItems.GetColorName(Index: Integer): string;
begin
  Result := '';
  case GetColor(Index) of
    cGolden:
      Result := GetLang(250);
    cIndigo:
      Result := GetLang(251);
    cJade:
      Result := GetLang(252);
    cAzure:
      Result := GetLang(253);
    cLight:
      Result := GetLang(254);
    cDark:
      Result := GetLang(255);
    cGray:
      Result := GetLang(256);
    cBrown:
      Result := GetLang(257);
    cFxBlack:
      Result := GetLang(258);
    cFxWhite:
      Result := GetLang(259);
    cSkyBlue:
      Result := GetLang(260);
    cLtYellow:
      Result := GetLang(261);
  end;
end;

function TRandItems.GetName(Index: Integer): string;
begin
  Result := RandItem[Index].Name;
end;

function TRandItems.GetText: string;
begin
  Self.Save;
  Result := FStringList.Text;
end;

function TRandItems.IsDefined(Index: Integer): Boolean;
begin
  Result := RandItem[Index].Defined = 1;
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
  LIndex: Byte;
begin
  FStringList.Clear;
  for LIndex := 1 to Count do
    with RandItem[LIndex] do
      FStringList.Append(Format('%s/%d/%d', [Name, Color, Defined]));
end;

procedure TRandItems.SetDefined(Index: Integer);
begin
  RandItem[Index].Defined := 1;
end;

procedure TRandItems.SetText(const Value: string);
begin
  FStringList.Text := Value;
  Self.Load;
end;

end.
