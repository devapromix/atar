unit Dragonhunter.Tileset;

interface

uses
  Windows, Classes, Graphics, SysUtils;

type
  TTilesetLoader = class(TObject)
  private
    FSourceBitmap: TBitmap;
    FTileWidth: Integer;
    FTileHeight: Integer;
    FTilesPerRow: Integer;
    FTilesPerCol: Integer;
    FTotalTiles: Integer;
    procedure Initialize(const AResourceName: string;
      ATileWidth, ATileHeight: Integer);
    function GetTileRect(ATileIndex: Integer): TRect;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadTileset(const AResourceName: string;
      ATileWidth, ATileHeight: Integer);
    function GetTile(ATileIndex: Integer): TBitmap;
    property TileWidth: Integer read FTileWidth;
    property TileHeight: Integer read FTileHeight;
    property TilesPerRow: Integer read FTilesPerRow;
    property TilesPerCol: Integer read FTilesPerCol;
    property TotalTiles: Integer read FTotalTiles;
  end;

var
  Tileset: TTilesetLoader;

implementation
                  uses dialogs;
constructor TTilesetLoader.Create;
begin
  FSourceBitmap := TBitmap.Create;
end;

destructor TTilesetLoader.Destroy;
begin
  FSourceBitmap.Free;
  inherited;
end;

procedure TTilesetLoader.Initialize(const AResourceName: string;
  ATileWidth, ATileHeight: Integer);
var
  LResourceStream: TResourceStream;
begin
  LResourceStream := TResourceStream.Create(HInstance, AResourceName,
    RT_RCDATA);
  try
    FSourceBitmap.LoadFromStream(LResourceStream);
  finally
    LResourceStream.Free;
  end;
  FTileWidth := ATileWidth;
  FTileHeight := ATileHeight;
  FTilesPerRow := FSourceBitmap.Width div ATileWidth;
  FTilesPerCol := FSourceBitmap.Height div ATileHeight;
  FTotalTiles := FTilesPerRow * FTilesPerCol;
  showmessage(inttostr(       FTilesPerRow            ));
end;

procedure TTilesetLoader.LoadTileset(const AResourceName: string;
  ATileWidth, ATileHeight: Integer);
begin
  Initialize(AResourceName, ATileWidth, ATileHeight);
end;

function TTilesetLoader.GetTileRect(ATileIndex: Integer): TRect;
var
  LRow, LCol: Integer;
begin
  LRow := ATileIndex div FTilesPerRow;
  LCol := ATileIndex mod FTilesPerCol;
  Result := Rect(LCol * FTileWidth, LRow * FTileHeight, (LCol + 1) * FTileWidth,
    (LRow + 1) * FTileHeight);
end;

function TTilesetLoader.GetTile(ATileIndex: Integer): TBitmap;
var
  LTileRect: TRect;
begin
  Result := TBitmap.Create;
  try
    Result.Width := FTileWidth;
    Result.Height := FTileHeight;
    Result.PixelFormat := FSourceBitmap.PixelFormat;
    LTileRect := GetTileRect(ATileIndex);
    Result.Canvas.CopyRect(Rect(0, 0, FTileWidth, FTileHeight),
      FSourceBitmap.Canvas, LTileRect);
  except
    Result.Free;
    raise;
  end;
end;

initialization

Tileset := TTilesetLoader.Create;

finalization

FreeAndNil(Tileset);

end.
