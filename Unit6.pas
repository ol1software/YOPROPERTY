unit Unit6;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  Tformbanco = class(TForm)
    tdinero: TEdit;
    ImageC: TImageControl;
    companyia: TLabel;
    turno: TImageControl;
    ImageControl1: TImageControl;
    Button2: TButton;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox3: TComboBox;
    ImageControl5: TImageControl;
    Panel1: TPanel;
    Button3: TButton;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    Label4: TLabel;
    tcantidad: TComboBox;
    procedure ImageControl5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formbanco: Tformbanco;

implementation

{$R *.fmx}

uses global;

procedure Tformbanco.FormShow(Sender: TObject);
begin
tdinero.Text:=Fglobal.DimeVJugador('dinero');

end;

procedure Tformbanco.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

end.
