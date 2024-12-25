unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure Image1MouseEnter(Sender: TObject);
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
  Vcl.Imaging.pngimage;

var
  png: TPNGObject;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
  png := TPNGObject.Create;
  png.LoadFromResourceName(HInstance, 'mage');
  Image1.Canvas.Draw(0, 0, png);
  png.Free;
end;

end.
