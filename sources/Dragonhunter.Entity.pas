unit Dragonhunter.Entity;

interface

uses
  System.Types,
  Vcl.Graphics;

type
  TEntity = class(TObject)
  private
    FImage: TBitmap;
    FPos: TPoint;
    FName: string;
  public
    procedure SetPosition(const X, Y: Integer);
    constructor Create();
    destructor Destroy; override;
    property Name: string read FName write FName;
    property Image: TBitmap read FImage write FImage;
    property Pos: TPoint read FPos write FPos;
  end;

implementation

{ TEntity }

constructor TEntity.Create;
begin
  Image := Vcl.Graphics.TBitmap.Create;
  Image.Transparent := True;
  Name := '';
end;

destructor TEntity.Destroy;
begin
  Image.Free;
  inherited;
end;

procedure TEntity.SetPosition(const X, Y: Integer);
begin
  Pos := Point(X, Y);
end;

end.
