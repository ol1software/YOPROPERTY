unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  FMX.DateTimeCtrls, DateUtils, FMX.ListBox, FMX.Menus, FMX.Layouts,
  FMX.ExtCtrls;

type
  Tformjuego = class(TForm)
    tdinero: TEdit;
    ImageC: TImageControl;
    companyia: TLabel;
    turno: TImageControl;
    i1: TImageControl;
    i2: TImageControl;
    i3: TImageControl;
    i4: TImageControl;
    i5: TImageControl;
    i6: TImageControl;
    i7: TImageControl;
    i8: TImageControl;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    tfechajuego: TDateEdit;
    Button8: TButton;
    ProgressBar1: TProgressBar;
    cviajes: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ImageControl2: TImageControl;
    Label4: TLabel;
    cciudades: TComboBox;
    ccamiones: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    bcontenedor: TImageControl;
    Contract: TLabel;
    office: TImageControl;
    ImageControl3: TImageControl;
    Button9: TButton;
    PopupMenu1: TPopupMenu;
    enterpris: TMenuItem;
    ban: TMenuItem;
    pres: TMenuItem;
    mai: TMenuItem;
    lempresa: TLabel;
    MenuItem1: TMenuItem;
    Button1: TButton;
    ImageControl1: TImageControl;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cciudadesChange(Sender: TObject);

    procedure Salir;
    procedure CargaViajes(id: integer);


    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageControl3Click(Sender: TObject);
    procedure enterprisClick(Sender: TObject);
    procedure banClick(Sender: TObject);
    procedure presClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formjuego: Tformjuego;
  i: integer;
  //b: array of tbitmap;

implementation

{$R *.fmx}

uses Unit5, Unit7, Unit6, Unit9, Unit8, Unit10, global;


procedure Tformjuego.CargaViajes(id: integer);
var
c: string;
c1,c2,j: integer;
begin

 j:=0;
// **** METER UN CAMPO MÁS A VIAJES (NOMBRECIUDAD1 NOMBRECIUDAD2)
// **** LEER AL CARGAR CAMIONES EL MODELO

cviajes.Items.Clear;
for i := 1 to numeroviajes do begin
c:='';
if (viajes[i].idciudadorigen=id) then Begin
//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero
j:=j+1;
              c1:=viajes[i].idciudadorigen;
              c2:=viajes[i].idciudaddestino;
              c:=c+viajes[i].nombrecarga+FGlobal.DimeCiudad(c1)+'/'+FGlobal.DimeCiudad(c2);
              cviajes.Items.Add(c);
                                      End;
                               end;

  if j<1 then Label1.Text:='No shipments' else Label1.Text:=inttostr(j)+' shipments';


ccamiones.Items.Clear;
for i := 1 to numerocamiones do begin
c:='';
if (camiones[i].idciudadactual=id) then Begin
//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero
              c1:=camiones[i].idcamion;
              c:=FGlobal.DimeTabla('camiones','idcamion','','modelo',c1);
              ccamiones.Items.Add(c);
                                      End;
                               end;


end;

procedure Tformjuego.Salir;
begin

MessageDlg('Deseas salir del juego?', System.UITypes.TMsgDlgType.mtConfirmation,
      [System.UITypes.TMsgDlgBtn.mbOK, System.UITypes.TMsgDlgBtn.mbCancel], 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = mrOk then
   Application.Terminate;
         end);

  //  Key := 0; // Set Key = 0 if you want to prevent the default action
end;
procedure Tformjuego.banClick(Sender: TObject);
begin
formbanco.showmodal;
end;

procedure Tformjuego.Button3Click(Sender: TObject);
begin
formviajes.show;
end;

procedure Tformjuego.Button4Click(Sender: TObject);
begin
formprensa.show;
end;

procedure Tformjuego.Button5Click(Sender: TObject);
begin
formvarios.show;
end;

procedure Tformjuego.Button6Click(Sender: TObject);
begin
formbanco.show;
end;

procedure Tformjuego.Button7Click(Sender: TObject);
begin
//formmail.show;
end;

procedure Tformjuego.Button8Click(Sender: TObject);
begin
formconductores.Show;
end;

procedure Tformjuego.cciudadesChange(Sender: TObject);
var
id: integer;
c: string;
begin

c:=cciudades.Selected.Text;
id:=strtoint(FGlobal.DimeTabla('ciudad','nombre',c,'idciudad',0));

if id=idciudadhq then Begin
office.Visible:=true;
end
 else
Begin
office.Visible:=false;
End;

CargaViajes(id);

end;

procedure Tformjuego.enterprisClick(Sender: TObject);
begin
formempresa.show;

end;

procedure Tformjuego.FormActivate(Sender: TObject);
var
i, id, comboindice, c1,c2: integer;
c: string;

begin




if cciudades.ItemIndex>-1 then Begin
office.Visible:=true;
end
 else
Begin
office.Visible:=false;
End;


lempresa.Text:=nomempresa;
tdinero.Text:=Fglobal.DimeVJugador('dinero');
for i := 1 to numerociudades do begin
               cciudades.Items.Add(ciudades[i].nombre);
               c:=ciudades[i].nombre;
               id:=strtoint(FGlobal.DimeTabla('ciudad','nombre',c,'idciudad',0));
               if id=idciudadhq then comboindice:=i;
                   end;

                   cciudades.ItemIndex:=comboindice;

                   CargaViajes(idciudadhq);
     (*
cviajes.Items.Clear;
for i := 1 to numeroviajes do begin
c:='';

if (viajes[i].idjugador=idjuego) then c:='**';

//idviaje,nombrecarga,foto,kgcarga,idciudadorigen,idciudaddestino,kmtotal,
//kmrecorridos,puntosviaje,puntosactual,idconductor,dinero
              c1:=viajes[i].idciudadorigen;
              c2:=viajes[i].idciudaddestino;

              c:=c+viajes[i].nombrecarga+FGlobal.DimeCiudad(c1)+'/'+FGlobal.DimeCiudad(c2);

              cviajes.Items.Add(c);
                                     (*
              stringgrid1.Cells[0,j]:=viajes[i].nombrecarga;
              stringgrid1.Cells[2,j]:=inttostr(viajes[i].kgcarga);
              stringgrid1.Cells[3,j]:=inttostr(viajes[i].dinero);
              stringgrid1.Cells[4,j]:=FGlobal.DimeCliente(viajes[i].idempresa);



                    end;
                   *)

// b[0] := TBitmap.Create;
//  b[0].Assign(imagecontrol1.bitmap);

//  b[1] := TBitmap.Create;
//  b[1].Assign(imagecontrol2.bitmap);

end;

procedure Tformjuego.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Salir;
end;

procedure Tformjuego.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkHardwareBack then Salir;
end;

procedure Tformjuego.ImageControl3Click(Sender: TObject);
begin
Salir;
end;

procedure Tformjuego.MenuItem1Click(Sender: TObject);
begin
formvarios.ShowModal;
end;

procedure Tformjuego.presClick(Sender: TObject);
begin
formprensa.ShowModal;
end;

procedure Tformjuego.Timer1Timer(Sender: TObject);
begin
   i:=i+1;
case i  of
1:  turno.Bitmap.Assign(i1.Bitmap);
2:  turno.Bitmap.Assign(i2.Bitmap);
3:  turno.Bitmap.Assign(i3.Bitmap);
4:  turno.Bitmap.Assign(i4.Bitmap);
5:  turno.Bitmap.Assign(i5.Bitmap);
6:  turno.Bitmap.Assign(i6.Bitmap);
7:  turno.Bitmap.Assign(i7.Bitmap);
8:  begin
turno.Bitmap.Assign(i8.Bitmap);
i:=0;
fechajuego:=IncDay(fechajuego,1);
tfechajuego.DateTime:=fechajuego;
    end;
end;

end;

end.
