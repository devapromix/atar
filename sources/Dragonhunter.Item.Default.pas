unit Dragonhunter.Item.Default;

interface

type
  TDefaultItems = class(TObject)
  private
    FItems: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromResources;
    property Items: string read FItems;
  end;

var
  DefaultItems: TDefaultItems;

implementation

uses
  System.SysUtils, Dialogs,
  System.Classes,
  System.JSON,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON,
  Trollhunter.Utils,
  Trollhunter.Log,
  Trollhunter.Lang,
  Trollhunter.Error,
  Trollhunter.MainForm,
  Trollhunter.Zip;

{ TDefaultItems }

constructor TDefaultItems.Create;
begin
  FItems := '';
end;

destructor TDefaultItems.Destroy;
begin

  inherited;
end;

procedure TDefaultItems.LoadFromResources;
var
  LStringList: TStringList;
  LZip: TZip;
  LJSONObject: TJSONObject;
  LDefaultItems: TJSONArray;
  I: Integer;
begin
  try
    if not FileExists(Path + 'resources.res') then
      Exit;
    LStringList := TStringList.Create;
    try
      LZip := TZip.Create(MainForm);
      try
        LStringList.Text := LZip.ExtractTextFromFile(Path + 'resources.res',
          'items.default.json');
        LDefaultItems := TJSONObject.ParseJSONValue(LStringList.Text)
          as TJSONArray;
        try
          for I := 0 to LDefaultItems.Count - 1 do
            FItems := FItems + LDefaultItems.Items[I].Value + ',';
        finally
          FreeAndNil(LDefaultItems);
        end;
      finally
        FreeAndNil(LZip);
      end;
    finally
      FreeAndNil(LStringList);
    end;
  except
    on E: Exception do
      Error.Add('DefaultItems.LoadFromResources', E.Message);
  end;
end;

initialization

DefaultItems := TDefaultItems.Create;
DefaultItems.LoadFromResources;

finalization

FreeAndNil(DefaultItems);

end.
