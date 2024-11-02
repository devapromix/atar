unit Dragonhunter.Frame;

interface

type
  TFrameStyle = (bsSingle, bsDouble);

type
  TFrame = class(TObject)
    procedure Draw(const Left, Top, Width, Height: Integer;
      const Style: TFrameStyle = bsSingle);
  end;

var
  Frame: TFrame;

implementation

uses
  System.SysUtils,
  Trollhunter.Graph;

{ TFrame }

type
  TFrameChars = record
    TopLeft, TopRight, BottomLeft, BottomRight, Horizontal, Vertical: Char;
  end;

const
  SingleFrame: TFrameChars = (TopLeft: '┌'; TopRight: '┐'; BottomLeft: '└';
    BottomRight: '┘'; Horizontal: '─'; Vertical: '│');
  DoubleFrame: TFrameChars = (TopLeft: '╔'; TopRight: '╗'; BottomLeft: '╚';
    BottomRight: '╝'; Horizontal: '═'; Vertical: '║');

procedure TFrame.Draw(const Left, Top, Width, Height: Integer;
  const Style: TFrameStyle = bsSingle);
var
  Frame: TFrameChars;
  I: Integer;
begin
  case Style of
    bsSingle:
      Frame := SingleFrame;
    bsDouble:
      Frame := DoubleFrame;
  end;

  Graph.Text.DrawOut(Left, Top, Frame.TopLeft);
  for I := 1 to Width - 2 do
    Graph.Text.DrawOut(Left + I, Top, Frame.Horizontal);
  Graph.Text.DrawOut(Left + I, Top, Frame.TopRight);

  for I := 1 to Height - 2 do
  begin
    Graph.Text.DrawOut(Left, Top + I, Frame.Vertical);
    Graph.Text.DrawOut(Left + Width - 1, Top + I, Frame.Vertical);
  end;

  Graph.Text.DrawOut(Left, Top + Height - 1, Frame.BottomLeft);
  for I := 1 to Width - 2 do
    Graph.Text.DrawOut(Left + I, Top + Height - 1, Frame.Horizontal);
  Graph.Text.DrawOut(Left + I, Top + Height - 1, Frame.BottomRight);
end;

initialization

Frame := TFrame.Create;

finalization

FreeAndNil(Frame);

end.
