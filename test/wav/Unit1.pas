unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Winapi.MMSystem;

procedure TForm1.Button1Click(Sender: TObject);
var
  Res: TResourceStream;
begin
  Res := TResourceStream.Create(HInstance, 'CLICK1', 'RC_DATA');
  try
    Res.Position := 0;
    SndPlaySound(Res.Memory, SND_MEMORY or SND_ASYNC or SND_LOOP);
  finally
    Res.Free;
  end;
end;

end.
