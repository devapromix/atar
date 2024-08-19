unit Trollhunter.Game;

interface

uses
  Trollhunter.Scores;

type
  TPCInfo = record
    Level: Byte;
    Rating: Cardinal;
    Dungeon: Byte;
  end;

  TGame = class(TObject)
  private
    FScores: TScores;
    procedure SetScores(const Value: TScores);
  public
    procedure New;
    procedure Save;
    procedure Load(I: Integer = -1);
    function GetPCInfo(AFileName: string): TPCInfo;
    constructor Create;
    destructor Destroy; override;
    property Scores: TScores read FScores write SetScores;
  end;

var
  Game: TGame;

implementation

uses
  SysUtils,
  Trollhunter.MainForm,
  Trollhunter.Map,
  Trollhunter.Utils,
  Trollhunter.Creatures,
  Trollhunter.Log,
  Trollhunter.Zip,
  Trollhunter.Graph,
  Trollhunter.Error,
  Trollhunter.TempSys,
  Trollhunter.Item,
  Trollhunter.Settings,
  Trollhunter.Resources;

{ TGame }

constructor TGame.Create;
begin
  Scores := TScores.Create(26);
  if FileExists(Path + 'save\Scores.rec') then
    Scores.Load;
end;

destructor TGame.Destroy;
begin
  Scores.Free;
  inherited;
end;

procedure TGame.New;
begin
  try
    Creatures.PC.Create;
    Game.Load;
    Log.Clear;
  except
    on E: Exception do
      Error.Add('Game.New', E.Message);
  end;
end;

procedure TGame.Load(I: Integer = -1);
var
  LFileName: string;
  LZip: TZip;
begin
  IsGame := True;
  with Creatures do
    try
      LFileName := PC.Name;
      if not FileExists(Path + 'save\' + LFileName + '.sav') then
      begin
        PC.World.Gen;
        Map.Gen(PC.Dungeon);
        PC.Redraw;
        Res.Free;
        Res := TResources.Create;
        Exit;
      end;
      // Open save
      LZip := TZip.Create(MainForm);
      try
        LZip.Password := PWD;
        LZip.FileName := Path + 'save\' + LFileName + '.sav';
        LZip.OpenArchive;
        // PC
        PC.Text := LZip.ExtractToText('pc.txt');
        // Scrolls Properties
        PC.Scrolls.Text := LZip.ExtractToText('scrolls.txt');
        // Potions Properties
        PC.Potions.Text := LZip.ExtractToText('potions.txt');
        // PC.Inv
        PC.Inv.Text := LZip.ExtractToText('inv.txt');
        if (I > -1) then
          PC.Dungeon := I;
        // PC.Skill
        PC.Skill.Text := LZip.ExtractToText('skill.txt');
        // Map
        if not LZip.FileExists(IntToStr(PC.Dungeon) + '.m') then
        begin
          Map.Gen(PC.Dungeon);
        end
        else
        begin
          Map.FM.Text := LZip.ExtractToText(IntToStr(PC.Dungeon) + '.m');
          Map.FV.Text := LZip.ExtractToText(IntToStr(PC.Dungeon) + '.v');
          Map.FS.Text := LZip.ExtractToText(IntToStr(PC.Dungeon) + '.s');
          Map.FD.Text := LZip.ExtractToText(IntToStr(PC.Dungeon) + '.d');
          Map.FL.Text := LZip.ExtractToText(IntToStr(PC.Dungeon) + '.l');
          Map.Load(PC.Dungeon);
        end;
        // Counters
        PC.TempSys.Text := LZip.ExtractToText('effects.txt');
        // Statistics
        PC.Statistics.Text := LZip.ExtractToText('statistics.txt');
        // Log
        Log.Text := LZip.ExtractToText('log.txt');
        // World
        PC.World.Text := LZip.ExtractToText('world.p');
        //
        LZip.CloseArchive;
      finally
        LZip.Free;
      end;
      PC.Redraw;
      Res.Free;
      Res := TResources.Create;
    except
      on E: Exception do
        Error.Add('Game.Load', E.Message);
    end;
end;

function TGame.GetPCInfo(AFileName: string): TPCInfo;
var
  LZip: TZip;
begin
  LZip := TZip.Create(MainForm);
  try
    LZip.Password := PWD;
    LZip.FileName := AFileName;
    LZip.OpenArchive;
    // PC
    Creatures.PC.Text := LZip.ExtractToText('pc.txt');
    Result.Level := Creatures.PC.Prop.Level;
    Result.Rating := Creatures.PC.Rating;
    Result.Dungeon := Creatures.PC.Dungeon;
    LZip.CloseArchive;
  finally
    LZip.Free;
  end;
end;

procedure TGame.Save;
var
  LFileName: string;
  LSettings: TSettings;
  LZip: TZip;
begin
  if not IsGame then
    Exit;
  with Creatures do
    try
      if not PC.Life.IsMin and (PC.Name <> '') then
      begin
        LFileName := PC.Name;
        LZip := TZip.Create(MainForm);
        try
          LZip.Password := PWD;
          LZip.FileName := Path + 'save\' + LFileName + '.sav';
          LZip.OpenArchive;
          // PC
          LZip.AddFromString('pc.txt', PC.Text);
          // Scrolls Properties
          LZip.AddFromString('scrolls.txt', PC.Scrolls.Text);
          // Potions Properties
          LZip.AddFromString('potions.txt', PC.Potions.Text);
          // PC.Inv
          LZip.AddFromString('inv.txt', PC.Inv.Text);
          // PC.Skill
          LZip.AddFromString('skill.txt', PC.Skill.Text);
          // Map
          Map.Save(PC.Dungeon);
          LZip.AddFromString(IntToStr(PC.Dungeon) + '.m', Map.FM.Text);
          LZip.AddFromString(IntToStr(PC.Dungeon) + '.v', Map.FV.Text);
          LZip.AddFromString(IntToStr(PC.Dungeon) + '.s', Map.FS.Text);
          LZip.AddFromString(IntToStr(PC.Dungeon) + '.d', Map.FD.Text);
          LZip.AddFromString(IntToStr(PC.Dungeon) + '.l', Map.FL.Text);
          // Counters
          LZip.AddFromString('effects.txt', PC.TempSys.Text);
          // Statistics
          LZip.AddFromString('statistics.txt', PC.Statistics.Text);
          // Log
          LZip.AddFromString('log.txt', Log.Text);
          // World
          LZip.AddFromString('world.p', PC.World.Text);
          //
          LZip.CloseArchive;
        finally
          LZip.Free;
        end;
        LSettings := TSettings.Create;
        try
          LSettings.Write('Settings', 'LastName', PC.Name);
        finally
          LSettings.Free;
        end;
      end;
    except
      on E: Exception do
        Error.Add('Game.Save', E.Message);
    end;
end;

procedure TGame.SetScores(const Value: TScores);
begin
  FScores := Value;
end;

initialization

Game := TGame.Create;

finalization

Game.Free;

end.
