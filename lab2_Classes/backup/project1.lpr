program project1;

{$mode ObjFPC}{$H+}
{$MACRO ON}
{$DEFINE SIZE := 1000000}

uses Unit1, findUnit, arrunit;

var
  arr2: TArr;

function func1(m: integer): integer;
begin
  count:= count+1;
  if m = arr2[0] then
    result:= 0
  else if m > arr2[0] then
    result:= -1
  else
    result:= 1;
end;

function func2(m: integer): integer;
begin
  count:= count+1;
  if m = arr2[(SIZE-1) div 2] then
    result:= 0
  else if m > arr2[(SIZE-1) div 2] then
    result:= -1
  else
    result:= 1;
end;

function func3(m: integer): integer;
begin
  count:= count+1;
  if m = arr2[SIZE-1] then
     result:= 0
  else if m > arr2[SIZE-1] then
     result:= -1
  else
      result:= 1;
end;

procedure outArr(arr: TArr; n: integer);
var
  i: integer;
begin
  for i:= 0 to n-1 do
  begin
    write(arr[i], ' ');
  end;
  writeln();
end;

var
  A, B: TAbstractFinder;
  f1, f2: TFunc;
  i: integer;

begin
     makeArr(arr2, SIZE);
     outArr(arr2, 10);

     A:= TLineFinder.Create(arr2);
     B:= TBinFinder.Create(arr2);

     writeln(#13#10, '---- Поиск первого ---- ');
     A.setFunc(@func1);
     writeln('линейный');
     count:=0;
     writeln('i: ', A.findOne());
     writeln('count = ', count);
     writeln();

     writeln('бинарный');
     B.setFunc(@func1);
     count:=0;
     writeln('i: ', B.findOne());
     writeln('count = ', count);    // 18

     writeln(#13#10, '---- Поиск среднего ---- ');
     A.setFunc(@func2);
     writeln('линейный');
     count:=0;
     writeln('i: ', A.findOne());
     writeln('count = ', count);    // не обнуляет счетчик 5018, должно быть 5000. Прибавляет с бинарного счетчика
     writeln();

     writeln('бинарный');
     B.setFunc(@func2);
     writeln('isCorrect - ', B.isCorrect());
     count:=0;
     writeln('i: ', B.findOne());
     writeln('count = ', count);




     {
     writeln('---- findAll ----');
     outArr(A.findAll());

     writeln();
     writeln('--- бинарный ---');
     B:= TBinFinder.Create([9, 3, 3, 4, 4, 7, 3, 9]);
     B.setFunc(@func2);
     //B.printArr;
     writeln('isCorrect - ', B.isCorrect());
     B.replaceArr([3, 3, 3, 4, 4, 7, 9, 9]);
     //B.printArr;
     writeln('isCorrect - ', B.isCorrect());
     count:=0;
     writeln('индекс 3: ', B.findOne());
     writeln('count = ', count);

     writeln();
     writeln('TBinFinder.findAll()');
     outArr(B.findAll());

     writeln();
     writeln('TAbstractFinder.findOneEl');
     //A.printArr;
     //B.printArr;
     writeln('поиск по A(5): ', A.findOneEl(5));
     writeln('поиск по B(4): ', B.findOneEl(4));

     writeln();
     writeln('поиск с передачей func A(7)');
     //A.printArr;
     writeln('индекс 7: ', A.findOneFunc(@func2));

     writeln();
     writeln('поиск всех с передачей func ');
     //A.printArr;
     //B.printArr;
     f1:= @func1;
     f2:= @func2;
     writeln('поиск по A(5): ');
     outArr(A.findAllFunc(@func2));
     writeln('поиск по B(4): ');
     outArr(B.findAllFunc(@func2));
     //writeln('поиск по B(4): ', B.findAllFunc(@func2));

     writeln();
     writeln('поиск всех с передачей el ');
     //A.printArr;
     //B.printArr;
     f1:= @func1;
     f2:= @func2;
     writeln('поиск по A(5): ');
     outArr(A.findAllEl(5));
     writeln('поиск по B(4): ');
     outArr(B.findAllEl(4));
     //writeln('поиск по B(4): ', B.findAllFunc(@func2));

     A.Free;
     B.Free;}
end.
