unit Unit8;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  Tformvarios = class(TForm)
    ImageControl1: TImageControl;
    ImageControl5: TImageControl;
    izquierda1: TImageControl;
    derecha1: TImageControl;
    Button2: TButton;
    Memo1: TMemo;
    procedure ImageControl2Click(Sender: TObject);
    procedure ImageControl5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formvarios: Tformvarios;

implementation

{$R *.fmx}

procedure Tformvarios.ImageControl2Click(Sender: TObject);
begin
halt;
end;

procedure Tformvarios.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

end.
