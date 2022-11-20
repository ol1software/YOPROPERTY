unit Uniti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ComCtrls, Vcl.ToolWin;

type
  Tiform = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    RichEdit1: TRichEdit;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Button1: TButton;
    procedure Image2Click(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure Memo2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure RichEdit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  iform: Tiform;

implementation

{$R *.dfm}

uses Unit1;

procedure Tiform.Button1Click(Sender: TObject);
begin
Self.Close;
end;

procedure Tiform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
timer1.Enabled:=false;
end;

procedure Tiform.Image2Click(Sender: TObject);
begin
form1.Visible:=true;
self.Close;
end;

procedure Tiform.Memo2Change(Sender: TObject);
begin
self.Close;
end;

procedure Tiform.Memo2Click(Sender: TObject);
begin
self.Close;
end;

procedure Tiform.RichEdit1Click(Sender: TObject);
begin
self.Close;
end;

end.
