program YPRO;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit5 in 'Unit5.pas',
  Unit6 in 'Unit6.pas' {formbanco},
  Unit7 in 'Unit7.pas' {formprensa},
  Unit8 in 'Unit8.pas' {formvarios},
  Unit9 in 'Unit9.pas' {formempresa},
  Unit10 in 'Unit10.pas' {formbiz},
  UnitZero in 'UnitZero.pas' {formZero},
  global1 in 'global1.pas' {FGlobal1},
  Vcl.Themes,
  Vcl.Styles,
  UnitBUY in 'UnitBUY.pas' {formcompras};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ypro';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TformZero, formZero);
  Application.CreateForm(Tformbanco, formbanco);
  Application.CreateForm(Tformprensa, formprensa);
  Application.CreateForm(Tformvarios, formvarios);
  Application.CreateForm(Tformempresa, formempresa);
  Application.CreateForm(Tformbiz, formbiz);
  Application.CreateForm(TFGlobal1, FGlobal1);
  Application.CreateForm(Tformcompras, formcompras);
  Application.Run;
end.
