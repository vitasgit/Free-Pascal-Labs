unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    //procedure Edit1Enter(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  dirvar: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormResize(Sender: TObject);
begin
  //Edit1.Text:= IntToStr(Width);
  //Edit2.Text:= IntToStr(Height);

  //Panel1.Left:= (ClientWidth - Panel1.Width) div 2;
  //Panel1.Top:= (ClientHeight - Panel1.Height) div 2;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Panel1.Enabled:= false;
  case dirvar of
    1:
      if (Width < Constraints.MaxWidth) or (Height < Constraints.MaxHeight) then
      begin
        Width:= Width+10;
        Height:= Height+10;
      end
      else begin
        Panel1.Enabled:= true;
        Timer1.Enabled:= False;
      end;

    0:
      if (Width > Constraints.MinWidth) or (Height > Constraints.MinHeight) then
      begin
        Width:= Width-10;
        Height:= Height-10;
      end
      else begin
        Panel1.Enabled:= true;
        Timer1.Enabled:= False;
      end;
  end;

 // Edit1.Enabled:= true;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //Width:= Width+10;
  //Height:= Height+10;
  Timer1.Enabled:= True;
  dirvar:= 1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Timer1.Enabled:= True;
  dirvar:= 0;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  //Panel1.Left:= (ClientWidth - Panel1.Width) div 2;
  //Panel1.Top:= (ClientHeight - Panel1.Height) div 2;
end;

// ------------ БАГ С ВВОДОМ, НУЖЕН TryStrToInt (уже есть в 219) ------------------------------------------
procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  Width:= StrToInt(Edit1.Text);
  Edit1.Text:= IntToStr(Width);

end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
begin
  Height:= StrToInt(Edit2.Text);
  Edit2.Text:= IntToStr(Height);
end;

//procedure TForm1.Edit1Enter(Sender: TObject);
//begin
//  Width:= StrToInt(Edit1.Text);
//end;

procedure TForm1.FormChangeBounds(Sender: TObject);
begin
  Left:= (Screen.Width - Form1.Width) div 2;
  Top:= (Screen.Height - Form1.Height) div 2;
  Panel1.Left:= (ClientWidth - Panel1.Width) div 2;
  Panel1.Top:= (ClientHeight - Panel1.Height) div 2;
  Edit1.Text:= IntToStr(Width);
  Edit2.Text:= IntToStr(Height);

  //Form1.Position:= poScreenCenter;
end;

end.

