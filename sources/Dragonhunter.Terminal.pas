unit Dragonhunter.Terminal;

interface

type
  TTerminal = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
    function Width: Integer;
    function Height: Integer;
  end;

var
  Terminal: TTerminal;

implementation

{ TTerminal }

uses
  Trollhunter.Graph;

constructor TTerminal.Create;
begin

end;

destructor TTerminal.Destroy;
begin

  inherited;
end;

function TTerminal.Height: Integer;
begin
  Result := Graph.Height div Graph.CharHeight;
end;

function TTerminal.Width: Integer;
begin
  Result := Graph.Width div Graph.CharWidth;
end;

initialization

Terminal := TTerminal.Create;

finalization

Terminal.Free;

end.
