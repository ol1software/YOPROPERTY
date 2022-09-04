unit UnitBUY;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, global1,
  Vcl.Imaging.jpeg, Vcl.Mask, Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit;

type
  Tformcompras = class(TForm)
    fotocoche: TImage;
    nombrevehtxt: TLabel;
    dere: TImage;
    izq: TImage;
    Button1: TButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Button2: TButton;
    propcheck: TCheckBox;
    Label2: TLabel;
    dinerotxt: TStaticText;
    Shape1: TShape;
    valores: TValueListEditor;

  procedure CargaVehiculoForm(id: integer);
  procedure CargaVehiculos(movimiento: integer);
    procedure RellenaPantalla;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure dereClick(Sender: TObject);
    procedure izqClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formcompras: Tformcompras;

  idactual: integer;   // id del coche actual cargado

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
edit1.Text:=CurrtoStrF(coches[idactual].precio,ffCurrency, 0 );







  end;





procedure Tformcompras.Button1Click(Sender: TObject);
begin



CompraVehiculo('vehiculo',idactual);

RellenaPantalla;


end;



   (*
  CargaVehiculoForm
  -carga un vehiculo en el formulario de compra
  *)

procedure Tformcompras.CargaVehiculoForm(id: integer);
var
i: integer;
begin
(*
anyo=0
km=0
<averia=0
<motor=0
<ruedas=1
precio=1
precioventa=1
<estado=
<propietario=
nombrecoche=
matricula=
modelo=
*)
//valores.Strings.SetStrings()

//for I := 1 to 7 do   Showmessage(valores.Values[i]);

idactual:=id;

valores.Cells[1,1]:=coches[id].anyo.ToString;
valores.Cells[1,2]:=coches[id].km.ToString;
valores.Cells[1,3]:=coches[id].precio.ToString;
valores.Cells[1,4]:=coches[id].precioventa.ToString;
valores.Cells[1,5]:=coches[id].nombrecoche;
valores.Cells[1,6]:=coches[id].matricula;
valores.Cells[1,7]:=coches[id].modelo;

if coches[id].propietario=1 then Begin
        shape1.Brush.Color:=clLime;
        Button1.Enabled:=false;  End else
        Begin
          shape1.Brush.Color:=clWhite;
          Button1.Enabled:=true;
        End;
fotocoche.Picture.LoadFromFile(coches[id].foto);
nombrevehtxt.Caption:=coches[id].nombrecoche;
//Showmessage(coches[id].nombrecoche);




(*
tdinero.Text:=Fglobal.DimeVJugador('dinero');

FGlobal.CargarCamionesF;

if switch1.IsChecked then  Begin
panel1.Visible:=true;

izquierda.Bitmap.Assign(izquierda2.Bitmap);
if idc=numerocamionesjugador then derecha.Bitmap.Assign(derecha2.Bitmap)
                             else derecha.Bitmap.Assign(derecha1.Bitmap);

      fglobal.lresource(foto,camiones[idc].foto);
    tmodelo.Text:=camiones[idc].modelo;
    tpma.Text:=inttostr(camiones[idc].pma);
    tl100.Text:=inttostr(camiones[idc].l100);
    testado.Text:=inttostr(camiones[idc].estado);
    tprecio.Text:=inttostr(camiones[idc].precio);
    tkm.Text:=inttostr(camiones[idc].km);
    tmatricula.Text:=camiones[idc].matricula;
    tgasoil.Text:=inttostr(camiones[idc].gasoil);
    tcv.Text:=inttostr(camiones[idc].cv);
    tciudad.Text:=Fglobal.DimeTabla('ciudad', 'idciudad', '', 'nombre', camiones[idc].idciudadactual);

  if camiones[id-c].idconductor=0 then
    tconductor.Text:='SIN CONDUCTOR' else
    tconductor.Text:=Fglobal.DimeTabla('conductores', 'idconductor', '', 'nombre', camiones[idc].idconductor);
                End else
                Begin
panel1.Visible:=false;
      fglobal.lresource(foto,fabrica[idc].foto);
    tmodelo.Text:=fabrica[idc].modelo;
    tpma.Text:=inttostr(fabrica[idc].pma);
    tl100.Text:=inttostr(fabrica[idc].l100);
    testado.Text:=inttostr(fabrica[idc].estado);
    tprecio.Text:=inttostr(fabrica[idc].precio);
    tkm.Text:=inttostr(fabrica[idc].km);
    tmatricula.Text:=fabrica[idc].matricula;
    tgasoil.Text:=inttostr(fabrica[idc].gasoil);
    tcv.Text:=inttostr(fabrica[idc].cv);

  if camiones[idc].idconductor=0 then
    tconductor.Text:='SIN CONDUCTOR' else
    tconductor.Text:=Fglobal.DimeTabla('conductores', 'idconductor', '', 'nombre', camiones[idc].idconductor);

                End;
                *)
end;


   (*
  CargaVehiculos
  -solo carga vehiculos del mes y año
  si movimiento=1 recorre hacia la derecha
  si movimiento=0 recorre hacia la izquierda
  *)
procedure Tformcompras.CargaVehiculos(movimiento: integer);
var
i, x, y, z: integer;
begin


if movimiento=1 then Begin
z:=idactual+1;

// recorre desde el coche actual (id) hasta el final
for i := z to numerovehiculos do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if (x>=coches[i].mes) and (y>=coches[i].anyo) then Begin
Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaVehiculoForm(i);
                                        exit;
                                                   End;

                          end;
                      End else
z:=idactual-1;
// recorre desde el coche actual (id) atrás hasta el inicio (1)
for i := z downto 1 do begin

x:=fechajuego.Month;
y:=fechajuego.Year;

if (x>=coches[i].mes) and (y>=coches[i].anyo) then Begin
Showmessage(inttostr(i)+'-'+coches[i].nombrecoche);

                                        CargaVehiculoForm(i);
                                        exit;
                                                   End;

                          end;

end;



procedure Tformcompras.dereClick(Sender: TObject);
begin

CargaVehiculos(1);

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

 CargaVehiculos(1);


RellenaPantalla;

end;

procedure Tformcompras.izqClick(Sender: TObject);
begin

CargaVehiculos(0);

  RellenaPantalla;
end;

end.
