unit UnitBUY;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, global1,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.NumberBox, Vcl.ToolWin, Vcl.Menus;

type
  Tformcompras = class(TForm)
    contenedor1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Memoingresos: TMemo;
    Memogastos: TMemo;
    fotocoche: TImage;
    izq: TImage;
    dere: TImage;
    nombrevehtxt: TLabel;
    valores: TValueListEditor;
    Button1: TButton;
    propcheck: TCheckBox;
    Shape1: TShape;
    PanelV: TPanel;
    precioofrecidotxt: TNumberBox;
    VenderVBtn: TButton;
    Label1: TLabel;
    CoolBar1: TCoolBar;
    dinerotxt: TStaticText;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    AYUDA1: TMenuItem;
    Button2: TButton;
    XCERRAR1: TMenuItem;

  procedure CargaPropiedadesForm(id: integer; tipo: integer);
  procedure CargaVehiculos(movimiento: integer; reset: boolean);
    procedure RellenaPantalla;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure dereClick(Sender: TObject);
    procedure izqClick(Sender: TObject);
    procedure izqhClick(Sender: TObject);
    procedure derhClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure VenderVBtnClick(Sender: TObject);
    procedure VenderHBtnClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure AYUDA1Click(Sender: TObject);
    procedure XCERRAR1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formcompras: Tformcompras;

  idactual: integer;   // id del coche actual cargado
  idactualH: integer;   // id del piso actual cargado


implementation

{$R *.dfm}

uses Unit1;

  (*
  RELLENA PANTALLA
  - rellena los campos existentes en Formcompras
  *)
  procedure Tformcompras.RellenaPantalla;
  begin
       (*
  barraturno.Position:=TurnoParte;
  comboturno.ItemIndex:=TurnoParte-1;

  empresatxt.Caption :=nomempresa;


  NumberBox1.Value:=TurnoParte;           *)
  //showmessage(coches[id].propietario.ToString);

    if idactual=1 then izq.Enabled:=false
                  else izq.Enabled:=true;
  if idactual=numerovehiculos then dere.Enabled:=false else dere.Enabled:=true;



dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );


dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );
//edit1.Text:=CurrtoStrF(coches[idactual].precio,ffCurrency, 0 );







  end;





procedure Tformcompras.VenderHBtnClick(Sender: TObject);
begin
Showmessage('Alquilas tu piso por '+'5000');
end;

procedure Tformcompras.VenderVBtnClick(Sender: TObject);
begin
Ayudabuy;
end;

procedure Tformcompras.XCERRAR1Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformcompras.AYUDA1Click(Sender: TObject);
begin
AyudaBuy;
end;

procedure Tformcompras.Button1Click(Sender: TObject);
begin



CompraObjeto('coches',idactual);

CargaPropiedadesForm(idactual, 1);

RellenaPantalla;


end;



   procedure Tformcompras.Button2Click(Sender: TObject);
begin
self.Close;
end;

(*
  CargaPropiedadesForm
  -carga las propiedades (vehiculo) en el formulario de compra
  tipo:1 = coche
  *)

procedure Tformcompras.CargaPropiedadesForm(id: integer; tipo: integer);
var
i: integer;    B: BOOLEAN;
begin




//if tipo=1 then BEGIN

idactual:=id;

// VALORES COCHES
valores.Cells[1,1]:=coches[id].mes.ToString;
valores.Cells[1,2]:=coches[id].anyo.ToString;
valores.Cells[1,3]:=coches[id].km.ToString;
valores.Cells[1,4]:=coches[id].precio.ToString;
valores.Cells[1,5]:=coches[id].preciocompra.ToString;
valores.Cells[1,6]:=coches[id].nombrecoche;
valores.Cells[1,7]:=coches[id].matricula;
valores.Cells[1,8]:=coches[id].modelo;
valores.Cells[1,10]:=coches[id].motor.ToString;
valores.Cells[1,11]:=coches[id].ruedas.ToString;


if coches[id].propietario=1 then Begin
        shape1.Brush.Color:=clLime;
        Button1.Enabled:=false;  End else
        Begin
          shape1.Brush.Color:=clWhite;
          Button1.Enabled:=true;
        End;
fotocoche.Picture.LoadFromFile(coches[id].foto);
nombrevehtxt.Caption:=coches[id].nombrecoche;

precioofrecidotxt.Text:=coches[id].precioofrecido.ToString;


if coches[id].propietario=1 then b:=true else b:=false;

if precioofrecidotxt.Text='0' then begin
                            label1.Caption:='Aún no hay ofertas por este coche. Vuelve otro día'; b:=false;
                                  end  else label1.Caption:='Tienes una oferta por tu coche de...';



label1.Visible:=b;
label2.Visible:=b;
precioofrecidotxt.Visible:=b;





end;
// compra 1 piso

procedure Tformcompras.Button3Click(Sender: TObject);
begin
//CompraObjeto('piso',idactualH);

RellenaPantalla;
end;



   procedure Tformcompras.Button5Click(Sender: TObject);
begin

end;



   (*
  CargaVehiculos
  -solo carga vehiculos del mes y año
  si movimiento=1 recorre hacia la derecha
  si movimiento=0 recorre hacia la izquierda
  *)
procedure Tformcompras.CargaVehiculos(movimiento: integer; reset: boolean);
var
i, x, y, z, rst: integer;
begin


// esto por si empezamos desde el primer objeto
if reset=true then rst:=0 else rst:=1;

if movimiento=1 then Begin
z:=idactual+rst;
// recorre desde el coche actual (id) hasta el final
for i := z to numerovehiculos do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if ciudadactual=global1.coches[i].ciudad then Begin
//Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaPropiedadesForm(i, 1);
                                        exit;
                                               End;

                          end;


                      End else     // RUTINA MOVIMIENTO COCHES der-izq
z:=idactual-rst;
// recorre desde el coche actual (id) atrás hasta el inicio (1)
for i := z downto 1 do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if ciudadactual=global1.coches[i].ciudad then Begin

                                        CargaPropiedadesForm(i, 1);
                                        exit;
                                                   End;


                          end;

end;



procedure Tformcompras.CheckBox3Click(Sender: TObject);
begin
ShowMessage('queda alquilado por 1 año a '+'jhonny');
end;

procedure Tformcompras.dereClick(Sender: TObject);
begin

CargaVehiculos(1, false);

  RellenaPantalla;
end;



procedure Tformcompras.derhClick(Sender: TObject);
begin


  RellenaPantalla;
end;

procedure Tformcompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.RellenaPantalla;
end;

procedure Tformcompras.FormShow(Sender: TObject);
var
i: integer;
begin

//PasaTurnoP;
idactual:=1;
idactualH:=1;

 CargaVehiculos(1, true);


RellenaPantalla;

end;

procedure Tformcompras.izqClick(Sender: TObject);
begin

CargaVehiculos(0, false);

  RellenaPantalla;
end;

procedure Tformcompras.izqhClick(Sender: TObject);
begin


  RellenaPantalla;
end;

procedure Tformcompras.Label2Click(Sender: TObject);
begin
   VendeObjeto(idactual);

CargaPropiedadesForm(idactual, 1);

RellenaPantalla;

end;

end.
