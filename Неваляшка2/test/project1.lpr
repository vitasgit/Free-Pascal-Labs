program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, sysutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    edit1, edit2: TEdit;

    procedure Timer(Sender: TObject);
    procedure BClick(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure toCenter(Sender: TObject);
    procedure Edit1Done(Sender: TObject);
    procedure Edit2Done(Sender: TObject);

    private
      dirvar: integer;
  end;

procedure TForm1.Timer(Sender: TObject);
begin
  Panel1.Enabled:= False;
  case dirvar of
    1:
      if (Width < Constraints.MaxWidth) or (Height < Constraints.MaxHeight) then
      begin
        Width:= Width+5;
        Height:= Height+5;
      end
      else begin
        Panel1.Enabled:= true;
        Timer1.Enabled:= False;
      end;

    0:
      if (Width > Constraints.MinWidth) or (Height > Constraints.MinHeight) then
      begin
        Width:= Width-5;
        Height:= Height-5;
      end
      else begin
        Panel1.Enabled:= true;
        Timer1.Enabled:= False;
      end;
  end;
end;

procedure TForm1.BClick(Sender: TObject);
begin
  Timer1.Enabled:= True;
  dirvar:= 1;
end;

procedure TForm1.B2Click(Sender: TObject);
begin
  Timer1.Enabled:= True;
  dirvar:= 0;
end;

procedure TForm1.toCenter(Sender: TObject);
begin
  Left:= (Screen.Width - self.Width) div 2;
  Top:= (Screen.Height - self.Height) div 2;
  Panel1.Left:= (ClientWidth - Panel1.Width) div 2;
  Panel1.Top:= (ClientHeight - Panel1.Height) div 2;
  Edit1.Text:= IntToStr(Width);
  Edit2.Text:= IntToStr(Height);
end;

procedure TForm1.Edit1Done(Sender: TObject);
var
  i: integer;
begin
  if TryStrToInt(edit1.text, i) then width:= i;
  edit1.text:= IntToStr(width);
end;

procedure TForm1.Edit2Done(Sender: TObject);
var
  i: integer;
begin
  if TryStrToInt(edit2.text, i) then height:= i;
  edit2.text:= IntToStr(height);
end;

var
  Form1: TForm1;
  btn1, btn2: TButton;
  //dirvar: Integer;
  //panel1: TPanel;
  labelX, labelY: TLabel;
  //edit1, edit2: TEdit;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  form1.position:= poScreenCenter;
  form1.Constraints.MaxHeight:= 500;
  form1.Constraints.MaxWidth:= 1000;
  form1.Constraints.MinHeight:= 100;
  form1.Constraints.MinWidth:= 500;
  form1.OnChangeBounds:= @form1.toCenter;

  form1.Timer1:= TTimer.Create(form1);
  form1.Timer1.OnTimer := @Form1.Timer;
  form1.Timer1.Enabled:= False;
  form1.Timer1.Interval:= 20;



  //panel0:= TPanel.Create(form1);
  //panel0.parent:= form1;
  //panel0.width:= 400;
  //panel0.height:=500;

  form1.panel1:= TPanel.Create(form1);
  form1.panel1.parent:= form1;
  form1.panel1.width:= 350;
  form1.panel1.height:=85;
  form1.panel1.bevelOuter:= bvNone;
  //panel1.top:= 30;
  //Panel1.Left:= (form1.ClientWidth - Panel1.Width) div 2;
  //Panel1.Top:= (form1.ClientHeight - Panel1.Height) div 2;
  //panel1.Align := alTop;

  labelX:= TLabel.Create(form1.panel1);
  labelX.parent:= form1.panel1;
  labelX.caption:= 'Размер по X';
  labelX.Font.Size:= 18;
  labelX.Width:= 150;
  //labelX.Align:= alLeft;

  labelY:= TLabel.Create(form1.panel1);
  labelY.parent:= form1.panel1;
  labelY.caption:= 'Размер по Y';
  labelY.Font.Size:= 18;
  labelY.Width:= 150;
  LabelY.top:= labelX.height+30;

  form1.edit1:= TEdit.create(form1.panel1);
  form1.edit1.parent:= form1.panel1;
  form1.edit1.left:= labelX.Width + 30;
  form1.edit1.AnchorVerticalCenterTo(LabelX);
  form1.edit1.OnEditingDone:= @form1.Edit1Done;
  //Edit1.BorderSpacing.Left:= 10;

  form1.edit2:= TEdit.create(form1.panel1);
  form1.edit2.parent:= form1.panel1;
  form1.edit2.left:= labelX.Width + 30;
  form1.edit2.AnchorVerticalCenterTo(LabelY);
  form1.edit2.OnEditingDone:= @form1.Edit2Done;


  btn1:= TButton.Create(form1.panel1);
  btn1.parent:= form1.panel1;
  btn1.height:= 35;
  btn1.caption:='Демо +';
  btn1.OnClick:= @form1.BClick;
  btn1.left:= form1.panel1.width - btn1.width;
  btn1.AnchorVerticalCenterTo(LabelX);
  //btn1.Anchors := [akTop, akRight];

  btn2:= TButton.Create(form1.panel1);
  btn2.parent:= form1.panel1;
  btn2.height:= 35;
  btn2.caption:='Демо -';
  btn2.OnClick:= @form1.B2Click;
  btn2.left:= form1.panel1.width - btn1.width;
  btn2.AnchorVerticalCenterTo(LabelY);


  Application.Run;
end.

