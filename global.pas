unit global;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.StdCtrls, System.IOUtils, DateUtils,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tfglobal = class(TForm)
    FDConnection1: TFDConnection;
    fdtable1: TFDTable;
    ImageControl1: TImageControl;
    FDTable2: TFDTable;

        procedure CargarCiudad;
        procedure CargarCamionesF;
        procedure CargarViajes;
        procedure CargarConductores;
        procedure lresource(var Im1: TImagecontrol; res_name: String);
        procedure CompraCamion(idcam: integer);
        function DimeCiudad(c: integer): string;
        function DimeTabla(tabla, id, valoridstr, campodeseado: string; valorid: integer): string;        function DimeCliente(c: integer): string;
        procedure AsignaCamion(idcamion, idconductor: integer);
        procedure AsignaViaje(idjugador, idviaje: integer);
        function DimeVJugador(varj: String): string;







    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCiudad = record
    idciudad,
  idpais: integer;
  nombre,
  foto: string;
            end;

//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero,idempresa
  TViajes= record
  idviaje,
  kgcarga,
  idciudadorigen,
  idciudaddestino,
  kmtotal,
  kmrecorridos,
  puntosviaje,
  idjugador,
  idconductor,
  idempresa,
  dinero: integer;

    nombrecarga,
    foto: string;
            end;

  //idconductor,foto,energia,nombre,edad,experiencia,sueldomes,idempleador,nacionalidad,resistencia
  Tconductores = record
idconductor, idcamion,
edad,experiencia,sueldomes,idempleador, resistencia, energia: integer;
foto,nombre,nacionalidad: string;
                 end;

  TCamiones= record
  idc,
  idcamion,
  idjugador,
  cv,
  L100,
  tara,
  pma,
  km,
  idconductor,
  anylanzamiento,
  cabina,
  averia,
  otro,
  encendido,
  velocidad,
  idviajeactual,
  idciudadactual,
  provinciaactual,
  posmapa,
  motor,
  chasis,
  suspension,
  carroceria,
  ruedas,
  GASOIL,
  GASOILTOTAL,
  precio,
  estado: integer;

    matricula,
    modelo,
  fechacompra,
  foto,
  fotosalpicadero: string;

            end;

var
  fglobal: Tfglobal;

  camiones: array[1..75] of tcamiones;
  fabrica: array[1..75] of tcamiones;
  viajes: array[1..75] of tviajes;

  ciudades: array[1..75] of tciudad;
  conductores: array[1..75] of tconductores;

  idc, idcon, idviaje, conductoractual, idciudadhq,
  numeroviajes, numerociudades, numerocamiones, numerocamionesjugador, numeroconductores: integer;
  idjuego, idciudadactual, dinero, experiencia, power: integer;

  fechajuego: tdatetime;
  nomjugador, nomempresa, hora: string;
  TurnoActual: integer;



implementation

{$R *.fmx}

function TFGlobal.DimeVJugador(varj: String): string;
var
c: string;
begin


if varj='dinero' then
            begin
        c:=inttostr(dinero);
        c:=formatFloat('#,###', strToFloat(c))+' €';
            end;

Result:=c;

end;


procedure TFGlobal.lresource(var Im1: TImagecontrol; res_name: String);
var
  RStream: TResourceStream;
begin

RStream := TResourceStream.Create(HInstance, res_name, RT_RCDATA);

im1.bitmap.LoadFromStream(Rstream);

  RStream.Free;
end;


procedure TFGlobal.AsignaViaje(idjugador, idviaje: integer);
var
i, idcamviejo: integer;
begin

fdtable2.Active:=false;
fdtable2.TableName:= 'viajes';
FDTable2.Filter := 'idviaje='+inttostr(idviaje);
FDTable2.Filtered := True;
fdtable2.Active:=true;
fdtable2.Edit;
fdtable2.FieldByName('idjugador').Value:=idjugador;
fdtable2.post;

    ShowMessage('Asignando viaje: '+inttostr(idviaje));
end;


procedure TFGlobal.AsignaCamion(idcamion, idconductor: integer);
var
i, idcamviejo: integer;
begin

idcamviejo:=conductores[idconductor].idcamion;
fdtable2.Active:=false;
fdtable2.TableName:= 'camiones';
FDTable2.Filter := 'idcamion='+inttostr(idcamviejo);
FDTable2.Filtered := True;
fdtable2.Active:=true;
fdtable2.Edit;
fdtable2.FieldByName('idconductor').Value:=0;
fdtable2.post;

    ShowMessage('Asignando camión: '+inttostr(idcamion));

fdtable2.Active:=false;
fdtable2.TableName:= 'camiones';
FDTable2.Filter := 'idcamion='+inttostr(idcamion);
FDTable2.Filtered := True;
fdtable2.Active:=true;

fdtable2.Edit;
fdtable2.FieldByName('idconductor').Value:=idconductor;
fdtable2.post;

fdtable1.Active:=false;
fdtable1.TableName:= 'conductores';
FDTable1.Filter := 'idconductor='+inttostr(idconductor);
FDTable1.Filtered := True;
fdtable1.Active:=true;

fdtable1.Edit;
fdtable1.FieldByName('idcamion').Value:=idcamion;
fdtable1.post;


CargarCamionesF;
CargarConductores;

end;




procedure TFGlobal.CompraCamion(idcam: integer);
var
i: integer;
begin

    ShowMessage('Comprando camión: '+inttostr(idcam));

fdtable2.Active:=false;
fdtable2.TableName:= 'fabrica';
FDTable2.Filter := 'idcamion='+inttostr(idcam);
FDTable2.Filtered := True;
fdtable2.Active:=true;

fdtable1.Active:=false;
fdtable1.TableName:= 'camiones';
fdtable1.Active:=true;

FDTable1.Insert;
 for i:=0 to fdtable2.FieldCount-1 do  // Start from 1 to skip the AutoInc
  begin
    if fdtable1.FindField(fdtable2.Fields[i].FieldName) <> nil then
    begin
       if fdtable1.Fields[i].FieldName='precio' then
       dinero:=dinero-fdtable2.Fields[i].Value;

    if fdtable1.Fields[i].FieldName='idjugador' then
       fdtable1.FieldByName('idjugador').Value:=idjuego
        else
       fdtable1.FieldByName(fdtable2.Fields[i].FieldName).Value:=fdtable2.Fields[i].Value;
    end;
  end;
FDTable1.Post;

CargarCamionesF;

//dinero:=dinero-camiones[idc].precio;

//  FDTable1.AppendRecord([idc,camiones[idc].idcamion,'matricula',idjuego,camiones[idc].modelo,camiones[idc].cv,camiones[idc].L100,camiones[idc].tara,camiones[idc].pma,camiones[idc].km,camiones[idc].foto,camiones[idc].fotosalpicadero,camiones[idc].idconductor,camiones[idc].anylanzamiento,camiones[idc].fechacompra,camiones[idc].cabina,camiones[idc].averia,camiones[idc].otro,camiones[idc].encendido,camiones[idc].velocidad,camiones[idc].idviajeactual,camiones[idc].idciudadactual,camiones[idc].provinciaactual,camiones[idc].posmapa,camiones[idc].motor,camiones[idc].chasis,camiones[idc].suspension,camiones[idc].carroceria,camiones[idc].ruedas,camiones[idc].GASOIL,camiones[idc].GASOILTOTAL,camiones[idc].precio,camiones[idc].estado]);
  //idc,idcamion,matricula,idjugador,modelo,cv,L100,tara,pma,km,foto,fotosalpicadero,idconductor,anylanzamiento,fechacompra,cabina,averia,otro,encendido,velocidad,idviajeactual,idciudadactual,provinciaactual,posmapa,motor,chasis,suspension,carroceria,ruedas,GASOIL,GASOILTOTAL,precio,estado

end;



procedure TFGlobal.CargarConductores;
var
i, c: integer;
x: string;
y: integer;
arrciudad : array[1..100, 1..10] of string;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'conductores';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idconductor>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;

c:=fdtable1.RecordCount;
numeroconductores:=c;

for i := 1 to c do begin
               y:=fdtable1.FieldByName('idconductor').AsInteger;
               conductores[i].idconductor:=y;
               conductores[i].idcamion:=fdtable1.FieldByName('idcamion').AsInteger;
  //idconductor,foto,energia,nombre,edad,experiencia,sueldomes,idempleador,nacionalidad,resistencia
               conductores[i].foto:=fdtable1.FieldByName('foto').AsString;
               conductores[i].energia:=fdtable1.FieldByName('energia').AsInteger;
               conductores[i].nombre:=fdtable1.FieldByName('nombre').AsString;
               conductores[i].edad:=fdtable1.FieldByName('edad').AsInteger;
               conductores[i].experiencia:=fdtable1.FieldByName('experiencia').AsInteger;
               conductores[i].sueldomes:=fdtable1.FieldByName('sueldomes').AsInteger;
               conductores[i].idempleador:=fdtable1.FieldByName('idempleador').AsInteger;
               conductores[i].nacionalidad:=fdtable1.FieldByName('nacionalidad').AsString;
               conductores[i].resistencia:=fdtable1.FieldByName('resistencia').AsInteger;
               fdtable1.Next;

                    end;
                End;

end;





procedure TFGlobal.CargarCiudad;
var
i, c: integer;
x: string;
y: integer;
arrciudad : array[1..100, 1..10] of string;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'ciudad';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idciudad>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;

c:=fdtable1.RecordCount;
numerociudades:=c;

for i := 1 to c do begin
               y:=fdtable1.FieldByName('idciudad').AsInteger;
               arrciudad[y][1]:=fdtable1.FieldByName('nombre').AsString;
               arrciudad[y][2]:=fdtable1.FieldByName('foto').AsString;
               fdtable1.Next;

               ciudades[i].idciudad:=y;
               ciudades[i].nombre:=arrciudad[y][1];
               ciudades[i].foto:=arrciudad[y][2];

//               arrciudad[i][1]:=fdtable1.FieldByName('taep-restamo').AsString;
                    end;
                End;

end;





procedure Tfglobal.FDConnection1BeforeConnect(Sender: TObject);
begin
// SOLO MOVIL:
// FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'base1.db');

end;




procedure Tfglobal.FormCreate(Sender: TObject);
var c: integer;
begin
// *******************************************************************
// *******************************************************************
// *******************************************************************
// *******************************************************************

with fglobal do Begin
        idc:=1;
        idviaje:=1;

fdtable1.Active:=false;
fdtable1.TableName:= 'camiones';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idcamion>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;
c:=fdtable1.RecordCount;
numerocamionesjugador:=c;

fdtable1.Active:=false;
fdtable1.TableName:= 'viajes';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idviaje>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;
c:=fdtable1.RecordCount;
numeroviajes:=c;

                 eND;

end;


// LEE EN TABLA 'tabla' EL CAMPO CUYO 'id=valorid o valoridstr' Y DEVUELVE EL VALOR DE 'campodeseado'
function TFGlobal.DimeTabla(tabla, id, valoridstr, campodeseado: string; valorid: integer): string;
var
x, valorfinal: string;
i: integer;
begin

if valoridstr='' then valorfinal:=inttostr(valorid) else valorfinal:=Quotedstr(valoridstr);


with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= tabla;
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := id+'='+valorfinal;
FDTable1.Filtered := True;
fdtable1.Active:=true;

               x:=fdtable1.FieldByName(campodeseado).AsString;

                End;
Result:=x;

end;



function TFGlobal.DimeCiudad(c: integer): string;
var
x: string;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'ciudad';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idciudad='+inttostr(c);
FDTable1.Filtered := True;
fdtable1.Active:=true;

               x:=fdtable1.FieldByName('nombre').AsString;

                End;
Result:=x;

end;




function TFGlobal.DimeCliente(c: integer): string;
var
x: string;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'clientes';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idempresa='+inttostr(c);
FDTable1.Filtered := True;
fdtable1.Active:=true;

               x:=fdtable1.FieldByName('nombre').AsString;

                End;
Result:=x;

end;





procedure TFGlobal.CargarCamionesF;
var
i, j, c: integer;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'fabrica';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idcamion>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;

c:=fdtable1.RecordCount;
numerocamiones:=c;

for i := 1 to c do begin
               fabrica[i].idcamion:=fdtable1.FieldByName('idcamion').AsInteger;
               fabrica[i].km:=fdtable1.FieldByName('km').AsInteger;
               fabrica[i].tara:=fdtable1.FieldByName('tara').AsInteger;
               fabrica[i].pma:=fdtable1.FieldByName('pma').AsInteger;
               fabrica[i].cv:=fdtable1.FieldByName('cv').AsInteger;
               fabrica[i].precio:=fdtable1.FieldByName('precio').AsInteger;
               fabrica[i].idciudadactual:=fdtable1.FieldByName('idciudadactual').AsInteger;
               fabrica[i].idconductor:=fdtable1.FieldByName('idconductor').AsInteger;
               fabrica[i].modelo:=fdtable1.FieldByName('modelo').AsString;
               fabrica[i].foto:=fdtable1.FieldByName('foto').AsString;
               fabrica[i].matricula:=fdtable1.FieldByName('matricula').AsString;
               fabrica[i].fotosalpicadero:=fdtable1.FieldByName('fotosalpicadero').AsString;
               fabrica[i].pma:=fdtable1.FieldByName('pma').AsInteger;
               fabrica[i].estado:=fdtable1.FieldByName('estado').AsInteger;
              fabrica[i].l100:=fdtable1.FieldByName('l100').AsInteger;
               fabrica[i].GASOIL:=fdtable1.FieldByName('GASOIL').AsInteger;
               fabrica[i].GASOILTOTAL:=fdtable1.FieldByName('GASOILTOTAL').AsInteger;
               fabrica[i].Motor:=fdtable1.FieldByName('Motor').AsInteger;
               fabrica[i].chasis:=fdtable1.FieldByName('chasis').AsInteger;
               fabrica[i].suspension:=fdtable1.FieldByName('suspension').AsInteger;
               fabrica[i].carroceria:=fdtable1.FieldByName('carroceria').AsInteger;
               fabrica[i].ruedas:=fdtable1.FieldByName('ruedas').AsInteger;

               fdtable1.Next;


                    end;

fdtable1.Active:=false;
fdtable1.TableName:= 'camiones';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idcamion>'+Quotedstr('0')+' ORDER BY idcamion ASC';
FDTable1.Filtered := False;
fdtable1.Active:=true;

c:=fdtable1.RecordCount;
numerocamionesjugador:=c;

for i := 1 to c do begin
//idc,idcamion,matricula,idjugador,modelo,cv,L100,tara,pma,km,foto,fotosalpicadero,
// idconductor,anylanzamiento,fechacompra,cabina,averia,otro,encendido,velocidad,
//idviajeactual,idciudadactual,provinciaactual,posmapa,motor,chasis,suspension,
// carroceria,ruedas,GASOIL,GASOILTOTAL,precio,estado
               camiones[i].idcamion:=fdtable1.FieldByName('idcamion').AsInteger;
               camiones[i].km:=fdtable1.FieldByName('km').AsInteger;
               camiones[i].tara:=fdtable1.FieldByName('tara').AsInteger;
               camiones[i].pma:=fdtable1.FieldByName('pma').AsInteger;
               camiones[i].cv:=fdtable1.FieldByName('cv').AsInteger;
               camiones[i].precio:=fdtable1.FieldByName('precio').AsInteger;
               camiones[i].idciudadactual:=fdtable1.FieldByName('idciudadactual').AsInteger;
               camiones[i].idconductor:=fdtable1.FieldByName('idconductor').AsInteger;
               camiones[i].modelo:=fdtable1.FieldByName('modelo').AsString;
               camiones[i].foto:=fdtable1.FieldByName('foto').AsString;
               camiones[i].matricula:=fdtable1.FieldByName('matricula').AsString;
               camiones[i].fotosalpicadero:=fdtable1.FieldByName('fotosalpicadero').AsString;
               camiones[i].pma:=fdtable1.FieldByName('pma').AsInteger;
               camiones[i].estado:=fdtable1.FieldByName('estado').AsInteger;
              camiones[i].l100:=fdtable1.FieldByName('l100').AsInteger;
               camiones[i].GASOIL:=fdtable1.FieldByName('GASOIL').AsInteger;
               camiones[i].GASOILTOTAL:=fdtable1.FieldByName('GASOILTOTAL').AsInteger;
               camiones[i].Motor:=fdtable1.FieldByName('Motor').AsInteger;
               camiones[i].chasis:=fdtable1.FieldByName('chasis').AsInteger;
               camiones[i].suspension:=fdtable1.FieldByName('suspension').AsInteger;
               camiones[i].carroceria:=fdtable1.FieldByName('carroceria').AsInteger;
               camiones[i].ruedas:=fdtable1.FieldByName('ruedas').AsInteger;
  //                 ShowMessage(fdtable1.FieldByName('modelo').AsString+'='+camiones[i].modelo);

               fdtable1.Next;

                    end;



                End;

end;


procedure TFGlobal.CargarViajes;
var
i, c: integer;
x1,x2: string;
y1,y2: integer;
begin

with fglobal do Begin

fdtable1.Active:=false;
fdtable1.TableName:= 'viajes';
//FDTable1.Filter := 'nombre='+Quotedstr('BBVA');
FDTable1.Filter := 'idviaje>'+Quotedstr('0');
FDTable1.Filtered := True;
fdtable1.Active:=true;

c:=fdtable1.RecordCount;
numeroviajes:=c;

for i := 1 to c do begin

//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero

               viajes[i].idviaje:=fdtable1.FieldByName('idviaje').AsInteger;
               viajes[i].idempresa:=fdtable1.FieldByName('idempresa').AsInteger;
               viajes[i].idjugador:=fdtable1.FieldByName('idjugador').AsInteger;

               viajes[i].nombrecarga:=fdtable1.FieldByName('nombrecarga').AsString;

               viajes[i].kgcarga:=fdtable1.FieldByName('kgcarga').AsInteger;
               viajes[i].idciudadorigen:=fdtable1.FieldByName('idciudadorigen').AsInteger;
               viajes[i].idciudaddestino:=fdtable1.FieldByName('idciudaddestino').AsInteger;
                viajes[i].kmtotal:=fdtable1.FieldByName('kmtotal').AsInteger;
               viajes[i].dinero:=fdtable1.FieldByName('dinero').AsInteger;
               fdtable1.Next;



//               arrciudad[i][1]:=fdtable1.FieldByName('taep-restamo').AsString;
                    end;
                End;

end;






end.
