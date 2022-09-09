unit Unit10;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox;

type
  Tformbiz = class(TForm)
    ImageControl5: TImageControl;
    ImageControl1: TImageControl;
    labelh: TLabel;
    Label10: TLabel;
    Button1: TButton;
    procedure ImageControl5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageControl2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formbiz: Tformbiz;


implementation

{$R *.fmx}

uses global, UnitBank;


procedure Tformbiz.Button1Click(Sender: TObject);
begin
formbank.showmodal;
end;

procedure Tformbiz.FormShow(Sender: TObject);
var
i: integer;
begin


end;

procedure Tformbiz.ImageControl2Click(Sender: TObject);
var i: integer;
begin

end;

procedure Tformbiz.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

end.
