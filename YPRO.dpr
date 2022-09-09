program YPRO;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit5 in 'Unit5.pas',
  Unit7 in 'Unit7.pas' {formprensa},
  Unit8 in 'Unit8.pas' {formvarios},
  Unit9 in 'Unit9.pas' {formempresa},
  UnitZero in 'UnitZero.pas' {formZero},
  global1 in 'global1.pas' {FGlobal1},
  Vcl.Themes,
  Vcl.Styles,
  UnitBUY in 'UnitBUY.pas' {formcompras},
  UnitBank in 'UnitBank.pas' {formbank},
  Unitbiz in 'Unitbiz.pas' {formbiz};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ypro';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TformZero, formZero);
  Application.CreateForm(Tformprensa, formprensa);
  Application.CreateForm(Tformvarios, formvarios);
  Application.CreateForm(Tformempresa, formempresa);
  Application.CreateForm(TFGlobal1, FGlobal1);
  Application.CreateForm(Tformcompras, formcompras);
  Application.CreateForm(Tformbank, formbank);
  Application.CreateForm(Tformbiz, formbiz);
  Application.Run;
end.
