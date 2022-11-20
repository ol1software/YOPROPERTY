program YPRO;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  global1 in 'global1.pas' {FGlobal1},
  Vcl.Themes,
  Vcl.Styles,
  UnitBUY in 'UnitBUY.pas' {formcompras},
  Uniti in 'Uniti.pas' {iform};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'YproW';
    Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tiform, iform);
  Application.CreateForm(TFGlobal1, FGlobal1);
  Application.CreateForm(Tformcompras, formcompras);
  Application.Run;
end.
