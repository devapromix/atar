unit uGlobalMap;

interface

uses uCustomMap;

type
  TGlobalMap = class(TCustomMap)
  private

  public
    procedure Gen;
    procedure Clear; override;
    procedure Render; override;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TGlobalMap }

procedure TGlobalMap.Clear;
begin
  inherited;

end;

constructor TGlobalMap.Create;
begin
  inherited;
end;

destructor TGlobalMap.Destroy;
begin

  inherited;
end;

procedure TGlobalMap.Gen;
begin

end;

procedure TGlobalMap.Render;
begin

end;

end.
