unit Unit10;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox;

type
  Tformconductores = class(TForm)
    ImageControl5: TImageControl;
    ImageControl1: TImageControl;
    foto: TImageControl;
    derecha: TImageControl;
    izquierda: TImageControl;
    labelh: TLabel;
    Label10: TLabel;
    tnacionalidad: TEdit;
    texperiencia: TEdit;
    Label3: TLabel;
    Label9: TLabel;
    tedad: TEdit;
    Label4: TLabel;
    tresistencia: TEdit;
    Labs: TLabel;
    tsueldo: TEdit;
    tnombre: TEdit;
    red: TImageControl;
    lc: TLabel;
    Label7: TLabel;
    tcamion: TEdit;
    ImageControl2: TImageControl;
    lcc: TLabel;
    Label1: TLabel;
    tempresa: TEdit;
    checkemplea: TCheckBox;
    checkempleado: TCheckBox;
    izquierda2: TImageControl;
    izquierda1: TImageControl;
    derecha2: TImageControl;
    derecha1: TImageControl;
    ComboBox1: TComboBox;
    procedure ImageControl5Click(Sender: TObject);

    procedure CargaConductoresForm(idc: integer);
    procedure FormShow(Sender: TObject);
    procedure redClick(Sender: TObject);
    procedure ImageControl2Click(Sender: TObject);
    procedure derechaClick(Sender: TObject);
    procedure izquierdaClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formconductores: Tformconductores;


implementation

{$R *.fmx}

uses global, Unit4;


procedure Tformconductores.CargaConductoresForm(idc: integer);
begin
checkemplea.IsChecked:=false;
checkempleado.IsChecked:=false;
tempresa.Text:='';

      fglobal.lresource(foto,conductores[idcon].foto);
      tnombre.Text:=conductores[idcon].nombre;
      tnacionalidad.Text:=conductores[idcon].nacionalidad;
      tedad.Text:=inttostr(conductores[idcon].edad);
      texperiencia.Text:=inttostr(conductores[idcon].experiencia);
      tsueldo.Text:=inttostr(conductores[idcon].sueldomes);
      tresistencia.Text:=inttostr(conductores[idcon].resistencia);
      tcamion.Text:=Fglobal.DimeTabla('camiones', 'idcamion', '', 'modelo', conductores[idcon].idcamion);
      if conductores[idcon].idempleador>0 then Begin
          checkemplea.IsChecked:=true;
      if conductores[idcon].idempleador=idjuego then
      Begin
      checkempleado.IsChecked:=true;
      tempresa.Text:='PROPIO';
       End
        else
          tempresa.Text:=Fglobal.DimeTabla('clientes', 'idempresa', '',  'nombre', conductores[idcon].idempleador);

                                             End;

end;



procedure Tformconductores.derechaClick(Sender: TObject);
begin

if idcon<numeroconductores then
                      Begin
      idcon:=idcon+1;
   //   ShowMessage(inttostr(idc)+camiones[idc].foto);
    CargaConductoresForm(idcon);
    if idcon=numeroconductores then derecha.Bitmap.Assign(derecha2.Bitmap);

                      End;

if idcon>1 then izquierda.Bitmap.Assign(izquierda1.Bitmap);

end;

procedure Tformconductores.FormShow(Sender: TObject);
var
i: integer;
begin

    CargaConductoresForm(conductoractual);

 combobox1.Items.Clear;
 for i := 1 to numerocamionesjugador do begin
         combobox1.Items.Add(inttostr(i)+camiones[i].modelo+'='+camiones[i].matricula);
         combobox1.ItemIndex:=idc-1;
                   end;


end;

procedure Tformconductores.ImageControl2Click(Sender: TObject);
var i: integer;
begin

i:=combobox1.ItemIndex+1;
// ShowMessage(inttostr(idcon));
//ShowMessage(inttostr(i)+'='+inttostr(conductores[idcon].idcamion));
if i=conductores[idcon].idcamion then ShowMessage('Ya tiene ese camión asignado!')
  else Begin
//  camiones[i].idconductor:=idcon;
//  conductores[idcon].idcamion:=i;
  Fglobal.AsignaCamion(i, idcon);
  CargaConductoresForm(idcon);
       End;

end;

procedure Tformconductores.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformconductores.izquierdaClick(Sender: TObject);
begin

if idcon>1 then
                      Begin
    idcon:=idcon-1;
    CargaConductoresForm(idcon);


                      End;

if idcon=1 then izquierda.Bitmap.Assign(izquierda2.Bitmap);
if idcon<numeroconductores then derecha.Bitmap.Assign(derecha1.Bitmap);

end;

procedure Tformconductores.redClick(Sender: TObject);
begin

if conductores[idcon].idempleador=idjuego then ShowMessage('Ya está contratado!')
  else Begin
  conductores[idcon].idempleador:=idjuego;
  ShowMessage('Conductor contratado')

  End;
//viajes[idviaje].idconductor:=conductoractual;
    CargaConductoresForm(idcon);
end;

end.
