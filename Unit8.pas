unit Unit8;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  Tformvarios = class(TForm)
    ImageControl1: TImageControl;
    ImageControl5: TImageControl;
    tmodelo: TEdit;
    Label1: TLabel;
    tpma: TEdit;
    Label2: TLabel;
    tl100: TEdit;
    Label3: TLabel;
    izquierda1: TImageControl;
    derecha1: TImageControl;
    ImageControl2: TImageControl;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
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
