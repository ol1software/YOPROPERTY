unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TForm0 = class(TForm)
    ImageControl3: TImageControl;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    CornerButton1: TCornerButton;
    Label3: TLabel;
    CornerButton2: TCornerButton;
    procedure ImageControl2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form0: TForm0;

implementation

{$R *.fmx}

uses Unit1;

procedure TForm0.CornerButton1Click(Sender: TObject);
begin
form1.Show;
end;

procedure TForm0.ImageControl2Click(Sender: TObject);
begin
form1.show;
end;


procedure TForm0.Timer1Timer(Sender: TObject);
begin

//timer1.Enabled:=false;
//form1.Show;
end;

end.
