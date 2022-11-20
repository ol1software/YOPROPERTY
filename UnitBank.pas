unit UnitBank;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, global1;

type
  Tformbank = class(TForm)
    Image1: TImage;
    tdinero: TStaticText;
    Button1: TButton;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ComboBox2: TComboBox;
    ListBox3: TListBox;
    ComboBox3: TComboBox;
    StaticText1: TStaticText;
    ComboBox4: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formbank: Tformbank;

implementation

{$R *.dfm}

procedure Tformbank.Button1Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformbank.FormShow(Sender: TObject);
begin
tdinero.Caption:= CurrtoStrF(dinero,ffCurrency, 0 );


end;

end.
