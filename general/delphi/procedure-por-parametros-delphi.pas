unit Unit1;
 
interface
 
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
 
type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Evento(Event: TNotifyEvent);
    procedure EventoTeste(Sender: TObject);
  end;
 
var
  Form1: TForm1;
 
implementation
 
{$R *.dfm}
 
procedure TForm1.Button1Click(Sender: TObject);
begin
  Evento(EventoTeste);
end;
 
procedure TForm1.Evento(Event: TNotifyEvent);
begin
  Self.OnClick:= Event;
end;
 
procedure TForm1.EventoTeste(Sender: TObject);
begin
  ShowMessage(´oi´);
end;