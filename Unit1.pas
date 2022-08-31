unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.CheckLst, Vcl.Menus,
  Unit4, Unitvehiculos, Vcl.NumberBox;

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
    empresatxt: TStaticText;
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
    procedure ToolButton4Click(Sender: TObject);


  procedure RellenaPantalla;
        procedure Start;

    procedure NewGame1Click(Sender: TObject);
    procedure Cars1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);

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

uses Unit2, UnitZero, global1, UnitBUY;

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
fechajuego:=StrtoDate('01/01/2007');


dinero:=180000;


global1.InicializaVariables;
global1.CargarVehiculos;

// fin variables

nomempresa:=InputBox('Nombre de tu empresa', 'Prompt', 'Enterprise');



PasaTurnoP;


contenedor1.Visible:=true;
toolbar1.Enabled:=true;

RellenaPantalla;





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

  barraturno.Position:=diasemana;


  empresatxt.Caption :=nomempresa;


dinerotxt.Caption:=CurrtoStrF(dinero,ffCurrency, 0 );

ingresostxt.Caption:=CurrtoStrF(ingresoturn,ffCurrency, 0 );
gastostxt.Caption:=CurrtoStrF(gastoturn,ffCurrency, 0 );

// calendarios
calendario.Date:=global1.fechajuego;
datetimepicker1.DateTime:=global1.fechajuego;
// fecha en texto
diasemanatxt.Caption :=diasemanastr;
numerodiatxt.Caption:=numdiastr;
mestxt.Caption:=messtr;




  end;



procedure TForm1.Cars1Click(Sender: TObject);
begin
//formvehiculos.ShowModal;
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

end.
