unit global1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DateUtils,
  Data.DB,  StrUtils, Math, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.IOUtils;

type
  TFGlobal1 = class(TForm)
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

    // tabla TGastosIngresos
    // si es negativo es gasto, positivo = ingreso
  TGastosIngresos= record
    id,
  precio: integer;
  nombre: string;
            end;


            (*
            CREATE TABLE "pisos" (

            *)



          // tabla trabajos
  TTrabajos= record
  id,
	sueldo,
	nivelrequerido,
	contratado,
  mescontratado,
  anyocontratado: integer;
    nombrepuesto: string;
  end;


  // tabla Coches
  TCoches= record

    idcoche,
  km,
  mes,
  anyo,
  anyodisponible,
  motor,
  ruedas,
  precio,
  preciocompra,
   precioofrecido,
  mescompra,
  anyocompra,
  estado, propietario,
  alaventa, ciudad: integer;

  nombrecoche,
  matricula,
  modelo,
  foto,
 // foto2,
  fotosalpicadero: string;
  end;





    // tabla Objetos
  TObjetos= record
  id,
  mes,
  anyo,
  averia,
  precio,
  preciocompra,
  mescompra,
  anyocompra,
  estado,
  tipo,     // 1-consola 2-portatil
  propietario: integer;

  nombre,
  foto: string;
            end;

      procedure InicializaVariables;

      procedure Curro;

      procedure PasaTurnoDia;
      procedure PasaTurnoSemana;
      procedure PasaTurnoMes;

      procedure CargarBases;
      procedure CargarGastos;

      procedure AnyadeGasto(nom: string; ran: integer);

       procedure CompraObjeto(tipo: string; id: integer);
        procedure VendeObjeto(id: integer);

      procedure Guarda(tipo: string; id: integer);

      function Dimesueldo: integer;

      procedure RecalculaValoresCoches(tipo: integer);

      procedure MensajeCoolbar(c: string);

      procedure Ayuda;
      procedure AyudaBuy;


const
 ciudadesTexto: array  [1..4] of string = ('madrid','barcelona','valencia','malaga');
  // expresa si tiene piso en la ciudad (1-4)
 alojamientociudad:array  [1..4] of integer =(0,0,0,0);

var
  FGlobal1: TFGlobal1;
    coches: array[1..75] of TCoches;

  //  objetos: array[1..75] of TObjetos;

    trabajos: array[1..75] of TTrabajos;
    gastosingresos: array[1..75] of TGastosIngresos;




  ruta: string;  // C:\Users\lv1\Desktop\YPROW\
  rutajpg: string='C:\Users\lv1\Desktop\YPROW\graf';
  rutajpgcoches: string='C:\Users\lv1\Desktop\YPROW\graf\cochesjpg\';
  rutajpgpisos: string;



  // VARIABLES del Juego

    days: array[1..7] of string;
  idjuego, idciudadactual, dinero, experiencia, power,
  numerogastos,
  diasemana,   // 1-7 L a D
  ingresoturn, // ingreso y gasto por turno
  gastoturn,
  numerovehiculos,
  numeropisos,
  numerotrabajos,
  ciudadactual,
  sueldoactual:      // 1-madrid, 2-barcelona, 3-valencia, 4-malaga

            integer;

  fechajuego: tdatetime;
  diasemanastr, numdiastr, messtr: string;
  nomjugador, nomempresa, hora: string;

  juegoempezado: boolean;

  // Cada TURNO esta formado por 7 TurnoParte
  TurnoParte1, Turno, i: integer;



implementation

{$R *.dfm}

uses Unit1;


(*
            muestra un mensaje de ayuda
*)
procedure Ayuda;
var c: string;
begin
if ciudadactual>1 then ciudadactual:=1;

  c:='Trabajas en la empresa '+nomempresa+'. Estás ahora mismo en '+ciudadestexto[ciudadactual];
c:=c+'## Para continuar, puedes TRABAJAR, o COMPRAR COCHES, o VIAJAR ##';
ShowMessage(c);
end;


procedure AyudaBuy;
var c: string;
begin

Showmessage('AQUÍ PUEDES COMPRAR COCHES O VENDER EL TUYO.');

Showmessage('UTILIZA LOS ICONOS ROJOS PARA DESPLAZARTE POR LOS COCHES DISPONIBLES. PARA COMPRAR PULSA EN COMPRAR COCHE (para vender VENDER MI COCHE)');
end;



(*
            decodifica la fecha
*)
procedure DecodificaFecha(f: TDateTime);
var
    myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;

  days: array[1..7] of string;
  mes: array[1..12] of string;

begin
  days[7] := 'Sunday';
  days[1] := 'Monday';
  days[2] := 'Tuesday';
  days[3] := 'Wednesday';
  days[4] := 'Thursday';
  days[5] := 'Friday';
  days[6] := 'Saturday';

  mes[1] := 'Enero';
  mes[2] := 'febrero';
  mes[3] := 'marzo';
  mes[4] := 'abril';
  mes[5] := 'mayo';
  mes[6] := 'junio';
  mes[7] := 'julio';
  mes[8] := 'agosto';
  mes[9] := 'septiembre';
  mes[10] := 'octubre';
  mes[11] := 'noviembre';
  mes[12] := 'diciembre';

  decodedatetime(f, myYear, myMonth, myDay,
                 myHour, myMin, mySec, myMilli);


                 // r
 diasemanastr:=days[fechajuego.DayOfTheWeek];
numdiastr:=fechajuego.DayOfTheMonth.ToString;
messtr:=mes[fechajuego.Month];

end;


(*
MensajeCoolbar
- rellena la coolbar con un mensaje
*)
procedure MensajeCoolbar(c: string);
var x: integer;
begin

x:=random(10);

        form1.memoeventos.Lines.Add(fechajuego.ToString+'> '+c);
        form1.StatusBar1.Panels[0].Text:=c;



end;


(*
 Se produce un Evento, que puede ser ingreso+ o gasto, por sorteo
 Aquí se van:
 - sumando beneficios o gastos
*)
function Evento: string;
var
ran, r2: integer;
c: string;
begin

// añadir eventos a tabla

ran:=Random(2000);
r2:=random(10);

// se sortea, y gasto
if r2<2 then Begin
c:='Pago del IBI, te cobran '+inttostr(ran);
AnyadeGasto(c, ran);

             End;

// se sortea, e ingresas
if r2>8 then Begin
c:='Te encuentras un maletin con '+inttostr(ran);
AnyadeGasto(c, ran);

             End;

             MensajeCoolbar(c);

end;



(*
AnyadeGasto
  -- añade un gasto (tabla)
 -- resta del dinero
*)
procedure AnyadeGasto(nom: string; ran: integer);
var
c: string;
i, valor: integer;
begin

i:=Min(0, ran);

if i=0 then Begin  // es positivo = ingreso
  ingresoturn:=ingresoturn+ran;


            End else
            // es gasto
                      Begin

            gastoturn:=gastoturn+ran;

                      End;





  numerogastos:=numerogastos+1;
i:=numerogastos;

gastosingresos[i].id:=i;
gastosingresos[i].nombre:=nom;
gastosingresos[i].precio:=ran;

dinero:=dinero+ran;


end;




(*
Aloja al jugador en un hotel, o en piso (si dispone de él)
 Aquí se van:
 - restando el coste del hotel
 -- se utiliza alojamientociudad
*)
function Alojamiento(city: integer): string;
var
c, msg: string;
begin
     if alojamientociudad[city]=0 then

     // gastas hotel
                     begin
  i:=-(Random(100)+50);
  msg:='Día de trabajo & ';
  msg:=msg+'Gastas en Hotel '+inttostr(i)+'euros';
  c:='Hotel Gran Via';
                     end else
                     // no gastas, tienes piso
   msg:='Llegas a tu piso';

                     AnyadeGasto(c, i);


                     MensajeCoolbar(msg);
end;


(*
 Devuelve el sueldo del trabajo actual
*)
function Dimesueldo: integer;
begin

result:=500;

end;




(*
 RecalculaValores
 Aquí se van:
 - recalculando el valor de las propiedades (coches)
recalcula según el estado del coche y paso de tiempo
 además random
*)
procedure RecalculaValoresCoches(tipo: integer);
var
a, e, i, x, y, m, z, w, r,r2, pco, resultado: integer;
pcf: double;

begin
x:=fechajuego.Month;
y:=fechajuego.Year;


// RECALCULA VALOR COCHES POR PASO TIEMPO Y ESTADO
for i := 1 to numerovehiculos do begin

// solo recalcula coches a la venta
if (y>=coches[i].anyo) AND (coches[i].anyodisponible>=coches[i].anyo)  then
                                   BEGIN
a:=coches[i].anyo;
pco:=coches[i].precio;
e:=coches[i].estado; // % de buen estado


(* DEVALUATION -------------------
----------------------------------
*)

e:=e-5; // devalúa coche por paso del tiempo

// añade una devaluación o reval. extra, de manera aleatoria
if tipo=2  then Begin
r:=Random(100); r2:=Random(40);
if r>70 then e:=e+r2 else e:=e-r2;
                End;



pcf:=pco*e; // el % de buen estado es el precio que queda
pcf:=pcf/100;

//***************** precio final

coches[i].precio:=Trunc(pcf);

//precio ofertado según random
z:=Trunc(coches[i].precio/3); // solo variamos el precio como máx 1/3 del valor

x:=Random(z);
y:=Random(10);

if y<5 then x:=-x; // se ofrece menos


coches[i].precioofrecido:=coches[i].precio+x;
                                   END;

                                 end;


end;



(*
 Curro
Curra un dia
*)
procedure Curro;
var
cad: array[1..10] of string;
x: integer;
begin

RecalculaValoresCoches(1);

cad[1]:='currando un dia en tu ciudad. No hay Novedad';
cad[2]:='Paseando por la city despúes del curro.No hay Novedad';
cad[3]:='Tempus fugit';
cad[4]:='Otro día más, o menos';
cad[4]:='8 horas de trabajo; continue';

x:=Random(4)+1;

ShowMessage(cad[x]);

//  if .. Evento

end;





(*
 Pasa un MES
 Aquí se van:
 - sumando beneficios y gastos
*)
procedure PasaTurnoMes;
begin

ingresoturn:=ingresoturn+sueldoactual;

Evento;

fechajuego := fechajuego+1;
DecodificaFecha(fechajuego);

//RecalculaValoresCoches(1);

          //  dinero:=dinero+ingresoturn;
          //   dinero:=dinero-gastoturn;


end;


(*
 Pasa un DIA dentro del Turno 1 semanal L-D (7 partes)
 Aquí se van:
 - sumando beneficios y gastos
*)
procedure PasaTurnoDia;
begin

//Showmessage(inttostr(fechajuego.DayOfTheWeek));
   diasemana:=diasemana+1;
   if fechajuego.DaysInMonth=fechajuego.Day then PasaTurnoMes // si es fin de mes, pasa el mes
     else
   if fechajuego.DayOfTheWeek=7 then PasaTurnoSemana // si es domingo, pasa turno semanal
                                else
          fechajuego := fechajuego+1; // si no pasa, sigue otro dia


DecodificaFecha(fechajuego);

// Gastos/Ingresos del Dia (alojamiento)
Alojamiento(ciudadactual);


end;



(*
 FIN del Turno SEMANA (7 partes), actualizando los datos
*)
procedure PasaTurnoSemana;
begin


Evento;
RecalculaValoresCoches(1);

fechajuego := fechajuego+1;
DecodificaFecha(fechajuego);

diasemana:=1;


         //   ingresoturn:=ingresoturn-gastoturn;
         //   dinero:=dinero+ingresoturn;
end;



      (*
  ---Variables
  -carga ciertas variables útiles.
  ruta
  *)
procedure InicializaVariables;
begin
ciudadactual:=1;

  ruta:=ExcludeTrailingPathDelimiter(ExtractFileDir(ExtractFilePath(paramstr(0))));
ruta:=ExcludeTrailingPathDelimiter( ExtractFileDir(ExtractFilePath(ruta)) );
ruta:=ExcludeTrailingPathDelimiter( ExtractFileDir(ExtractFilePath(ruta)) )+'\';   // ruta buena
  rutajpg:=ruta+'graf\';
  rutajpgcoches:=ruta+'graf\cochesjpg\';
    rutajpgpisos:=ruta+'graf\pisosjpg\';
  fglobal1.FDTable1.Connection.Params.Database:=ruta+'baseY.db';
  fglobal1.FDTable1.Active:=true;

end;




      (*
  ---Compra
  -compra un coche
  *)
 procedure CompraObjeto(tipo: string; id: integer);
 var
 i: integer;
  begin



          if dinero<coches[id].precio then
          Begin Showmessage('NO TIENES SUFICIENTE DINERO'); exit; end;


     Guarda('compra',id);

      PasaTurnoDia;

  end;






      (*
  ---venta
  -vende un coche
  *)
 procedure VendeObjeto(id: integer);
 var
 i: integer;
  begin

     Guarda('venta',id);

   Showmessage('Vendes tu coche a OCASIONCARS');

      PasaTurnoDia;

  end;


 (*
 Guarda--
 -guarda un objeto existente, (coches) con el id
 tipo='compra' / 'venta'
*)
procedure Guarda(tipo: string; id: integer);
var
i, j, c: word;
cad: string;
begin

    with fglobal1 do Begin

    (*        // COMENTADO PORQ DE MOMENTO NO QUEREMOS GUARDAR EN LA BD

       fdtable1.Active:=false;
fdtable1.TableName:= tipo;
fdtable1.Filter := 'id='+inttostr(id);
fdtable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.Edit;
*)

DecodeDate(fechajuego, i,j,c);
//ShowMessage(inttostr(i));

case IndexStr(tipo, ['compra','venta'] ) of
   0: begin

        ShowMessage('Has comprado un coche. Modelo:'+coches[id].nombrecoche+', por: '+inttostr(coches[id].preciocompra));

   //rellenar coches[id]
   coches[id].propietario:=1;  //1 en "propietario" en coche[id]
   coches[id].preciocompra:=coches[id].precio;
   dinero:=dinero-coches[id].precio;

          (*
   fdtable1.FieldByName('id').value:=global1.coches[id].idcoche;
   fdtable1.FieldByName('propietario').value:=global1.coches[id].propietario;
  fdtable1.FieldByName('precio').value:=global1.coches[id].precio;
  fdtable1.FieldByName('estado').value:=global1.coches[id].estado;
  fdtable1.FieldByName('preciocompra').value:=global1.coches[id].preciocompra;
  fdtable1.FieldByName('mescompra').value:=fechajuego.Month;
  fdtable1.FieldByName('anyocompra').value:=fechajuego.Year;
  fdtable1.FieldByName('ciudad').value:=global1.coches[id].ciudad;
  *)

      end;


   1: begin
      coches[id].propietario:=0;  //1 en "propietario" en coche[id]
   coches[id].precio:=coches[id].preciocompra+Trunc(coches[id].preciocompra/2);
   dinero:=dinero+coches[id].precioofrecido;

       end;
end;
 // end case


fdtable1.Edit;
fdtable1.post;
                 end;
end;





(*
 CargarGastos--
 - carga la info de los gastos en la tabla gastos
*)
procedure CargarGastos;
var
i, j, c: integer;
begin

with fglobal1 do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'gastos';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
//FDTable1.Filter := 'idcoche>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.UpdateTransaction;

c:=fdtable1.RecordCount;
numerogastos:=c;

for i := 1 to c do begin

     global1.gastosingresos[i].id:=fdtable1.FieldByName('id').AsInteger;
     global1.gastosingresos[i].nombre:=fdtable1.FieldByName('nombre').AsString;
        global1.gastosingresos[i].precio:=fdtable1.FieldByName('precio').AsInteger;

               fdtable1.Next;


                    end;




                End;

end;



(*
 CargarBases--
 - carga la info de las BD: coches, pisos
 **************************************************************
*)
procedure CargarBases;
var
i, j, c: integer;
str: string;
begin

// CARGA COCHES ----------------------------------


with fglobal1 do Begin


fdtable1.Active:=false;
fdtable1.TableName:= 'coches';


FDTable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.UpdateTransaction;

c:=fdtable1.RecordCount;
numerovehiculos:=c;
//numerocamiones:=c;

for i := 1 to c do begin


      global1.coches[i].idcoche:=fdtable1.FieldByName('id').AsInteger;
      global1.coches[i].km:=fdtable1.FieldByName('km').AsInteger;
      global1.coches[i].mes:=fdtable1.FieldByName('mes').AsInteger;
global1.coches[i].anyo:=fdtable1.FieldByName('anyo').AsInteger;
global1.coches[i].motor:=fdtable1.FieldByName('motor').AsInteger;
global1.coches[i].ruedas:=fdtable1.FieldByName('ruedas').AsInteger;
global1.coches[i].precio:=fdtable1.FieldByName('precio').AsInteger;
global1.coches[i].preciocompra:=fdtable1.FieldByName('preciocompra').AsInteger;
global1.coches[i].mescompra:=fdtable1.FieldByName('mescompra').AsInteger;
global1.coches[i].anyocompra:=fdtable1.FieldByName('anyocompra').AsInteger;
global1.coches[i].estado:=fdtable1.FieldByName('estado').AsInteger;
global1.coches[i].propietario:=fdtable1.FieldByName('propietario').AsInteger;
global1.coches[i].alaventa:=fdtable1.FieldByName('alaventa').AsInteger;
global1.coches[i].anyodisponible:=fdtable1.FieldByName('anyodisponible').AsInteger;
global1.coches[i].ciudad:=fdtable1.FieldByName('ciudad').AsInteger;


     global1.coches[i].nombrecoche :=fdtable1.FieldByName('nombrecoche').AsString;
     global1.coches[i].matricula :=fdtable1.FieldByName('matricula').AsString;
     global1.coches[i].modelo :=fdtable1.FieldByName('modelo').AsString;
     global1.coches[i].foto:=rutajpgcoches+fdtable1.FieldByName('foto').AsString;
     global1.coches[i].fotosalpicadero :=fdtable1.FieldByName('fotosalpicadero').AsString;


               fdtable1.Next;

                    end;     // end coches







 (*
 CARGA TRABAJOS---------------------------------------------

                                     // end
fdtable1.Active:=false;
fdtable1.TableName:= 'trabajos';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
//FDTable1.Filter := 'idcoche>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.UpdateTransaction;

c:=fdtable1.RecordCount;
numerotrabajos:=c;
//numerocamiones:=c;

for i := 1 to c do begin


global1.trabajos[i].id:=fdtable1.FieldByName('id').AsInteger;
global1.trabajos[i].sueldo:=fdtable1.FieldByName('sueldo').AsInteger;
global1.trabajos[i].nivelrequerido:=fdtable1.FieldByName('nivelrequerido').AsInteger;
global1.trabajos[i].nombrepuesto:=fdtable1.FieldByName('nombrepuesto').AsString;
global1.trabajos[i].contratado:=fdtable1.FieldByName('contratado').AsInteger;
global1.trabajos[i].mescontratado:=fdtable1.FieldByName('mescontratado').AsInteger;
global1.trabajos[i].anyocontratado:=fdtable1.FieldByName('anyocontratado').AsInteger;

               fdtable1.Next;


                    end;  // end trabajos

             *)



                End; // end fglobal

end;
(*
*****
FIN CargarBases -----
*****
*)












end.
