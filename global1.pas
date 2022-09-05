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
  FireDAC.Phys.SQLiteWrapper.Stat;

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


  // tabla Pisos
  TPisos= record

    idpiso,
  anyo,
  averia,
  calidad,
  precio,
  precioventa,
  estado, propietario,
  numerocalle, piso, letra,
  calidadbarrio, habitaciones, m2 : integer;

  nombrecalle,
  barrio,
  modelo,
  foto,
  fotosalpicadero: string;
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
  averia,
  motor,
  ruedas,
  precio,
  precioventa,
  estado, propietario: integer;

  nombrecoche,
  matricula,
  modelo,
  foto,
  fotosalpicadero: string;







            end;

      procedure InicializaVariables;

      procedure PasaTurnoP;
      procedure PasaTurno;

      procedure CargarBases;
      procedure CargarGastos;

       procedure CompraVehiculo(tipo: string; id: integer);
      procedure GuardaVehiculo(id: integer);

      function Dimesueldo: integer;
      procedure PasaMes;

      procedure RecalculaValores;




const
 ciudadesTexto: array  [1..4] of string = ('madrid','barcelona','valencia','malaga');
  // expresa si tiene piso en la ciudad (1-4)
 alojamientociudad:array  [1..4] of integer =(0,0,0,0);

var
  FGlobal1: TFGlobal1;
    coches: array[1..75] of TCoches;
    pisos: array[1..75] of TPisos;
    trabajos: array[1..75] of TTrabajos;
    gastos: array[1..75] of TGastos;




  ruta: string;  // C:\Users\lv1\Desktop\YPROW\
  rutajpg: string='C:\Users\lv1\Desktop\YPROW\graf';
  rutajpgcoches: string='C:\Users\lv1\Desktop\YPROW\graf\cochesjpg\';



  // Variables del Juego

    days: array[1..7] of string;
  idjuego, idciudadactual, dinero, experiencia, power,
  diasemana,   // 1-7 L a D
  ingresoturn, // ingreso y gasto por turno
  gastoturn,
  numerovehiculos,
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
 Se produce un Evento, que puede ser ingreso+ o gasto, por sorteo
 Aquí se van:
 - sumando beneficios o gastos
*)
procedure Evento;
var
ran, r2: integer;
begin

// añadir eventos a tabla

ran:=Random(2000);
r2:=random(10);

// se sortea, y gasto
if r2<2 then Begin
ShowMessage('Pago del IBI, te cobran '+inttostr(ran));
gastoturn:=gastoturn+ran;
             End;

// se sortea, e ingresas
if r2>8 then Begin
ShowMessage('Te encuentras un maletin con '+inttostr(ran));
ingresoturn:=ingresoturn+ran;
             End;

end;


(*
Aloja al jugador en un hotel, o en piso (si dispone de él)
 Aquí se van:
 - restando el coste del hotel
 -- se utiliza alojamientociudad
*)
procedure Alojamiento(city: integer);
begin
     if alojamientociudad[city]=0 then
                     begin
  i:=Random(100)+50;
  ShowMessage('No tienes piso en la ciudad, gastas en Hotel '+inttostr(i)+'euros');
                     end else
   ShowMessage('Llegas a tu piso');


                     gastoturn:=gastoturn+i;
                     dinero:=dinero-i;
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
 - recalculando el valor de las propiedades (coches, pisos, cosas)
*)
procedure RecalculaValores;
var
i, x, y, m, z, w, resultado: integer;
begin

// RECALCULA VALOR COCHES
for i := 1 to numerovehiculos do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

z:=coches[i].mes;
resultado:=-(y-coches[i].anyo+z);

resultado:=resultado-coches[i].averia;
resultado:=resultado-coches[i].ruedas;
resultado:=resultado-coches[i].estado;


ShowMessage(coches[i].nombrecoche+'='+inttostr(resultado));


                                 end;

(*
valores.Cells[1,1]:=coches[id].mes.ToString;
valores.Cells[1,2]:=coches[id].anyo.ToString;
valores.Cells[1,3]:=coches[id].km.ToString;
valores.Cells[1,4]:=coches[id].precio.ToString;
valores.Cells[1,5]:=coches[id].precioventa.ToString;
valores.Cells[1,6]:=coches[id].nombrecoche;
valores.Cells[1,7]:=coches[id].matricula;
valores.Cells[1,8]:=coches[id].modelo;
valores.Cells[1,9]:=coches[id].averia.ToString;
valores.Cells[1,10]:=coches[id].motor.ToString;
valores.Cells[1,11]:=coches[id].ruedas.ToString;
                       *)

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

RecalculaValores;

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
  fglobal1.FDTable1.Connection.Params.Database:=ruta+'baseY.db';
end;




      (*
  ---CompraVehiculo
  -compra un vehiculo en el formulario de vehiculos
  *)
 procedure CompraVehiculo(tipo: string; id: integer);
  begin



    if tipo='vehiculo' then coches[id].propietario:=1;  //1 en "propietario" en coche[id]
    coches[id].idcoche:=id;
     dinero:=dinero-coches[id].precio;
     GuardaVehiculo(id);
     ShowMessage('comprado');

     PasaTurnoP;



  end;

 (*
 GuardaVehiculo--
 -guarda los datos del vehiculo existente, con el id
*)
procedure GuardaVehiculo(id: integer);
var
i, j, c: word;
begin

    with fglobal1 do Begin
       fdtable1.Active:=false;
fdtable1.TableName:= 'coches';
fdtable1.Filter := 'id='+inttostr(id);
fdtable1.Filtered := True;
fdtable1.Active:=true;
fdtable1.Edit;

DecodeDate(fechajuego, i,j,c);
ShowMessage(inttostr(i));
  global1.coches[id].anyo:=i;
          (*
    fechacompra: Tdate;
    idcoche,
  km,
  anyo,
  averia,
  otro,
  motor,
  ruedas,
  precio,
  estado, propietario: integer;

  nombrecoche,
  matricula,
  modelo,
  foto,
  fotosalpicadero: string;   *)

  fdtable1.FieldByName('nombrecoche').value:=coches[id].nombrecoche;
  fdtable1.FieldByName('id').value :=id;
  fdtable1.FieldByName('propietario').value:=global1.coches[id].propietario;
    fdtable1.FieldByName('anyo').value:=i;
 // fdtable1.FieldByName('precio').value:=global1.coches[id].precio;
   //  global1.coches[i].foto:=rutajpgcoches+fdtable1.FieldByName('foto').value:=;

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
 - carga la info de las BD: vehiculos=coches, trabajos=trabajos
*)
procedure CargarBases;
var
i, j, c: integer;
str: string;
begin

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
global1.coches[i].averia:=fdtable1.FieldByName('averia').AsInteger;
global1.coches[i].motor:=fdtable1.FieldByName('motor').AsInteger;
global1.coches[i].ruedas:=fdtable1.FieldByName('ruedas').AsInteger;
global1.coches[i].precio:=fdtable1.FieldByName('precio').AsInteger;
global1.coches[i].precio:=fdtable1.FieldByName('precioventa').AsInteger;
global1.coches[i].estado:=fdtable1.FieldByName('estado').AsInteger;
global1.coches[i].propietario:=fdtable1.FieldByName('propietario').AsInteger;



     global1.coches[i].nombrecoche :=fdtable1.FieldByName('nombrecoche').AsString;
     global1.coches[i].matricula :=fdtable1.FieldByName('matricula').AsString;
     global1.coches[i].modelo :=fdtable1.FieldByName('modelo').AsString;
     global1.coches[i].foto:=rutajpgcoches+fdtable1.FieldByName('foto').AsString;
     global1.coches[i].fotosalpicadero :=fdtable1.FieldByName('fotosalpicadero').AsString;


               fdtable1.Next;

                    end;     // end coches

 (*
 trabajos
 *)
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




                End; // end fglobal

end;












end.
