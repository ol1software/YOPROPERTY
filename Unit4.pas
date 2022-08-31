unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.ScrollBox, FMX.Memo;

type
  Tformcamiones = class(TForm)
    tdinero: TEdit;
    ImageC: TImageControl;
    companyia: TLabel;
    turno: TImageControl;
    ImageControl1: TImageControl;
    Timer1: TTimer;
    foto: TImageControl;
    derecha: TImageControl;
    izquierda: TImageControl;
    ImageControl5: TImageControl;
    ImageList1: TImageList;
    Image1: TImage;
    tmodelo: TEdit;
    lm: TLabel;
    tpma: TEdit;
    lpma: TLabel;
    tl100: TEdit;
    l100: TLabel;
    tprecio: TEdit;
    lprecio: TLabel;
    testado: TEdit;
    lestado: TLabel;
    derecha2: TImageControl;
    izquierda2: TImageControl;
    izquierda1: TImageControl;
    derecha1: TImageControl;
    ImageControl2: TImageControl;
    Button3: TButton;
    Switch1: TSwitch;
    l: TLabel;
    Panel1: TPanel;
    tconductor: TEdit;
    ImageControl3: TImageControl;
    lasignar: TLabel;
    tcv: TEdit;
    Label1: TLabel;
    tgasoil: TEdit;
    Label2: TLabel;
    tkm: TEdit;
    Label3: TLabel;
    tmatricula: TEdit;
    Label4: TLabel;
    tciudad: TEdit;
    Label5: TLabel;
    procedure ImageControl5Click(Sender: TObject);
    procedure derechaClick(Sender: TObject);
    procedure izquierdaClick(Sender: TObject);

    procedure CargaCamionForm(idc: integer);
    procedure ImageControl2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure ImageControl3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formcamiones: Tformcamiones;
  f: string;

implementation

{$R *.fmx}

uses global, Unit10;

procedure Tformcamiones.Button2Click(Sender: TObject);
begin
       ShowMessage(inttostr(idc)+camiones[idc].foto);
end;

procedure Tformcamiones.Button3Click(Sender: TObject);
begin
formconductores.show;
end;

procedure Tformcamiones.CargaCamionForm(idc: integer);
begin
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
end;

procedure Tformcamiones.derechaClick(Sender: TObject);
var nc: integer;
begin
if switch1.IsChecked then nc:=numerocamionesjugador else nc:=numerocamiones;

  if idc<nc then
                        Begin
      idc:=idc+1;

    CargaCamionForm(idc);
   //   ShowMessage(inttostr(idc)+camiones[idc].foto);
    if idc=nc then derecha.Bitmap.Assign(derecha2.Bitmap);

                        End;

if idc>1 then izquierda.Bitmap.Assign(izquierda1.Bitmap);

end;

procedure Tformcamiones.FormActivate(Sender: TObject);
begin
tdinero.Text:=Fglobal.DimeVJugador('dinero');

end;

procedure Tformcamiones.FormShow(Sender: TObject);
begin

    CargaCamionForm(idc);

end;

procedure Tformcamiones.ImageControl2Click(Sender: TObject);
var i: integer;
begin
i:=strtoint(FGlobal.DimeTabla('fabrica', 'idcamion', '', 'precio', idc));

if i>dinero then Begin
    ShowMessage('No tienes suficiente dinero');
    exit;
                 End;
fglobal.CompraCamion(idc);
    CargaCamionForm(idc);

end;

procedure Tformcamiones.ImageControl3Click(Sender: TObject);
begin
formconductores.Show;
end;

procedure Tformcamiones.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformcamiones.izquierdaClick(Sender: TObject);
var nc: integer;
begin
if switch1.IsChecked then nc:=numerocamionesjugador else nc:=numerocamiones;



if idc>1 then
                      Begin
    idc:=idc-1;
    CargaCamionForm(idc);
                      End;

if idc<nc then derecha.Bitmap.Assign(derecha1.Bitmap);
if idc=1 then izquierda.Bitmap.Assign(izquierda2.Bitmap)


end;

procedure Tformcamiones.Switch1Switch(Sender: TObject);
begin
idc:=1;
    CargaCamionForm(idc);
end;

end.
