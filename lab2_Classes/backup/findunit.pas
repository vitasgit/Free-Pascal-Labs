unit findUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, unit1;

type

  { TLineFinder }

  TLineFinder = class(TAbstractFinder)
    public
      function findOne(): integer; override;
      function findAll(): TArr; override;
      function isCorrect(): Boolean; override;
  end;

  { TBinFinder }

  TBinFinder = class(TAbstractFinder)
    public
      function findOne(): integer; override;
      function findAll(): TArr; override;
      function isCorrect(): Boolean; override;
  end;

implementation

{ TLineFinder }

function TLineFinder.findOne(): integer;
var
  i: integer;
begin
  for i:=0 to High(arr) do
  begin
    if func(arr[i]) = 1 then
    begin
      exit(i);
    end;
  end;
  result:= -1;   // нет в массиве

end;

function TLineFinder.findAll(): TArr;
var
  i, k, len: integer;
  ResArr: TArr;
begin
  len:= 0;
  SetLength(ResArr, 0);
  for i:= 0 to high(arr) do
  begin
    if (func(arr[i]) = 1) then
    begin
      len:= len+1;
      SetLength(ResArr, len);
      ResArr[len-1]:= i;
    end;
  end;

  result:= ResArr;
end;

function TLineFinder.isCorrect(): Boolean;
begin
  result:= True;
end;

{ TBinFinder }

function TBinFinder.findOne(): integer;
var
  l, r, m, resf: integer;
begin
  l:= 0;
  r:= high(arr);

  while(l <= r) do
  begin
    m:= (l+r) div 2;
    resf:= func(arr[m]);

    if (resf = 0) then exit(m);
    if (resf = -1) then r:= m-1;
    if (resf = 1) then l:= m+1;
  end;

  result:= -1;
end;

function TBinFinder.findAll(): TArr;
var
  len, i, l, r, m, resf: integer;
  resBeg, resEnd: integer;  // левая, правая граница элемента
  ResArr: TArr;
begin
  l:= 0;
  r:= high(arr);
  len:= 0;
  SetLength(ResArr, 0);
  resBeg:= -1; resEnd:= -1;

  while (l <= r) do
  begin
    m:= (l+r) div 2;
    resf:= func(arr[m]);

    if (resf = 0) then
    begin
      resBeg:= m;
      while ( (resBeg >= 0 ) and ( func(arr[resBeg]) = 0) ) do resBeg:= resBeg-1;
      resBeg:= resBeg+1;

      resEnd:= m;
      while ( (resEnd <= high(arr)) and (func(arr[resEnd]) = 0) ) do resEnd:= resEnd+1;
      resEnd:= resEnd-1;

      break;
    end;

    if (resf = -1) then r:= m-1;
    if (resf = 1) then  l:= m+1;
  end;

  if resBeg <> -1 then
  begin
    len:= (resEnd-resBeg) + 1;
    SetLength(ResArr, len);
    for i:= resBeg to resEnd do ResArr[i-resBeg]:= i;
  end;

  result:= ResArr;
end;

function TBinFinder.isCorrect(): Boolean;
var
  i: integer;
begin
  for i:= 0 to high(arr)-1 do
  begin
    if arr[i] > arr[i+1] then exit(False);
  end;

  result:= True;
end;

end.

