unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Edit, FMX.Objects,
  FMX.Controls.Presentation;

type
  Tformempresa = class(TForm)
    ArcDial1: TArcDial;
    ImageControl1: TImageControl;
    Button2: TButton;
    Button1: TButton;
    foto: TImageControl;
    derecha: TImageControl;
    izquierda: TImageControl;
    ImageControl5: TImageControl;
    tmodelo: TEdit;
    Label1: TLabel;
    tpma: TEdit;
    Label2: TLabel;
    derecha2: TImageControl;
    izquierda2: TImageControl;
    izquierda1: TImageControl;
    derecha1: TImageControl;
    ImageControl2: TImageControl;
    Button3: TButton;
    procedure ImageControl5Change(Sender: TObject);
    procedure ImageControl5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formempresa: Tformempresa;

implementation

{$R *.fmx}

procedure Tformempresa.ImageControl5Change(Sender: TObject);
begin
self.Close;
end;

procedure Tformempresa.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

end.
