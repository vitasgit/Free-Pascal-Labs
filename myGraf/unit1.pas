unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, ColorBox, LCLIntf, uPSComponent, Math; //pascalscript;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ColorBox1: TColorBox;
    Edit1: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    PSScript1: TPSScript;
    procedure Button1Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FloatSpinEdit1Change(Sender: TObject);
    procedure FloatSpinEdit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Label7Click(Sender: TObject);
    procedure Label7MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Label8Click(Sender: TObject);
    procedure Label8MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure PaintBox1Paint(Sender: TObject);

    procedure drawFunc(s: string);
    procedure PSScript1Compile(Sender: TPSScript);
    procedure PSScript1Execute(Sender: TPSScript);
  private

  public
    btnDraw: boolean;

  end;

var
  Form1: TForm1;

implementation

// блок с моими функциями
// в дальнейшем они отправлются в паскаль скрипты
function MyTan(x: Double):Double;
begin
  Result:= math.tan(x);
end;

function MyPow(x, y: Double):Double;
begin
  Result:= math.Power(x, y);
end;

function MyLn(x: Double):Double;
begin
  Result:= ln(x);
end;

function MyExp(x: Double):Double;
begin
  Result:= exp(x);
end;

{ TForm1 }

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Pen.Color := clBlack;
  PaintBox1.Canvas.Pen.Width := 1;
  PaintBox1.Canvas.Line(0, PaintBox1.Height div 2, PaintBox1.Width, PaintBox1.Height div 2);  // X
  PaintBox1.Canvas.Line(PaintBox1.width div 2, 0, PaintBox1.width div 2, PaintBox1.Height);  // Y

  // левый label
  Label1.Left:= 0;
  label1.top:= PaintBox1.Height div 2;
  label1.Caption:= FloatToStrF(-FloatSpinEdit1.value, ffFixed, 4, 2);

  // верхний label
  Label2.top:= 0;
  label2.left:= PaintBox1.width div 2;
  label2.Caption:= FloatToStrF(FloatSpinEdit2.value, ffFixed, 4, 2);

  // правый label
  Label3.top:= PaintBox1.Height div 2;
  label3.left:= PaintBox1.width - label3.width;
  label3.Caption:= FloatToStrF(FloatSpinEdit1.value, ffFixed, 4, 2);

  // нижний label
  Label4.top:= PaintBox1.Height - Label4.Height;
  label4.left:= PaintBox1.width div 2;
  label4.Caption:= FloatToStrF(-FloatSpinEdit2.value, ffFixed, 4, 2);

  // центр label
  Label5.top:= (PaintBox1.Height div 2);
  label5.left:= PaintBox1.width div 2;

  // правильно ли вызывать drawFunc в событии onPaint? каждый раз
  if Edit1.text <> '' then drawFunc(Edit1.text);

  //drawFunc(Edit1.text);
end;

procedure TForm1.drawFunc(s: string);
var
  cx,cy: double;  // центр
  mx,my: double;  // математический
  scaleX, scaleY: double;  // масштаб в px
  i: integer;
  px, py: integer;   // экранные координаты (пиксели)
  FirstPoint: Boolean;
  PrevPY: Integer;
begin
  if not btnDraw then Exit;

  FirstPoint := True;

  cx:= PaintBox1.Width/2;
  cy:= PaintBox1.Height/2;

  // зависимость от центра?
  scaleX:= (cx / 2) / FloatSpinEdit1.value;
  scaleY:= (cy / 2) / FloatSpinEdit2.value;

  PaintBox1.Canvas.Pen.Color:= ColorBox1.Selected;

  PaintBox1.Canvas.Pen.Width := 2;

  mx := (0 - cx) / scaleX;
  my := Extended(PSScript1.ExecuteFunction([mx], 'MyFunc'));

  if not (Math.IsNan(my) or Math.IsInfinite(my)) then
  begin
    py := Round(cy - my * scaleY);
    PaintBox1.Canvas.MoveTo(0, py);
    PrevPY := py;
  end;

  for i := 1 to PaintBox1.Width do
  begin
    mx := (i - cx) / scaleX;
    my := Extended(PSScript1.ExecuteFunction([mx], 'MyFunc'));

    if Math.IsNan(my) or Math.IsInfinite(my) then Continue;

    py := Round(cy - my * scaleY);

    if Abs(py - PrevPY) > PaintBox1.Height then
      PaintBox1.Canvas.MoveTo(i, py)
    else
      PaintBox1.Canvas.LineTo(i, py);

    PrevPY := py;
  end;

end;

procedure TForm1.PSScript1Compile(Sender: TPSScript);
begin
  Sender.AddFunction(@MyTan, 'function tan(x: Double): Double;');
  Sender.AddFunction(@MyPow, 'function pow(x, y: Double): Double;');
  Sender.AddFunction(@MyLn, 'function Ln(x: Double): Double;');
  Sender.AddFunction(@MyExp, 'function Exp(x: Double): Double;');
end;

procedure TForm1.PSScript1Execute(Sender: TPSScript);
begin
  Sender.Exec.RegisterDelphiFunction(@MyTan, 'tan', cdCdecl);
  Sender.Exec.RegisterDelphiFunction(@MyPow, 'pow', cdCdecl);
  Sender.Exec.RegisterDelphiFunction(@MyLn, 'Ln', cdCdecl);
  Sender.Exec.RegisterDelphiFunction(@MyExp, 'Exp', cdCdecl);
end;

procedure TForm1.FloatSpinEdit1Change(Sender: TObject);
begin
  // X
  label1.Caption:= FloatToStrF(FloatSpinEdit1.value, ffFixed, 4, 2);
  label3.Caption:= FloatToStrF(FloatSpinEdit1.value, ffFixed, 4, 2);
  PaintBox1.Invalidate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  btnDraw:= True;

  PSScript1.Script.Clear;
  PSScript1.Script.Add('function MyFunc(x: Extended): Extended;');
  PSScript1.Script.Add('begin');
  PSScript1.Script.Add('  Result := ' + edit1.text + ';');
  PSScript1.Script.Add('end;');
  PSScript1.Script.Add('begin');
  PSScript1.Script.Add('end.');

  if not PSScript1.Compile then
  begin
    btnDraw:= False;
    PaintBox1.Invalidate;
    ShowMessage('Ошибка в формуле!');
    Exit;
  end;

  PaintBox1.Invalidate;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  Button1Click(nil);
end;

procedure TForm1.FloatSpinEdit2Change(Sender: TObject);
begin
  // Y
  label2.Caption:= FloatToStrF(FloatSpinEdit2.value, ffFixed, 4, 2);
  label4.Caption:= FloatToStrF(-FloatSpinEdit2.value, ffFixed, 4, 2);
  PaintBox1.Invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  btnDraw:= False;
  PSScript1.OnCompile:= @PSScript1Compile;
  PSScript1.OnExecute:= @PSScript1Execute;
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  OpenURL('html/formula.html');
end;

procedure TForm1.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  label6.Cursor:= crHelp;
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  OpenURL('html/scale.html');
end;

procedure TForm1.Label7MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   label7.Cursor:= crHelp;
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
   OpenURL('html/scale.html');
end;

procedure TForm1.Label8MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  label8.Cursor:= crHelp;
end;

initialization
  {$I unit1.lrs}

end.

