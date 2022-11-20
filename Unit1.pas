unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.CheckLst, Vcl.Menus,
  Vcl.NumberBox, Vcl.Buttons, Vcl.ColorGrd, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.SQLite, System.ImageList, Vcl.ImgList, Vcl.Grids,
  Vcl.Samples.Calendar;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    contenedor1: TPageControl;
    TABMAIN: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    l2: TLabel;
    barraturno: TProgressBar;
    ingresostxt: TStaticText;
    gastostxt: TStaticText;
    Panel2: TPanel;
    dinerotxt: TStaticText;
    diasemanatxt: TStaticText;
    numerodiatxt: TStaticText;
    mestxt: TStaticText;
    DateTimePicker1: TDateTimePicker;
    ToolButton2: TToolButton;
    imagenmapa: TImage;
    empresatxt: TStaticText;
    ciudadtxt: TStaticText;
    menu1: TMenuItem;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    ImageList1: TImageList;
    Game1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    Restart1: TMenuItem;
    tabmapa: TTabSheet;
    mapa2: TImage;
    ciudadtxt2: TStaticText;
    fondo: TImage;
    calendar1: TCalendar;
    mensajeciudad: TStatusBar;
    ToolButton3: TToolButton;
    botonviaja: TBitBtn;
    barraviaja: TTrackBar;
    fondohelp: TImage;
    Memogastos: TMemo;
    memoeventos: TMemo;
    ciudad2: TStaticText;
    dineroprincipal: TStaticText;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure ToolButton4Click(Sender: TObject);


  procedure RellenaPantalla;
        procedure Start0;
        procedure Start;

    procedure Viajar(ciudad: integer);

    procedure NewGame1Click(Sender: TObject);
    procedure Cars1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure barraviajaChange(Sender: TObject);
    procedure botonviajaClick(Sender: TObject);
    procedure menu1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure bnewgameClick(Sender: TObject);
    procedure bhelpClick(Sender: TObject);
    procedure imagenmapaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure mapa2Click(Sender: TObject);
    procedure fondoClick(Sender: TObject);
    procedure dinerotxtClick(Sender: TObject);
    procedure tabmarketEnter(Sender: TObject);
    procedure fondohelpClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure calendar1Click(Sender: TObject);
    procedure ciudad2Click(Sender: TObject);
    procedure empresatxtClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Restart1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  

   (*
  INSTRUCCIONES
  - PasaTurnoP y RellenaPantalla = cada vez que se hace algo
  - PasaTurno = cuando se finaliza y hay que recalcular valores

  *)

implementation

{$R *.dfm}

uses global1, UnitBUY, Unit8, UnitBank, Uniti;

// NUEVO JUEGO BTN
// *********************************************
procedure TForm1.NewGame1Click(Sender: TObject);
begin

Start0;

end;


// -----------------------------------------
// COMIENZO DEL JUEGO PREGUNTANDO
(* ***************************************
 ************************************
 ************************************
 ************************************
  *)
procedure TForm1.Start0;
var b: boolean;

begin

if juegoempezado=false then

if Vcl.Dialogs.MessageDlg('PLAY now?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then Start;
end;



procedure TForm1.tabmarketEnter(Sender: TObject);
begin

end;

// -----------------------------------------
// COMIENZO DEL JUEGO
(* ***************************************
 ************************************
 ************************************
 ************************************
  *)
procedure TForm1.Start;
var b: boolean;

begin

ShowMessage('WELCOME! PLEASE TELL ME YOUR NAME');

nomjugador:='Philips McTominay';
nomempresa:='MicroGo Ltd';

b:=InputQuery('NEW GAME START!!', ' CEO (Your name)...', nomjugador);
InputQuery('TU EMPRESA!!', ' Comienzas como mozo en la empresa...', nomempresa);

if not b then exit;



iform.ShowModal;

juegoempezado:=true;






statusbar1.Show;

Turno:=1;
// al comenzar, se añade un dia
diasemana:=0;
fechajuego:=StrtoDate('29/01/2007');

// se empieza con 10.000 €
dinero:=10000;


global1.InicializaVariables;
global1.CargarBases;

// fin variables



ciudadactual:=1; // 1-madrid, 2-barcelona, 3-valencia, 4-malaga
sueldoactual:=dimesueldo;


// Pasa una parte del turno (1 día)
PasaTurnoDia;


contenedor1.Visible:=true;
toolbar1.Visible:=true;



RellenaPantalla;
// SE RELLENA LA PANTALLA, Y SE ESPERA A LAS ACCIONES DEL USUARIO PARA:
// 1- COMPRAR/VENDER/INVERTIR

    Ayuda;


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
  var i: integer;  c: string;
  begin

  i:=numerogastos;

  // de 1 a 7
  barraturno.Position:=diasemana;

 // nombre de la empresa
  empresatxt.Caption :=nomempresa;


  // dinero
c:=CurrtoStrF(dinero,ffCurrency, 0 );
dineroprincipal.Caption:=c;

// ingresos y gastos

if ingresoturn<>0 then begin     // hay ingreso/s este turno
    //memoingresos.Lines.Add( gastosingresos[i].nombre+'='+inttostr( gastosingresos[i].precio ) );
    ingresostxt.Caption:=CurrtoStrF(ingresoturn,ffCurrency, 0 );
                       end;

if gastoturn<>0 then begin       // hay gasto/s este turno
      memogastos.Lines.Add( gastosingresos[i].nombre+'='+inttostr(gastosingresos[i].precio));
      gastostxt.Caption:=CurrtoStrF(gastoturn,ffCurrency, 0 );
                      end;


// calendarios
calendar1.CalendarDate:=global1.fechajuego;

datetimepicker1.DateTime:=global1.fechajuego;

// fecha en texto
diasemanatxt.Caption :=diasemanastr;
numerodiatxt.Caption:=numdiastr;
mestxt.Caption:=messtr;

// ciudad actual
mensajeciudad.SimpleText:='Trabajas en la empresa '+nomempresa+'. Estás ahora mismo en '+ciudadestexto[ciudadactual];
ciudadtxt.Caption:=ciudadestexto[ciudadactual];
barraviaja.Position:=ciudadactual;
imagenmapa.Picture.LoadFromFile(rutajpg+'mapa'+inttostr(ciudadactual)+'.jpg');

ciudadtxt2.Caption:=ciudadestexto[ciudadactual];
mapa2.Picture.LoadFromFile(rutajpg+'mapa'+inttostr(ciudadactual)+'.jpg');


// se resetea el numero de gastos/ingresos para el sig. dia
ingresoturn:=0;
gastoturn:=0;




  end;




  procedure TForm1.Restart1Click(Sender: TObject);
begin
Start0;
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

     RecalculaValoresCoches(2);

     i:=Random(100);

     gastoturn:=gastoturn+i;

     PasaTurnoDia;

           ShowMessage('****LLEGANDO A '+ciudadestexto[ciudad]);
                 ShowMessage('BIENVENIDO #### '+ciudadestexto[ciudad]+'#### ');
     form1.RellenaPantalla;

      end;





  procedure TForm1.barraviajaChange(Sender: TObject);
begin

Showmessage('PULSA EN EL BOTÓN VIAJAR PARA IR A '+ ciudadestexto[barraviaja.Position]);

if barraviaja.Position=ciudadactual then

ciudad2.Caption:=' >>> elige una ciudad destino para viajar con la barra inferior.'
else
ciudad2.Caption:='¿viajar a...?'+ciudadestexto[barraviaja.Position];

end;

procedure TForm1.bhelpClick(Sender: TObject);
begin
iform.ShowModal;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
contenedor1.TabIndex:=0;
end;

procedure TForm1.bnewgameClick(Sender: TObject);
begin

Start0;

end;

procedure TForm1.botonviajaClick(Sender: TObject);
begin
if barraviaja.Position<>ciudadactual then Viajar(barraviaja.Position) else
 ShowMessage('>>> elige una ciudad destino para viajar con la barra inferior.!');


end;

procedure TForm1.calendar1Click(Sender: TObject);
begin
Curro;
PasaTurnoDia;
RellenaPantalla;
end;

procedure TForm1.Cars1Click(Sender: TObject);
begin
//formvehiculos.ShowModal;
end;



  procedure TForm1.ciudad2Click(Sender: TObject);
begin
if barraviaja.Position<>ciudadactual then Viajar(barraviaja.Position) else
 ShowMessage('>>> elige una ciudad destino para viajar con la barra inferior.!');
end;

procedure TForm1.dinerotxtClick(Sender: TObject);
begin
contenedor1.TabIndex:=1;
end;

procedure TForm1.empresatxtClick(Sender: TObject);
begin

ShowMessage('Trabajas en la empresa '+nomempresa);

end;

procedure TForm1.fondoClick(Sender: TObject);
begin

Start0;

end;

procedure TForm1.fondohelpClick(Sender: TObject);
begin
iform.ShowModal;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
sTART;
end;

procedure TForm1.imagenmapaClick(Sender: TObject);
begin
contenedor1.TabIndex:=2;
end;

procedure TForm1.mapa2Click(Sender: TObject);
var i: integer;
begin

i:=barraviaja.Max;

if barraviaja.Position<i then barraviaja.Position:=barraviaja.Position+1
                         else barraviaja.Position:=0;





end;

procedure TForm1.menu1Click(Sender: TObject);
begin
iform.ShowModal;

end;

(*
  buy
  *)
procedure TForm1.ToolButton1Click(Sender: TObject);
begin
formcompras.show;
end;

  procedure TForm1.ToolButton3Click(Sender: TObject);
begin
contenedor1.ActivePageIndex:=1;

end;

(*
  boton pasa turno
  *)
procedure TForm1.ToolButton4Click(Sender: TObject);
begin
Curro;
PasaTurnoDia;
RellenaPantalla;
  //listaturno.Items[1].checked:=true;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
VAR
c: string;
begin

Ayuda;

end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
contenedor1.ActivePageIndex:=0;
end;

end.
