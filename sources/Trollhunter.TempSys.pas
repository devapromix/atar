unit Trollhunter.TempSys;

interface

uses
  Classes;

type
  TTempSysItem = record
    Power, Duration: Word;
  end;

function TempSysItem(APower, ADuration: Word): TTempSysItem;

type
  TTempSys = class(TObject)
  private
    FList: TStringList;
    function GetText: string;
    procedure SetText(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    function VarName(I: Integer): string;
    function Power(I: Integer): Integer; overload;
    function Power(AVarName: string): Integer; overload;
    function Duration(I: Integer): Integer; overload;
    function Duration(AVarName: string): Integer; overload;
    function IsMove: Boolean;
    function IsVar(AVarName: string): Boolean;
    property Text: string read GetText write SetText;
    procedure SetValue(AVarName: string; AValue: Integer);
    procedure Add(AVarName: string; APower, ADuration: Integer);
    procedure Clear;
    procedure ClearVar(AVarName: string);
    procedure Move;
  end;

implementation

uses
  SysUtils;

const
  LS = '%s/%d=%d';

function TempSysItem(APower, ADuration: Word): TTempSysItem;
begin
  Result.Power := APower;
  Result.Duration := ADuration;
end;

{ TTempSys }

procedure TTempSys.Clear;
begin
  FList.Clear;
end;

function TTempSys.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TTempSys.Create;
begin
  FList := TStringList.Create;
  Self.Clear;
end;

destructor TTempSys.Destroy;
begin
  FList.Free;
  inherited;
end;

function TTempSys.IsMove: Boolean;
begin
  Result := (FList.Count > 0);
end;

function TTempSys.VarName(I: Integer): string;
begin
  Result := Copy(FList.Names[I], 1, Pos('/', FList.Names[I]) - 1);
end;

function TTempSys.Power(I: Integer): Integer;
begin
  Result := StrToIntDef(Copy(FList.Names[I], Pos('/', FList.Names[I]) + 1,
    Length(FList.Names[I])), 0);
end;

function TTempSys.Power(AVarName: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if (UpperCase(AVarName) = VarName(I)) then
    begin
      Result := Power(I);
      Exit;
    end;
end;

procedure TTempSys.Move;
var
  I, V: Integer;
begin
  if IsMove then
    with FList do
      for I := Count - 1 downto 0 do
      begin
        V := Duration(I);
        System.Dec(V);
        if (V > 0) then
          FList[I] := Format(LS, [VarName(I), Power(I), V])
        else
          Delete(I);
      end;
end;

function TTempSys.Duration(I: Integer): Integer;
begin
  Result := StrToIntDef(FList.ValueFromIndex[I], 0);
end;

function TTempSys.Duration(AVarName: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  if IsMove then
    with FList do
      for I := 0 to Count - 1 do
        if (UpperCase(AVarName) = VarName(I)) then
        begin
          Result := StrToIntDef(Copy(FList[I], Pos('=', FList[I]) + 1,
            Length(FList[I])), 0);
          Exit;
        end;
end;

procedure TTempSys.SetValue(AVarName: string; AValue: Integer);
begin
  if IsVar(AVarName) then
    FList.Values[AVarName] := IntToStr(AValue);
end;

function TTempSys.IsVar(AVarName: string): Boolean;
begin
  Result := (Duration(AVarName) > 0);
end;

procedure TTempSys.ClearVar(AVarName: string);
var
  I: Integer;
begin
  if IsMove then
    with FList do
      for I := Count - 1 downto 0 do
        if (UpperCase(AVarName) = VarName(I)) then
          Delete(I);
end;

procedure TTempSys.Add(AVarName: string; APower, ADuration: Integer);
var
  I, V, P: Integer;
begin
  if (Trim(AVarName) = '') or (ADuration <= 0) or (ADuration > 1000) or
    (APower <= 0) or (APower > 1000) then
    Exit;
  if IsMove then
    with FList do
      for I := 0 to Count - 1 do
      begin
        if (UpperCase(AVarName) = VarName(I)) then
        begin
          P := Power(I);
          if (APower > P) then
            P := APower;
          V := Duration(I);
          if (ADuration > V) then
            V := ADuration;
          FList[I] := Format(LS, [VarName(I), P, V]);
          Exit;
        end;
      end;
  FList.Append(Format(LS, [UpperCase(AVarName), APower, ADuration]));
end;

procedure TTempSys.SetText(const AValue: string);
begin
  FList.Text := AValue;
end;

function TTempSys.GetText: string;
begin
  Result := FList.Text;
end;

end.
