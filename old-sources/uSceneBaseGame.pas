unit uSceneBaseGame;

interface

uses Classes, uScene;

type
  TSceneBaseGame = class(TScene)
  private
    FID: Word;
  public
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    constructor Create(TitleLangID: Word);
    destructor Destroy; override;
  end;


implementation

uses SysUtils, uBox, uLang, uGraph, uScenes, uSceneGame;

{ TSceneBaseGame }

constructor TSceneBaseGame.Create(TitleLangID: Word);
begin
  FID := Word(TitleLangID);
end;

destructor TSceneBaseGame.Destroy;
begin

  inherited;
end;

procedure TSceneBaseGame.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = 27) or (Key = 123) then Scenes.Scene := SceneGame;
end;

procedure TSceneBaseGame.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSceneBaseGame.Render;
begin
  inherited;
  Graph.Clear(0);
  Graph.Text.TitleOut(GetLang(FID));
  Graph.Text.BarOut('esc', GetLang(27), True);
end;

end.
