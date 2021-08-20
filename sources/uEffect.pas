unit uEffect;

interface

uses Graphics;

type
  TEffects = class(TObject)
  private

  public
    Image: array [0..0] of Graphics.TBitmap;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses Windows, uError, uGraph;

{ TEffects }

constructor TEffects.Create;
var
  I: Byte;
  Tileset: Graphics.TBitmap;  
begin
  Tileset := Graphics.TBitmap.Create;
  Tileset.Handle := Windows.LoadBitmap(hInstance, 'EFFECTS');
  for I := 0 to High(Image) do
  begin
    Image[I] := Graphics.TBitmap.Create;
    Graph.BitmapFromTileset(Image[I], Tileset, I);
    Image[I].Transparent := True;
  end;
  Tileset.Free;
end;

destructor TEffects.Destroy;
var
  I: Byte;
begin
  for I := 0 to High(Image) do Image[I].Free;
  inherited;
end;

end.
