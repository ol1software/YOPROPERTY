unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.CheckLst, Vcl.Menus,
  Unitvehiculos, Vcl.NumberBox, Vcl.Buttons;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    NewGame1: TMenuItem;
    Savegame1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Buy1: TMenuItem;
    Cars1: TMenuItem;
    Houses1: TMenuItem;
    Other1: TMenuItem;
    contenedor1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabControl1: TTabControl;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    l2: TLabel;
    calendario: TMonthCalendar;
    barraturno: TProgressBar;
    ingresostxt: TStaticText;
    gastostxt: TStaticText;
    Panel2: TPanel;
    dinerotxt: TStaticText;
    diasemanatxt: TStaticText;
    numerodiatxt: TStaticText;
    mestxt: TStaticText;
    DateTimePicker1: TDateTimePicker;
    Image2: TImage;
    Image4: TImage;
    Image3: TImage;
    ToolButton9: TToolButton;
    ToolButton2: TToolButton;
    imagenmapa: TImage;
    empresatxt: TStaticText;
    ciudadtxt: TStaticText;
    barraviaja: TTrackBar;
    botonviaja: TBitBtn;
    ciudad2: TStaticText;
    menu1: TMenuItem;
    Memoingresos: TMemo;
    Memogastos: TMemo;
    procedure ToolButton4Click(Sender: TObject);


  procedure RellenaPantalla;
        procedure Start;

    procedure Viajar(ciudad: integer);

    procedure NewGame1Click(Sender: TObject);
    procedure Cars1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure barraviajaChange(Sender: TObject);
    procedure botonviajaClick(Sender: TObject);
    procedure menu1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  {
TABLAS
-----------
JUEGO
COCHES
PISOS
TRABAJO
CAJA
EMPRESACCIONES
PRESTAMOS
EVENTOS

----------



  TABLA.juego
<nombre
JOES
<caja (euros)
540.000
<prestamoEuros
<prestamoMes
<diasemana
1-7.LMXJVSD
1
<dia
2
<mes
1
<anyo
2000
<turno 1-4
0




````
COCHES
PISOS

CAJA
ACCIONES
PRESTAMOS
TRABAJO
EVENTO

````
PISOS
--
idinmueble,
String nice,
barrio
int antiguedad,
int calidad
int tamanyo,
 int valor,

 int anyo,
 String nombrecalle
string barrio
int devaluacionxanyo%



   ``
   `COCHES
   --


TABLA.VEHICULOS
    idvehiculo
    1
    2

    modelo
    mercedes Clase A 200 7G-DCT
    toyota land cruiser 150

    calidad 0-100
    85
    70


    tipo
    3
    5
    1 mini
    2 compacto
    3 grande
    4 deportivo
    5 TT

    valor EUR
    38.901
    62.900

    prestigio 1-5
    4
    3

    Combustible 1-2 (gas-ele)
    1
    1

	CV
	150
	230

    Seguro
    900
    1200

 }


   (*
  INSTRUCCIONES
  - PasaTurnoP y RellenaPantalla = cada vez que se hace algo
  - PasaTurno = cuando se finaliza y hay que recalcular valores

  *)

implementation

{$R *.dfm}

uses Unit2, UnitZero, global1, UnitBUY, Unit8, Unit10;

// NUEVO JUEGO BTN
// *********************************************
procedure TForm1.NewGame1Click(Sender: TObject);
begin

// *

Start;

end;

(*
  GASTOSSEMANAL
  GASTOSMENSUAL
  INGRESOSEMANAL
  INGRESOSMENSUAL
  -SUELDO

  GASTOPUNTUAL
  INGRESOPUNTUAL
*)


// -----------------------------------------
// COMIENZO DEL JUEGO
(* ***************************************
 ************************************
 ************************************
 ************************************
  *)
procedure TForm1.Start;

begin

Turno:=1;
// al comenzar, se añade un dia
diasemana:=0;
fechajuego:=StrtoDate('29/01/2007');

// se empieza con 10.000 €
dinero:=10000;


global1.InicializaVariables;
global1.CargarBases;

// fin variables

nomempresa:=InputBox('Nombre de tu empresa', 'Prompt', 'Enterprise');


ciudadactual:=2; // 1-madrid, 2-barcelona, 3-valencia, 4-malaga
sueldoactual:=dimesueldo;


// Pasa una parte del turno (1 día)
PasaTurnoP;


contenedor1.Visible:=true;
toolbar1.Enabled:=true;


RellenaPantalla;
// SE RELLENA LA PANTALLA, Y SE ESPERA A LAS ACCIONES DEL USUARIO PARA:
// 1- COMPRAR/VENDER/INVERTIR




end;      // END START
// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
 (* ***************************************
 ************************************
 ************************************
 ************************************
  *)



  (*
  RELLENA PANTALLA
  - rellena los campos existentes en Form1
  *)
  procedure TForm1.RellenaPantalla;
  begin

  // de 1 a 7
  barraturno.Position:=diasemana;

 // nombre de la empresa
  empresatxt.Caption :=nomempresa;


  // dinero
dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );

// ingresos y gastos
if ingresoturn<>0 then begin
    memoingresos.Lines.Add(inttostr(ingresoturn));
    ingresostxt.Caption:=CurrtoStrF(ingresoturn,ffCurrency, 0 );
                       end;

if gastoturn<>0 then begin
      memogastos.Lines.Add(inttostr(gastoturn));
      gastostxt.Caption:=CurrtoStrF(gastoturn,ffCurrency, 0 );
                      end;


// calendarios
calendario.Date:=global1.fechajuego;
datetimepicker1.DateTime:=global1.fechajuego;

// fecha en texto
diasemanatxt.Caption :=diasemanastr;
numerodiatxt.Caption:=numdiastr;
mestxt.Caption:=messtr;

// ciudad actual
ciudadtxt.Caption:=ciudadestexto[ciudadactual];
barraviaja.Position:=ciudadactual;
imagenmapa.Picture.LoadFromFile(rutajpg+'mapa'+inttostr(ciudadactual)+'.jpg');

ingresoturn:=0;
gastoturn:=0;




  end;




  (*
            Viaja a la ciudad indicada
            -------
*)
    procedure TForm1.Viajar(ciudad: integer);
    var
    i: integer;
      begin
      ShowMessage('Viajando a ... '+ciudadestexto[ciudad]);
     ciudadactual:=ciudad;

     i:=Random(100);
     ShowMessage('Gastaste '+inttostr(i)+'euros en AVE');

     gastoturn:=gastoturn+i;

     PasaTurnoP;
     form1.RellenaPantalla;

      end;





  procedure TForm1.barraviajaChange(Sender: TObject);
begin

ciudad2.Caption:=ciudadestexto[barraviaja.Position];

end;

procedure TForm1.botonviajaClick(Sender: TObject);
begin
if barraviaja.Position<>ciudadactual then Viajar(barraviaja.Position);
end;

procedure TForm1.Cars1Click(Sender: TObject);
begin
//formvehiculos.ShowModal;
end;



  procedure TForm1.menu1Click(Sender: TObject);
begin
formvarios.showmodal;
end;

(*
  buy
  *)
procedure TForm1.ToolButton1Click(Sender: TObject);
begin
formcompras.show;
end;

  (*
  boton pasa turno
  *)
procedure TForm1.ToolButton4Click(Sender: TObject);
begin
PasaTurnoP;
RellenaPantalla;
  //listaturno.Items[1].checked:=true;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
formbiz.showmodal;
end;

end.
