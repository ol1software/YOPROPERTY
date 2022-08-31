unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid, FMX.Layouts,
  FMX.TabControl, FMX.Menus;

type
  Tformviajes = class(TForm)
    turno: TImageControl;
    companyia: TLabel;
    ImageC: TImageControl;
    Edit1: TEdit;
    derecha1: TImageControl;
    ImageControl5: TImageControl;
    izquierda2: TImageControl;
    derecha2: TImageControl;
    ImageControl3: TImageControl;
    izquierda1: TImageControl;
    TabControl1: TTabControl;
    tab1: TTabItem;
    tab3: TTabItem;
    tab2: TTabItem;
    tdestino: TEdit;
    foto: TImageControl;
    izquierda: TImageControl;
    derecha: TImageControl;
    torigen: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    tkg: TEdit;
    Label3: TLabel;
    tpresupuesto: TEdit;
    Label4: TLabel;
    tcarga: TEdit;
    Label5: TLabel;
    ImageControl2: TImageControl;
    imageb: TImageControl;
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    imageb2: TImageControl;
    StringGrid2: TStringGrid;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    tempresa: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    red: TImageControl;
    ImageControl1: TImageControl;
    CheckBox1: TCheckBox;
    Label11: TLabel;
    tconcesion: TEdit;
    procedure FormShow(Sender: TObject);
    procedure ImageControl5Click(Sender: TObject);

    procedure CargaViajesForm;
    procedure izquierdaClick(Sender: TObject);
    procedure derechaClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid2Click(Sender: TObject);
    procedure imageb2Click(Sender: TObject);
    procedure ImageControl2Click(Sender: TObject);

    procedure CargaGrids;
    procedure redClick(Sender: TObject);
    procedure ImageControl1Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formviajes: Tformviajes;
  viajeactual: integer;

implementation

{$R *.fmx}

uses global, Unit10;


procedure Tformviajes.CargaGrids;
var
i, j, k, c1, c2: integer;

begin
k:=-1;


StringGrid1.RowCount:=numeroviajes;

for i := 1 to numeroviajes do begin
                   j:=i-1;
//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero
              c1:=viajes[i].idciudadorigen;
              c2:=viajes[i].idciudaddestino;

              stringgrid1.Cells[0,j]:=viajes[i].nombrecarga;
              stringgrid1.Cells[1,j]:=FGlobal.DimeCiudad(c1)+'/'+FGlobal.DimeCiudad(c2);
              stringgrid1.Cells[2,j]:=inttostr(viajes[i].kgcarga);
              stringgrid1.Cells[3,j]:=inttostr(viajes[i].dinero);
              stringgrid1.Cells[4,j]:=FGlobal.DimeCliente(viajes[i].idempresa);
//if (viajes[i].idjugador=idjuego) then
                    end;
end;




procedure Tformviajes.CargaViajesForm;
var
idr: integer;
begin
idr:=viajeactual;

 //     fglobal.lresource(foto,viajes[idr].foto);

    torigen.Text:=inttostr(viajes[idr].idciudadorigen);
    tdestino.Text:=inttostr(viajes[idr].idciudaddestino);
    tkg.Text:=inttostr(viajes[idr].kgcarga);
    tpresupuesto.Text:=inttostr(viajes[idr].dinero);
    tcarga.Text:=viajes[idr].nombrecarga;
    if viajes[idr].idjugador=0 then
                               Begin
                               checkbox1.IsChecked:=true;
                               tconcesion.Text:='VACANTE';
                               End else
                               Begin
                                 checkbox1.IsChecked:=false;
    tconcesion.Text:=Fglobal.DimeTabla('juego', 'idjuego','', 'nomjugador', viajes[idr].idjugador);

                               End;
    tempresa.Text:=Fglobal.DimeTabla('clientes', 'idempresa','', 'nombre', viajes[idr].idempresa);


end;

procedure Tformviajes.derechaClick(Sender: TObject);
begin
if idviaje<numeroviajes then
                      Begin
      idviaje:=idviaje+1;
   //   ShowMessage(inttostr(idc)+camiones[idc].foto);
    CargaViajesForm;
    if idviaje=numeroviajes then derecha.Bitmap.Assign(derecha2.Bitmap);

                      End;
end;



procedure Tformviajes.FormShow(Sender: TObject);
begin

 //   CargaViajesForm(idviaje);
    CargaGrids;

 end;

procedure Tformviajes.ImageControl1Click(Sender: TObject);
begin
viajeactual:=stringgrid1.Selected+1;
CargaViajesForm;

TabControl1.TabIndex:=1;

end;

procedure Tformviajes.ImageControl2Click(Sender: TObject);
begin
ShowMessage('Viaje Contratado');
viajes[viajeactual].idjugador:=idjuego;
FGlobal.AsignaViaje(idjuego, viajeactual);
//CargaGrids;
CargaViajesForm;

end;

procedure Tformviajes.imageb2Click(Sender: TObject);
begin
tabcontrol1.TabIndex:=0;
end;

procedure Tformviajes.ImageControl5Click(Sender: TObject);
begin
self.Close;
end;

procedure Tformviajes.izquierdaClick(Sender: TObject);
begin
if idviaje=numeroviajes then derecha.Bitmap.Assign(derecha1.Bitmap);

if idviaje>1 then
                      Begin
    idviaje:=idviaje-1;
    CargaViajesForm;

    if idviaje=1 then izquierda.Bitmap.Assign(izquierda2.Bitmap);

                      End;

                      if idviaje=1 then izquierda.Bitmap.Assign(izquierda1.Bitmap);



end;

procedure Tformviajes.redClick(Sender: TObject);
begin
formconductores.show;
end;

procedure Tformviajes.StringGrid1SelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
ShowMessage(inttostr(Arow));
end;

procedure Tformviajes.StringGrid2Click(Sender: TObject);
begin
popupmenu1.Popup(10,10);
//    ShowMessage(inttostr(stringgrid1.Selected));
end;

procedure Tformviajes.TabControl1Change(Sender: TObject);
begin
    CargaViajesForm;

end;

end.
