unit global1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DateUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.TDBX, FireDAC.Phys.TDBXDef, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, StrUtils;

type
  TFGlobal1 = class(TForm)
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

    // tabla Gastos
  TGastos= record
    id,
  precio: integer;
  nombre,foto: string;
            end;


            (*
            CREATE TABLE "pisos" (

            *)
  // tabla Pisos
  TPisos= record

	id,
  portal,
	planta,
  ciudad,
	calidadbarrio,
	metros,
	dormitorios,
banyos,
	calidad,
mes,
anyo,
	preciocompra,
	mescompra,
	anyocompra,
	estado,
	precio,
	alquiler,
	propietario,
	rentador,
	foto2,
	foto3: integer;

calle,
	letra,
	barrio,
  	foto: string;
          end;



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

      procedure PasaTurnoP;
      procedure PasaTurno;

      procedure CargarBases;
      procedure CargarGastos;

       procedure Compra(tipo: string; id: integer);
      procedure Guarda(tipo: string; id: integer);

      function Dimesueldo: integer;
      procedure PasaMes;

      procedure RecalculaValoresCoches(tipo: integer);

      procedure MensajeCoolbar(c: string);


const
 ciudadesTexto: array  [1..4] of string = ('madrid','barcelona','valencia','malaga');
  // expresa si tiene piso en la ciudad (1-4)
 alojamientociudad:array  [1..4] of integer =(0,0,0,0);

var
  FGlobal1: TFGlobal1;
    coches: array[1..75] of TCoches;
    pisos: array[1..75] of TPisos;
  //  objetos: array[1..75] of TObjetos;

    trabajos: array[1..75] of TTrabajos;
    gastos: array[1..75] of TGastos;




  ruta: string;  // C:\Users\lv1\Desktop\YPROW\
  rutajpg: string='C:\Users\lv1\Desktop\YPROW\graf';
  rutajpgcoches: string='C:\Users\lv1\Desktop\YPROW\graf\cochesjpg\';
  rutajpgpisos: string;



  // VARIABLES del Juego

    days: array[1..7] of string;
  idjuego, idciudadactual, dinero, experiencia, power,
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

  // Cada TURNO esta formado por 7 TurnoParte
  TurnoParte1, Turno, i: integer;



implementation

{$R *.dfm}

uses Unit1;

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
gastoturn:=gastoturn+ran;
             End;

// se sortea, e ingresas
if r2>8 then Begin
c:='Te encuentras un maletin con '+inttostr(ran);
ingresoturn:=ingresoturn+ran;
             End;

             MensajeCoolbar(c);

end;





(*
Aloja al jugador en un hotel, o en piso (si dispone de él)
 Aquí se van:
 - restando el coste del hotel
 -- se utiliza alojamientociudad
*)
function Alojamiento(city: integer): string;
var
c: string;
begin
     if alojamientociudad[city]=0 then
                     begin
  i:=Random(100)+50;
  c:='No tienes piso en la ciudad, gastas en Hotel '+inttostr(i)+'euros';
                     end else
   c:='Llegas a tu piso';


                     gastoturn:=gastoturn+i;
                     dinero:=dinero-i;
                     MensajeCoolbar(c);
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
 1: recalcula según el estado del coche y paso de tiempo
 2: recalcula según 1 y además random
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
pco:=coches[i].preciocompra;
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

coches[i].preciocompra:=Trunc(pcf);
                                   END;

                                 end;






end;


(*
 Pasa un MES
 Aquí se van:
 - sumando beneficios y gastos
*)
procedure PasaMes;
begin

ingresoturn:=ingresoturn+sueldoactual;

Evento;

fechajuego := fechajuego+1;
DecodificaFecha(fechajuego);

RecalculaValoresCoches(1);

            dinero:=dinero+ingresoturn;
            dinero:=dinero-gastoturn;


end;


(*
 Pasa un DIA dentro del Turno 1 semanal L-D (7 partes)
 Aquí se van:
 - sumando beneficios y gastos
*)
procedure PasaTurnoP;
begin

//Showmessage(inttostr(fechajuego.DayOfTheWeek));
   diasemana:=diasemana+1;
   if fechajuego.DaysInMonth=fechajuego.Day then PasaMes
     else
   if fechajuego.DayOfTheWeek=7 then PasaTurno // si es domingo, pasa turno semanal
                                else
          fechajuego := fechajuego+1; // si no pasa, sigue otro dia


DecodificaFecha(fechajuego);

Alojamiento(ciudadactual);

         //   ingresoturn:=1500;
        //    gastoturn:=Random(800);

         //   ingresoturn:=ingresoturn-gastoturn;
         //   dinero:=dinero+ingresoturn;
end;



(*
 FIN del Turno SEMANA (7 partes), actualizando los datos
*)
procedure PasaTurno;
begin


Evento;
RecalculaValoresCoches(1);

fechajuego := fechajuego+1;
DecodificaFecha(fechajuego);

diasemana:=1;


            ingresoturn:=ingresoturn-gastoturn;
            dinero:=dinero+ingresoturn;
end;



      (*
  ---Variables
  -carga ciertas variables útiles.
  ruta
  *)
procedure InicializaVariables;
begin
  ruta:=ExcludeTrailingPathDelimiter(ExtractFileDir(ExtractFilePath(paramstr(0))));
ruta:=ExcludeTrailingPathDelimiter( ExtractFileDir(ExtractFilePath(ruta)) );
ruta:=ExcludeTrailingPathDelimiter( ExtractFileDir(ExtractFilePath(ruta)) )+'\';   // ruta buena
  rutajpg:=ruta+'graf\';
  rutajpgcoches:=ruta+'graf\cochesjpg\';
    rutajpgpisos:=ruta+'graf\pisosjpg\';
  fglobal1.FDTable1.Connection.Params.Database:=ruta+'baseY.db';
end;




      (*
  ---Compra
  -compra un piso/coche
  *)
 procedure Compra(tipo: string; id: integer);
 var
 i: integer;
  begin

  if tipo='coches' then i:=0 else i:=1;

  case I of
      0: begin

          if dinero<coches[id].precio then
          Begin Showmessage('NO TIENES SUFICIENTE DINERO'); exit; end;

              coches[id].propietario:=1;  //1 en "propietario" en coche[id]
              coches[id].preciocompra:=coches[id].precio;

  //  coches[id].idcoche:=id;
     dinero:=dinero-coches[id].precio;
     Guarda('coches',id);
     ShowMessage('coche comprado');
      PasaTurnoP;

                  end;

      1: begin


          if dinero<pisos[id].preciocompra then
          Begin Showmessage('NO TIENES SUFICIENTE DINERO'); exit; end;

              pisos[id].propietario:=1;  //1 en "propietario" en coche[id]
              pisos[id].preciocompra:=pisos[id].precio;

    //pisos[id].idcoche:=id;
     dinero:=dinero-pisos[id].preciocompra;
     Guarda('pisos',id);
     ShowMessage('piso comprado');
      PasaTurnoP;

              end;

  end;






  end;

 (*
 Guarda--
 -guarda un objeto existente, (coches pisos ) con el id
*)
procedure Guarda(tipo: string; id: integer);
var
i, j, c: word;
begin

    with fglobal1 do Begin
       fdtable1.Active:=false;
fdtable1.TableName:= tipo;
fdtable1.Filter := 'id='+inttostr(id);
fdtable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.Edit;

DecodeDate(fechajuego, i,j,c);
//ShowMessage(inttostr(i));

case IndexStr(tipo, ['coches','pisos'] ) of
   0: begin
   fdtable1.FieldByName('propietario').value:=global1.coches[id].propietario;
  fdtable1.FieldByName('precio').value:=global1.coches[id].precio;
  fdtable1.FieldByName('estado').value:=global1.coches[id].estado;
  fdtable1.FieldByName('preciocompra').value:=global1.coches[id].preciocompra;
  fdtable1.FieldByName('mescompra').value:=fechajuego.Month;
  fdtable1.FieldByName('anyocompra').value:=fechajuego.Year;
  fdtable1.FieldByName('ciudad').value:=global1.coches[id].ciudad;
      end;


   1: begin
  fdtable1.FieldByName('propietario').value:=global1.pisos[id].propietario;
  fdtable1.FieldByName('precio').value:=global1.pisos[id].precio;
  fdtable1.FieldByName('estado').value:=global1.pisos[id].estado;
  fdtable1.FieldByName('preciocompra').value:=global1.pisos[id].preciocompra;
  fdtable1.FieldByName('mescompra').value:=global1.pisos[id].mescompra;
  fdtable1.FieldByName('anyocompra').value:=global1.pisos[id].anyocompra;
  fdtable1.FieldByName('ciudad').value:=global1.pisos[id].ciudad;
       end;
end;
 // end case



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
//numerocamiones:=c;

for i := 1 to c do begin

     global1.gastos[i].id:=fdtable1.FieldByName('id').AsInteger;
     global1.gastos[i].nombre:=fdtable1.FieldByName('nombre').AsString;
        global1.gastos[i].precio:=fdtable1.FieldByName('precio').AsInteger;
  //   global1.gastos[i].foto:=rutajpgcoches+fdtable1.FieldByName('foto').AsString;

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
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
//FDTable1.Filter := 'idcoche>'+Quotedstr('0');
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
// CARGA PISOS ----------------------------------

  *)
fdtable1.Active:=false;
fdtable1.TableName:= 'pisos';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
//FDTable1.Filter := 'idcoche>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.UpdateTransaction;

c:=fdtable1.RecordCount;
numeropisos:=c;
//numerocamiones:=c;

for i := 1 to c do begin


global1.pisos[i].id:=fdtable1.FieldByName('id').AsInteger;
global1.pisos[i].portal:=fdtable1.FieldByName('portal').AsInteger;
global1.pisos[i].planta:=fdtable1.FieldByName('planta').AsInteger;
global1.pisos[i].calidadbarrio:=fdtable1.FieldByName('calidadbarrio').AsInteger;
global1.pisos[i].metros:=fdtable1.FieldByName('metros').AsInteger;
global1.pisos[i].dormitorios:=fdtable1.FieldByName('dormitorios').AsInteger;
global1.pisos[i].banyos:=fdtable1.FieldByName('banyos').AsInteger;
global1.pisos[i].calidad:=fdtable1.FieldByName('calidad').AsInteger;
global1.pisos[i].mes:=fdtable1.FieldByName('mes').AsInteger;
global1.pisos[i].anyo:=fdtable1.FieldByName('anyo').AsInteger;
global1.pisos[i].preciocompra:=fdtable1.FieldByName('preciocompra').AsInteger;
global1.pisos[i].mescompra:=fdtable1.FieldByName('mescompra').AsInteger;
global1.pisos[i].anyocompra:=fdtable1.FieldByName('anyocompra').AsInteger;
global1.pisos[i].estado:=fdtable1.FieldByName('estado').AsInteger;
global1.pisos[i].precio:=fdtable1.FieldByName('precio').AsInteger;
global1.pisos[i].ciudad:=fdtable1.FieldByName('ciudad').AsInteger;

global1.pisos[i].alquiler:=fdtable1.FieldByName('alquiler').AsInteger;
global1.pisos[i].propietario:=fdtable1.FieldByName('propietario').AsInteger;
global1.pisos[i].rentador:=fdtable1.FieldByName('rentador').AsInteger;
global1.pisos[i].foto2:=fdtable1.FieldByName('foto2').AsInteger;
global1.pisos[i].foto3:=fdtable1.FieldByName('foto3').AsInteger;

global1.pisos[i].calle:=fdtable1.FieldByName('calle').AsString;
global1.pisos[i].letra:=fdtable1.FieldByName('letra').AsString;
global1.pisos[i].barrio:=fdtable1.FieldByName('barrio').AsString;
global1.pisos[i].foto:=rutajpgpisos+fdtable1.FieldByName('foto').AsString;

               fdtable1.Next;


                    end;  // end pisos

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
