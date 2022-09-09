unit Unitbiz;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, global1;

type
  Tformbiz = class(TForm)
    StaticText1: TStaticText;
    tdinero: TStaticText;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formbiz: Tformbiz;

implementation

{$R *.dfm}

procedure Tformbiz.Button1Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformbiz.FormShow(Sender: TObject);
begin
//tdinero.Caption:= CurrtoStrF(dinero,ffCurrency, 0 );
end;

end.
