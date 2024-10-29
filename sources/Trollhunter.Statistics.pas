unit Trollhunter.Statistics;

interface

uses
  Classes;

type
  TStatisticsEnum = (stTilesMoved, stKills, stSpCast, stFound, stPotDrunk,
    stScrRead, stItUsed, stItIdent, stItCrafted, stItRep, stFdEat,
    stCoinsLooted);

type
  TStatistics = class(TObject)
  private
    FF: TStringList;
    function GetText: string;
    procedure SetText(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Inc(const AStatisticsEnum: TStatisticsEnum;
      const AValue: Cardinal = 1);
    function Get(const AStatisticsEnum: TStatisticsEnum): Cardinal;
    procedure SetValue(const AStatisticsEnum: TStatisticsEnum;
      const AValue: Cardinal);
    property Text: string read GetText write SetText;
  end;

implementation

uses
  SysUtils;

{ TStatistics }

procedure TStatistics.Clear;
var
  LStatisticsEnum: TStatisticsEnum;
begin
  FF.Clear;
  for LStatisticsEnum := Low(TStatisticsEnum) to High(TStatisticsEnum) do
    FF.Append('0');
end;

constructor TStatistics.Create;
begin
  FF := TStringList.Create;
  Self.Clear;
end;

destructor TStatistics.Destroy;
begin
  FF.Free;
  inherited;
end;

function TStatistics.Get(const AStatisticsEnum: TStatisticsEnum): Cardinal;
begin
  Result := StrToIntDef(FF[Ord(AStatisticsEnum)], 0);
end;

function TStatistics.GetText: string;
begin
  Result := FF.Text;
end;

procedure TStatistics.Inc(const AStatisticsEnum: TStatisticsEnum;
  const AValue: Cardinal);
var
  LValue: Cardinal;
begin
  LValue := StrToIntDef(FF[Ord(AStatisticsEnum)], 0);
  LValue := LValue + AValue;
  FF[Ord(AStatisticsEnum)] := IntToStr(LValue);
end;

procedure TStatistics.SetText(const AValue: string);
begin
  FF.Text := AValue;
end;

procedure TStatistics.SetValue(const AStatisticsEnum: TStatisticsEnum;
  const AValue: Cardinal);
begin
  FF[Ord(AStatisticsEnum)] := IntToStr(AValue);
end;

end.
