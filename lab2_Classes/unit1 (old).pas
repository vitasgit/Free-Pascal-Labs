unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
    TCompare = function(a, b: integer): integer;
    arrvar = array of integer;  // глобальный массив?? (есть ли конфликт с class var arr: array of integer;)

  { TAbstractFinder }

  TAbstractFinder = class
    protected
      //arr: array of integer;  // используется внутри объекта
      class var arr: array of integer;  // общий набор данных, доступный по наследованию
      class var cmp: TCompare;

    public
      constructor Create(_arr: array of integer);

      // Процедура замены текущего набора данных на новый (статическая)
      class procedure replaceArr(_arr: array of integer);static;
      class procedure setCmp(_cmp: TCompare);static;
      //function isCorrect();virtual;abstract;  // Функция проверки корректности набора данных (abstract)
      procedure printArr;
  end;

implementation

{ TAbstractFinder }


constructor TAbstractFinder.Create(_arr: array of integer);
var
  i: integer;
begin
  SetLength(arr, Length(_arr));
  for i:= 0 to High(_arr) do
  begin
    arr[i] := _arr[i];
  end;
end;

class procedure TAbstractFinder.replaceArr(_arr: array of integer);
var
  i: integer;
begin
  SetLength(arr, Length(_arr));
  for i:= 0 to High(_arr) do
  begin
    arr[i] := _arr[i];
  end;
end;

// Процедура установки текущего метода сравнения двух элементов (статическая)
class procedure TAbstractFinder.setCmp(_cmp: TCompare);
begin
  cmp := _cmp;
end;

procedure TAbstractFinder.printArr;
var
  i: integer;
begin
  for i:= 0 to High(arr) do
  begin
    write(arr[i], ' ');
  end;
  writeln;

end;

end.

