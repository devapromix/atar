unit Elinoor.Scene.Temple;

interface

uses
  System.Classes,
  Trollhunter.Scene;

type
  TSceneTemple = class(TScene)
  private
  public
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    constructor Create;
    destructor Destroy; override;
  end;

var
  SceneTemple: TSceneTemple;

implementation

uses
  System.SysUtils,
  Vcl.Imaging.PNGImage,
  Trollhunter.Graph,
  Dragonhunter.Terminal,
  Trollhunter.Error;

var
  Png: TPNGImage;

  { TSceneTemple }

constructor TSceneTemple.Create;
begin

  Png := TPNGImage.Create;
  Png.LoadFromResourceName(HInstance, 'FRAME');
end;

destructor TSceneTemple.Destroy;
begin
  Png.Free;

  inherited;
end;

procedure TSceneTemple.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TSceneTemple.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSceneTemple.Render;
begin
  inherited; try
  with Graph.Surface.Canvas do
    Draw(10, 10, Png);

    Terminal.Render;
  except
    on E: Exception do
      Error.Add('SceneLevelUp.Render', E.Message);
  end;
end;

initialization

SceneTemple := TSceneTemple.Create;

finalization

FreeAndNil(SceneTemple);

end.
