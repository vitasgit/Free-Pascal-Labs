unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, Math;

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

    procedure FormChangeBounds(Sender: TObject);
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
    procedure DrawFig(iFig: integer);
    procedure DeleteFig(x, y: integer);
    function HoverFig(x, y: Integer): integer;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);

  private
    //X1, Y1: integer;
    flag: Boolean;

    ArrXY: TArrXY;
    SingleXY: TSingleXY;
    Count: integer;
    rezhim: string;
    bgColor: TColor;
    x0,y0, iFig, iCatchFig: integer;   // iFig == iHoverFig

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

  bgColor:= PaintBox1.Color;
  PaintBox1.Canvas.Brush.Color:= PaintBox1.Color;

end;

procedure TForm1.FormChangeBounds(Sender: TObject);
begin
  //DrawFig(-1);
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//var
  //iFig: integer;
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

  if rezhim = 'перемещение' then
  begin
    iCatchFig:= HoverFig(X, Y);
    if iCatchFig <> -1 then
    begin
      x0:= X;
      y0:= Y;
      flag:= True;
    end;
  end;

  // удаление
  if rezhim = 'удаление' then
  begin
    DeleteFig(X, Y);
    Exit;
  end;

end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  //iFig: integer;
  dx, dy: integer;
begin
  if flag then
  begin
    if rezhim = 'линии' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig(-1);  // старые линии
      PaintBox1.Canvas.Line(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);  // новая линия(линии)
    end
    else if rezhim = 'прямоугольники' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig(-1);

      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Rectangle(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);
      PaintBox1.Canvas.Brush.Color:= bgColor;  // fix бага с закраской холста
    end
    else if rezhim = 'эллипсы' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      PaintBox1.Canvas.Clear;
      drawFig(-1);

      PaintBox1.Canvas.Brush.Color:= clRed;
      PaintBox1.Canvas.Ellipse(SingleXY.x1, SingleXY.y1, SingleXY.x2, SingleXY.y2);
      PaintBox1.Canvas.Brush.Color:= bgColor;  // fix бага с закраской холста
    end;
  end;

  if (rezhim = 'перемещение') or (rezhim = 'удаление') then
  begin
    iFig:= HoverFig(X, Y);

    if flag and (iCatchFig <> -1) then   // проверить упрощенное условие
    begin
      dx:= X - x0;
      dy:= Y - y0;

      ArrXY[iCatchFig].x1:= ArrXY[iCatchFig].x1 + dx;
      ArrXY[iCatchFig].x2:= ArrXY[iCatchFig].x2 + dx;
      ArrXY[iCatchFig].y1:= ArrXY[iCatchFig].y1 + dy;
      ArrXY[iCatchFig].y2:= ArrXY[iCatchFig].y2 + dy;
      iFig:= iCatchFig;
      x0:= X;
      y0:= Y;
    end;

    PaintBox1.Canvas.Clear;
    drawFig(-1);

    if iFig <> -1 then
    begin
      PaintBox1.Canvas.Pen.Width:= 3;
      PaintBox1.Canvas.Brush.Color:= clRed;

      // условия для каждой фигуры
      if ArrXY[iFig].fig = 'прямоугольники' then
         drawFig(iFig)
         //PaintBox1.Canvas.Rectangle(ArrXY[iFig].x1, ArrXY[iFig].y1, ArrXY[iFig].x2, ArrXY[iFig].y2)
      else if ArrXY[iFig].fig = 'линии' then
           drawFig(iFig)
           //PaintBox1.Canvas.Line(ArrXY[iFig].x1, ArrXY[iFig].y1, ArrXY[iFig].x2, ArrXY[iFig].y2)
      else if ArrXY[iFig].fig = 'эллипсы' then
           drawFig(iFig);
           //PaintBox1.Canvas.Ellipse(ArrXY[iFig].x1, ArrXY[iFig].y1, ArrXY[iFig].x2, ArrXY[iFig].y2);

      PaintBox1.Canvas.Brush.Color:= bgColor;
      PaintBox1.Canvas.Pen.Width:= 1;
    end;
  end;


end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if flag then
  begin
    // можно сократить на (rezhim = 'линии') or (rezhim = 'прямоугольники') or (rezhim = 'эллипсы')
    if rezhim = 'линии' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig(-1);
    end
    else if rezhim = 'прямоугольники' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig(-1);
    end
    else if rezhim = 'эллипсы' then
    begin
      SingleXY.x2:= X;
      SingleXY.y2:= Y;

      Count:= Count+1;
      SingleXY.fig:= rezhim;
      SetLength(ArrXY, Count);
      ArrXY[Count-1]:= SingleXY;
      drawFig(-1);
    end;

    flag:= False;
  end;

  if rezhim = 'перемещение' then
    begin
      flag:= False;
      iCatchFig:= -1;
    end;
end;


procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  drawFig(-1);
end;

procedure TForm1.DrawFig(iFig: integer);
var
  i: integer;
begin
  for i:=0 to Length(ArrXY)-1 do
  begin
    if i = iFig then
    begin
      // Выделенная фигура — жирное перо
      PaintBox1.Canvas.Pen.Width:= 3;
    end
    else
    begin
      // Обычная фигура
      PaintBox1.Canvas.Pen.Width:= 1;
    end;

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

procedure TForm1.DeleteFig(x, y: integer);
var
  i, j: integer;
begin
  i:= HoverFig(x, y);

  if i >= 0 then
  begin
    // Сдвигаем все элементы после удаляемого на одну позицию влево
    for j := i to Length(ArrXY)-2 do
    begin
      ArrXY[j] := ArrXY[j+1];
    end;
    // Уменьшаем массив на 1
    SetLength(ArrXY, Length(ArrXY)-1);
  end;

  PaintBox1.Canvas.Clear;
  DrawFig(-1);
end;

// x, y - курсор
//function TFPRectRegion.IsPointInRegion(AX, AY: Integer): Boolean;
//begin
//  Result := (AX >= Rect.Left) and (AX <= Rect.Right) and
//    (AY >= Rect.Top) and (AY <= Rect.Bottom);
//end;

function TForm1.HoverFig(x, y: Integer): integer;
var
  i: Integer;
  Rleft, Right, RTop, RBottom: Integer;
  dx, dy,px,py, d, t: Real;
  cx,cy,a,b, val:Real;
  //val: Real;
begin
  Result := -1;

  for i := Length(ArrXY) - 1 downto 0 do
  begin
    if ArrXY[i].fig = 'прямоугольники' then
    begin
    { вектор линии }
    dx := ArrXY[i].x2 - ArrXY[i].x1;
    dy := ArrXY[i].y2 - ArrXY[i].y1;

    { проекция t }
    t := ((x - ArrXY[i].x1) * dx + (y - ArrXY[i].y1) * dy) / (dx*dx + dy*dy);

    { Ограничиваем t, чтобы найти ближайшую точку ИМЕННО НА ОТРЕЗКЕ }
    if t < 0 then
       t := 0
    else if t > 1 then
       t := 1;

    { Координаты ближайшей к клику точки на отрезке }
    px := ArrXY[i].x1 + t * dx;
    py := ArrXY[i].y1 + t * dy;

    { Расстояние от мышки до этой точки }
    // L = sqrt((x0-x1)^2 + (y0-y1)^2)
    d := Sqrt(Sqr(x - px) + Sqr(y - py));

    if d <= 5 then
    begin
      Result := i;
      Exit;
    end
    end

    { ===================== ПРЯМОУГОЛЬНИК ===================== }
    else if ArrXY[i].fig = 'прямоугольники' then
    begin
      { Нормализуем координаты }
      if ArrXY[i].x1 < ArrXY[i].x2 then
      begin
        Rleft := ArrXY[i].x1;
        Right := ArrXY[i].x2;
      end
      else
      begin
        Rleft := ArrXY[i].x2;
        Right := ArrXY[i].x1;
      end;

      if ArrXY[i].y1 < ArrXY[i].y2 then
      begin
        RTop := ArrXY[i].y1;
        RBottom := ArrXY[i].y2;
      end
      else
      begin
        RTop := ArrXY[i].y2;
        RBottom := ArrXY[i].y1;
      end;

      if (x >= Rleft) and (x <= Right) and
         (y >= RTop) and (y <= RBottom) then
      begin
        Result := i;
        Exit;
      end;
    end
    { ===================== ЭЛЛИПС ===================== }
    else if ArrXY[i].fig = 'эллипсы' then
    begin
      { Уравнение эллипса: (x-cx)²/a² + (y-cy)²/b² ≤ 1 }
      cx := (ArrXY[i].x1 + ArrXY[i].x2) / 2.0;
      cy := (ArrXY[i].y1 + ArrXY[i].y2) / 2.0;
      a  := Abs(ArrXY[i].x2 - ArrXY[i].x1) / 2.0;
      b  := Abs(ArrXY[i].y2 - ArrXY[i].y1) / 2.0;

      { Защита от деления на ноль }
      if (a > 0) and (b > 0) then
      begin
        val := Sqr(x - cx) / Sqr(a) + Sqr(y - cy) / Sqr(b);

        if val <= 1.0 then
        begin
          Result := i;
          Exit;
        end;
      end;
    end;

  end;
end;


//function TForm1.HoverFig(x, y: Integer): integer;
//var
//  Rleft, Right, RTop, RBottom, i: integer;
//begin
//  for i:= Length(ArrXY)-1 downto 0 do
//  begin
//    Rleft:= ArrXY[i].x1;
//    Right:= ArrXY[i].x2;
//    RTop:= ArrXY[i].y1;
//    RBottom:= ArrXY[i].y2;
//
//    if (ArrXY[i].x1 > ArrXY[i].x2) then
//    begin
//      Rleft:= ArrXY[i].x2;
//      Right:= ArrXY[i].x1;
//    end;
//    if (ArrXY[i].y1 > ArrXY[i].y2) then
//    begin
//      RTop:= ArrXY[i].y2;
//      RBottom:= ArrXY[i].y1;
//    end;
//
//    if (x >= Rleft) and (x <= Right) and
//       (y >= RTop) and (y <= RBottom) then
//    begin
//       exit(i);
//    end;
//  end;
//  result:= -1;
//
//end;

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
  PaintBox1.Cursor:= crHandPoint;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  label1.Caption:= 'Отрисовка прямоугольника';
  rezhim:= 'прямоугольники';
  PaintBox1.Cursor:= crHandPoint;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  label1.Caption:= 'Отрисовка эллипсов';
  rezhim:= 'эллипсы';
  PaintBox1.Cursor:= crHandPoint;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  label1.Caption:= 'Режим перемещения';
  rezhim:= 'перемещение';
  PaintBox1.Cursor:= crDrag;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  label1.Caption:= 'Режим удаления';
  rezhim:= 'удаление';
  PaintBox1.Cursor:= crNo;
end;

initialization
  {$I unit1.lrs}

end.


