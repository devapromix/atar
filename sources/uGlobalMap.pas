unit uGlobalMap;

interface

uses uCustomMap;

type
  TGlobalMap = class(TCustomMap)
  private
    function GetText: string;
    procedure SetText(const Value: string);

  public
    procedure Gen;
    procedure Clear; override;
    procedure Render; override;
    constructor Create;
    destructor Destroy; override;
    procedure Save;
    procedure Load;
    property Text: string read GetText write SetText;
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

function TGlobalMap.GetText: string;
begin

end;

procedure TGlobalMap.Load;
begin

end;

procedure TGlobalMap.Render;
begin

end;

procedure TGlobalMap.Save;
begin

end;

procedure TGlobalMap.SetText(const Value: string);
begin

end;

end.
