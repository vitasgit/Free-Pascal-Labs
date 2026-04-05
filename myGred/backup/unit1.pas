unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  TSingleXY= record
  x1, y1, x2, y2: integer;
  fig: string;
  end;
  TArrXY= array of TSingleXY;


  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
    FlowPanel1: TFlowPanel;
    ImageList1: TImageList;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);

    //procedure DrawLine;
    //procedure DrawRect;
    procedure DrawFig;
    function HoverFig(x, y: Integer): integer;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);

  private
    //X1, Y1: integer;
    flag: Boolean;

    ArrXY: TArrXY;
    SingleXY: TSingleXY;
    Count: integer;
    rezhim: string;
    bgColor: TColor;

  public

  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Count:= 0;
  SetLength(ArrXY, 0);

  flag:= False;
  label1.caption:= 'Отрисовка отрезков';

  //WriteLn('Brush.Color = ', PaintBox1.Canvas.Brush.Color);
  //WriteLn('PaintBox1.Color = ', PaintBox1.Color);


  {!!!!!!  БАГ с цветом холста и прямоугольников}
  bgColor:= PaintBox1.Color;
  PaintBox1.Canvas.Brush.Color:= PaintBox1.Color;

end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flag:= True;


  // PaintBox1.Canvas.Line(10,10,100,100);
  //WriteLn('Brush.Color = ', PaintBox1.Canvas.Brush.Color);
  //WriteLn('PaintBox1.Color = ', PaintBox1.Color);

  //PaintBox1.Canvas.Rectangle(10,10,100,100);
  //PaintBox1.Canvas.Ellipse(0,0,30,60);

  if rezhim = 'линии' then
  begin
    SingleXY.x1:= X;
    SingleXY.y1:= Y;
    SingleXY.x2:= X;
    SingleXY.y2:= Y;
  end
  else if rezhim = 'прямоугольники' then
  begin
    SingleXY.x1:= X;
    SingleXY.y1:= Y;
    SingleXY.x2:= X;
    SingleXY.y2:= Y;
  end
  else if rezhim = 'эллипсы' then
  begin
    SingleXY.x1:= X;
    SingleXY.y1:= Y;
    SingleXY.x2:= X;
    SingleXY.y2:= Y;
  end;

end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  iFig: integer;
begin
  if flag then
  begin
    if rezhim = 'линии' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig;  // старые линии
      PaintBox1.Canvas.Line(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);  // новая линия(линии)
    end
    else if rezhim = 'прямоугольники' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig;

      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Rectangle(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);
      PaintBox1.Canvas.Brush.Color:= bgColor;  // fix бага с закраской холста
    end
    else if rezhim = 'эллипсы' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig;

      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Ellipse(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);
      PaintBox1.Canvas.Brush.Color:= bgColor;  // fix бага с закраской холста
    end;
  end;

  if rezhim = 'перемещение' then
  begin
    iFig:= HoverFig(X, Y);

    if iFig <> -1 then
    begin
      PaintBox1.Canvas.Clear;
      drawFig;

      PaintBox1.Canvas.Pen.Width:= 5;
      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Rectangle(ArrXY[iFig].x1, ArrXY[iFig].y1, ArrXY[iFig].x2, ArrXY[iFig].y2);
      PaintBox1.Canvas.Brush.Color:= bgColor;
      PaintBox1.Canvas.Pen.Width:= 1;
    end
    else
    begin

    end;

  end;


end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if flag then
  begin
    if rezhim = 'линии' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig;
    end
    else if rezhim = 'прямоугольники' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig;
    end
    else if rezhim = 'эллипсы' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig;
    end;

    flag:= False;
  end;
end;

// зачем данная процедура, можно ли обойтись без неё?
// на каком событии она срабатывает?
procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  drawFig;
end;

procedure TForm1.DrawFig;
var
  i: integer;
begin
  for i:=0 to Length(ArrXY)-1 do
  begin
    if ArrXY[i].fig = 'линии' then
    begin
      PaintBox1.Canvas.Line(ArrXY[i].x1, ArrXY[i].y1, ArrXY[i].x2, ArrXY[i].y2);
    end
    else if ArrXY[i].fig = 'прямоугольники' then
    begin
      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Rectangle(ArrXY[i].x1, ArrXY[i].y1, ArrXY[i].x2, ArrXY[i].y2);
    end
    else if ArrXY[i].fig = 'эллипсы' then
    begin
      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Ellipse(ArrXY[i].x1, ArrXY[i].y1, ArrXY[i].x2, ArrXY[i].y2);
    end;
  end;

  PaintBox1.Canvas.Brush.Color:= bgColor; // fix бага с закраской холста

end;

// x, y - курсор
//function TFPRectRegion.IsPointInRegion(AX, AY: Integer): Boolean;
//begin
//  Result := (AX >= Rect.Left) and (AX <= Rect.Right) and
//    (AY >= Rect.Top) and (AY <= Rect.Bottom);
//end;
function TForm1.HoverFig(x, y: Integer): integer;
var
  Rleft, Right, RTop, RBottom, i: integer;
begin
  for i:=0 to Length(ArrXY)-1 do
  begin
    Rleft:= ArrXY[i].x1;
    Right:= ArrXY[i].x2;
    RTop:= ArrXY[i].y1;
    RBottom:= ArrXY[i].y2;

    if (ArrXY[i].x1 > ArrXY[i].x2) then
    begin
      Rleft:= ArrXY[i].x2;
      Right:= ArrXY[i].x1;
    end;
    if (ArrXY[i].y1 > ArrXY[i].y2) then
    begin
      RTop:= ArrXY[i].y2;
      RBottom:= ArrXY[i].y1;
    end;

    if (x >= Rleft) and (x <= Right) and
       (y >= RTop) and (y <= RBottom) then
    begin
       exit(i);
    end;
  end;
  result:= -1;

end;

//procedure TForm1.DrawLine;
//var
//  i: integer;
//begin
//  for i:= 0 to LCount-1 do
//  begin
//    PaintBox1.Canvas.Line(lines[i].x1, lines[i].y1, lines[i].x2, lines[i].y2);
//  end;
//end;
//
//procedure TForm1.DrawRect;
//var
//  i: integer;
//begin
//  for i:= 0 to RCount-1 do
//  begin
//    PaintBox1.Canvas.Rectangle(rects[i].x1, rects[i].y1, rects[i].x2, rects[i].y2);
//  end;
//end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  label1.Caption:= 'Отрисовка отрезка';
  rezhim:= 'линии';
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  label1.Caption:= 'Отрисовка прямоугольника';
  rezhim:= 'прямоугольники';
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  label1.Caption:= 'Отрисовка эллипсов';
  rezhim:= 'эллипсы';

end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  label1.Caption:= 'Режим перемещения';
  rezhim:= 'перемещение';
end;

initialization
  {$I unit1.lrs}

end.


