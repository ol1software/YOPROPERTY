unit UnitZero;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TformZero = class(TForm)
    Image1: TImage;
    StaticText1: TStaticText;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formZero: TformZero;

implementation

{$R *.dfm}

uses Unit1;

procedure TformZero.Button1Click(Sender: TObject);
begin
form1.Show;
formZero.hide;

end;

end.
