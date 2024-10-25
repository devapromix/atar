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
    procedure Clear;
    procedure Render;
    procedure MenuLine(const ALeft, ATop, AWidth: Integer);
    procedure TextOut(const ALeft, ATop: Integer; const AText: string);
    procedure TextColor(const AColor: Cardinal);
    function TextWidth(const AText: string): Integer;
    procedure NormalFont;
    procedure BoldFont;
  end;

var
  Terminal: TTerminal;

implementation

{ TTerminal }

uses
  Vcl.Graphics,
  System.Types,
  Trollhunter.Graph,
  Trollhunter.Color;

procedure TTerminal.Clear;
begin
  Graph.Clear(0);
end;

constructor TTerminal.Create;
begin

end;

destructor TTerminal.Destroy;
begin

  inherited;
end;

procedure TTerminal.TextColor(const AColor: Cardinal);
begin
  Graph.Surface.Canvas.Font.Color := AColor;
end;

procedure TTerminal.TextOut(const ALeft, ATop: Integer; const AText: string);
begin
  Graph.Surface.Canvas.TextOut(ALeft * Graph.CharWidth,
    ATop * Graph.CharHeight, AText);
end;

function TTerminal.TextWidth(const AText: string): Integer;
begin
  Result := Length(AText);
end;

function TTerminal.Height: Integer;
begin
  Result := Graph.Height div Graph.CharHeight;
end;

procedure TTerminal.MenuLine(const ALeft, ATop, AWidth: Integer);
begin
  with Graph.Surface.Canvas do
  begin
    Brush.Color := cDkGray;

    FillRect(Rect(ALeft * Graph.CharWidth, ATop * Graph.CharHeight,
      (ALeft + AWidth) * Graph.CharWidth, (ATop + 1) * Graph.CharHeight));

    Brush.Color := 0;
    Brush.Style := bsClear;
  end;
end;

procedure TTerminal.BoldFont;
begin
  Graph.Surface.Canvas.Font.Style := [fsBold];
end;

procedure TTerminal.NormalFont;
begin
  Graph.Surface.Canvas.Font.Style := [];
end;

procedure TTerminal.Render;
begin
  Graph.Render;
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
