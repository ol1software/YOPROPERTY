unit UnitVehiculos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, global1,
  Vcl.Imaging.jpeg, Vcl.Mask;

type
  Tformvehiculos = class(TForm)
    fotocoche: TImage;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    Edit1: TEdit;

  procedure CargaVehiculoForm(idc: integer);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formvehiculos: Tformvehiculos;

implementation

{$R *.dfm}

uses Unit1;



   (*
  CargaVehiculoForm
  -carga un vehiculo en el formulario de vehiculos
  *)
procedure Tformvehiculos.Button1Click(Sender: TObject);
begin
self.Close;
end;

procedure TformVehiculos.CargaVehiculoForm(idc: integer);
begin

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

  if camiones[idc].idconductor=0 then
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


procedure Tformvehiculos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.RellenaPantalla;
end;

procedure Tformvehiculos.FormShow(Sender: TObject);
begin

PasaTurnoP;
//global1.CargarVehiculos;

label1.Caption:=Inttostr(coches[1].idcoche);


edit1.Text:=CurrtoStrF(coches[1].precio,ffCurrency, 0 );
fotocoche.Picture.LoadFromFile(coches[1].foto);
end;

end.
