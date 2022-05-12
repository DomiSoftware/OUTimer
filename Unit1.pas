unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, DateUtils, FMX.Objects,
  System.Notification, Strutils,
  FMX.Media;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    ScaledLayout1: TScaledLayout;
    Timer1: TTimer;
    Button5: TButton;
    NotificationCenter1: TNotificationCenter;
    MediaPlayer1: TMediaPlayer;
    Panel1: TPanel;
    Label2: TLabel;
    Button2: TButton;
    Panel2: TPanel;
    Panel4: TPanel;
    Button10: TButton;
    Button11: TButton;
    Panel5: TPanel;
    Button7: TButton;
    Button8: TButton;
    Panel3: TPanel;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button1: TButton;
    Button3: TButton;
    Panel7: TPanel;
    Button6: TButton;
    Label3: TLabel;
    Button12: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    procedure NotifyAndroid(title, text: string);
    procedure settimer(t_m, t_s: integer);
    procedure audioout(cfn: string; vol: integer);
    procedure switchenable(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cm, cs, m, s, l: integer;
  dt, nw: TDateTime;

implementation

{$R *.fmx}
uses System.IOUtils;

procedure TForm1.Button10Click(Sender: TObject);
begin
   settimer(45,0);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  settimer(15,0);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  settimer(90,0);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
settimer(5,0)

end;

procedure TForm1.Button14Click(Sender: TObject);
begin
settimer(1,0)

end;

procedure TForm1.Button15Click(Sender: TObject);
begin
settimer(3,0);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  settimer(90,0);
end;

procedure TForm1.settimer(t_m,t_s:integer);
begin
  m := t_m;
  s := t_s;
  //
  dt := now;
  nw := dt;
  dt := IncMinute(dt, m);
  dt := IncSecond(dt, s);
  //
  Timer1.Enabled := true;
  Button5.text := 'STOP/PAUSE';
      if s < 10 then
      Label2.text := inttostr(m) + ':0' + inttostr(s)
    else
      Label2.text := inttostr(m) + ':' + inttostr(s);
  Button5.Enabled := true;
  switchenable(self);
end;

procedure TForm1.switchenable(Sender: TObject);
begin
  Button1.enabled:=not(Button1.enabled);
  Button2.enabled:=not(Button2.enabled);
  Button3.enabled:=not(Button3.enabled);
//  Button4.enabled:=not(Button4.enabled);
  Button6.enabled:=not(Button6.enabled);
  Button7.enabled:=not(Button7.enabled);
  Button8.enabled:=not(Button8.enabled);
//  Button9.enabled:=not(Button9.enabled);
  Button10.enabled:=not(Button10.enabled);
  Button11.enabled:=not(Button11.enabled);
  Button12.enabled:=not(Button12.enabled);
  Button13.enabled:=not(Button13.enabled);
  Button14.enabled:=not(Button14.enabled);
  Button15.enabled:=not(Button15.enabled);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  settimer(60,0);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
settimer(20,0)

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
settimer(7,0);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  dv: TDateTime;
begin
  if Button5.text = 'STOP/PAUSE' then
  begin
//    NotifyAndroid('Pomodoro', 'Paused...');
    audioout('mixkit-police-short-whistle-615b.wav',75);
    Timer1.Enabled := false;
    nw := now;
    Button5.text := 'RESUME';
  end
  else
  begin
    if Button5.text = 'RESUME' then
    begin
      dv := now - nw;
      dt := dt + dv;
      Button5.text := 'STOP/PAUSE';
      Timer1.Enabled := true;
    end;
  end;
  switchenable(self);

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
settimer(25,0)
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
settimer(30,0)
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
settimer(10,0)

end;

procedure TForm1.Button9Click(Sender: TObject);
begin
settimer(8,0);

end;

procedure TForm1.NotifyAndroid(title, text: string);
var
  Notification: TNotification;
begin
  { verify if the service is actually supported }
  if NotificationCenter1.Supported then
  begin
    Notification := NotificationCenter1.CreateNotification;
    Notification.Name := title;
    Notification.AlertBody := text;
    Notification.FireDate := now;

    { Send notification in Notification Center }
    NotificationCenter1.ScheduleNotification(Notification);
  end;
end;

procedure Tform1.audioout(cfn:string;vol:integer);
var
  dfn:string;
begin
{$IF DEFINED(mswindows)}
    dfn := TPath.Combine(ExtractFilePath(ParamStr(0)), cfn);
{$ENDIF}
{$IF DEFINED (ANDROID)}
    dfn := TPath.Combine(TPath.GetDocumentsPath,cfn);
{$ENDIF}
    MediaPlayer1.FileName := dfn;
    MediaPlayer1.Volume := vol;
    MediaPlayer1.play;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  h, ms, tm, ts: word;
  dfn, cfn,lb: string;
  i:integer;
begin
  if (now >= dt) then
  begin
    Label2.text := 'Time Elapsed';
    Timer1.Enabled := false;
    label2.Visible:=false;
     Button5.text := 'Time Elapsed';
    // beep;
    switchenable(self);

//    NotifyAndroid('Pomodoro', 'Time has elapsed...');
    audioout('mixkit-police-short-whistle-615b.wav',75);
  end
  else
  begin
    DecodeTime((dt - now), h, tm, ts, ms);
    lb:='';
    if h>0 then lb:=lb+inttostr(h) else lb:='0';
    if tm < 10 then
      Lb:= lb +'h 0' + inttostr(tm)
    else
      Lb := lb + 'h ' + inttostr(tm);
//    tm:=tm+(60*h);
    if ts < 10 then
      Lb := lb + 'm 0' + inttostr(ts)+ 's'
    else
      lb:=lb + 'm ' + inttostr(ts)+ 's';
    label2.Text:=lb;
    label2.Visible:=true;
  end;

end;

end.
