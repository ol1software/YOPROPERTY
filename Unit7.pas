unit Unit7;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Objects,
  FMX.Memo.Types;

type
  Tformprensa = class(TForm)
    ImageControl1: TImageControl;
    foto: TImageControl;
    derecha: TImageControl;
    izquierda: TImageControl;
    ImageControl5: TImageControl;
    tmodelo: TEdit;
    Label1: TLabel;
    tpma: TEdit;
    Label2: TLabel;
    tl100: TEdit;
    Label3: TLabel;
    derecha2: TImageControl;
    izquierda2: TImageControl;
    izquierda1: TImageControl;
    derecha1: TImageControl;
    ImageControl2: TImageControl;
    tnoticia: TMemo;
    procedure ImageControl5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formprensa: Tformprensa;

implementation

{$R *.fmx}

procedure Tformprensa.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

end.
