unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
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
  PNGImage;

var
  Png: TPNGImage;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Png := TPNGImage.Create;
  Png.LoadFromResourceName(HInstance, 'mage');
  Image1.Canvas.Draw(0, 0, Png);
  Png.Free;
end;

end.
