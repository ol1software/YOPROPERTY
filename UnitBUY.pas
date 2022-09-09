unit UnitBUY;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, global1,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit;

type
  Tformcompras = class(TForm)
    contenedor1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Memoingresos: TMemo;
    Memogastos: TMemo;
    TabSheet2: TTabSheet;
    fotocoche: TImage;
    izq: TImage;
    dere: TImage;
    ComboBox1: TComboBox;
    nombrevehtxt: TLabel;
    dinerotxt: TStaticText;
    Edit1: TEdit;
    valores: TValueListEditor;
    Button1: TButton;
    Button2: TButton;
    propcheck: TCheckBox;
    TabSheet3: TTabSheet;
    Shape1: TShape;
    ComboBox2: TComboBox;
    izqh: TImage;
    derh: TImage;
    fotopiso: TImage;
    Button3: TButton;
    Button4: TButton;
    Shape2: TShape;
    CheckBox1: TCheckBox;
    valoresh: TValueListEditor;
    Button5: TButton;

  procedure CargaPropiedadesForm(id: integer; tipo: integer);
  procedure CargaVehiculos(movimiento: integer; reset: boolean);
  procedure CargaPisos(movimiento: integer; reset: boolean);
    procedure RellenaPantalla;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure dereClick(Sender: TObject);
    procedure izqClick(Sender: TObject);
    procedure izqhClick(Sender: TObject);
    procedure derhClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);

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

  // pisos
      if idactualH=1 then izqH.Enabled:=false
                  else izqH.Enabled:=true;
  if idactualH=numeropisos then derH.Enabled:=false else derH.Enabled:=true;

dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );


dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );
edit1.Text:=CurrtoStrF(coches[idactual].precio,ffCurrency, 0 );







  end;





procedure Tformcompras.Button1Click(Sender: TObject);
begin



Compra('vehiculo',idactual);

RellenaPantalla;


end;



   (*
  CargaPropiedadesForm
  -carga las propiedades (vehiculo-piso) en el formulario de compra
  tipo:1 = coche, 2= piso
  *)

procedure Tformcompras.CargaPropiedadesForm(id: integer; tipo: integer);
var
i: integer;
begin




if tipo=1 then BEGIN

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
                END else


                BEGIN     // tipo = 2 PISOS
idactualH:=id;

(****************

// VALORES PISOS
	"calle"	TEXT,
	"barrio"	TEXT,
	"metros"	INTEGER,
	"calidad"	INTEGER,
	"anyo"	INTEGER,
	"estado"	INTEGER,
	"precio"	INTEGER,
  *)

valoresh.Cells[1,1]:=pisos[id].calle;
valoresh.Cells[1,2]:=pisos[id].barrio;
valoresh.Cells[1,3]:=pisos[id].metros.ToString;
valoresh.Cells[1,4]:=pisos[id].calidad.ToString;
valoresh.Cells[1,6]:=pisos[id].anyo.ToString;
valoresh.Cells[1,7]:=pisos[id].estado.ToString;
valoresh.Cells[1,8]:=pisos[id].precio.ToString;


if pisos[id].propietario=1 then Begin
        shape2.Brush.Color:=clLime;
        Button3.Enabled:=false;  End else
        Begin
          shape1.Brush.Color:=clWhite;
          Button3.Enabled:=true;
        End;
       // Showmessage('pisoId='+inttostr(id) );
fotopiso.Picture.LoadFromFile(pisos[id].foto);

                END;   // end pisos



end;
// compra 1 piso

procedure Tformcompras.Button3Click(Sender: TObject);
begin
Compra('piso',idactualH);

RellenaPantalla;
end;



   (*
  CargaPisos
  -solo carga pisos del mes y año
  si movimiento=1 recorre hacia la derecha
  si movimiento=0 recorre hacia la izquierda
  *)
procedure Tformcompras.CargaPisos(movimiento: integer; reset: boolean);
var
i, x, y, z, rst: integer;
begin

// esto por si empezamos desde el primer objeto
if reset=true then rst:=0 else rst:=1;

if movimiento=1 then Begin
z:=idactualH+rst;

// recorre desde el coche actual (id) hasta el final
for i := z to numeropisos do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if (y>=pisos[i].anyo) and (ciudadactual=global1.pisos[i].ciudad) then
                                                    Begin
//Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaPropiedadesForm(i, 2);
                                        exit;
                                                   End;

                          end;
                      End else
z:=idactualH-rst;
// recorre desde el coche actual (id) atrás hasta el inicio (1)
for i := z downto 1 do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if (y>=pisos[i].anyo) and (ciudadactual=global1.pisos[i].ciudad) then Begin
//Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaPropiedadesForm(i, 2);
                                        exit;
                                                   End;


                          end;

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

if (x>=coches[i].mes) and (y>=coches[i].anyo) then Begin
//Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaPropiedadesForm(i, 1);
                                        exit;
                                                   End;

                          end;
                      End else
z:=idactual-rst;
// recorre desde el coche actual (id) atrás hasta el inicio (1)
for i := z downto 1 do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if (x>=coches[i].mes) and (y>=coches[i].anyo) then Begin

                                        CargaPropiedadesForm(i, 1);
                                        exit;
                                                   End;


                          end;

end;



procedure Tformcompras.dereClick(Sender: TObject);
begin

CargaVehiculos(1, false);

  RellenaPantalla;
end;



procedure Tformcompras.derhClick(Sender: TObject);
begin
  CargaPisos(1, false);

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

 CargaPisos(1, true);


RellenaPantalla;

end;

procedure Tformcompras.izqClick(Sender: TObject);
begin

CargaVehiculos(0, false);

  RellenaPantalla;
end;

procedure Tformcompras.izqhClick(Sender: TObject);
begin
CargaPisos(0, false);

  RellenaPantalla;
end;

end.
