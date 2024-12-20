{$mode objfpc}
{$WARN 6058 OFF}
uses sysutils, variants;

operator := (x:string):double;
var
    Code: Word;
    tmp: double;
begin
    Val(x, tmp, Code);

    if Code <> 0 then tmp := 0.0;

    Result := tmp;
end;

// operator explicit (x:string):double;
// begin
//     result := StrToFloatDef(x, 0.0);
// end;

function getType(x:double):string;
begin
    result := 'double';
end;

function getType(x:real):string;
begin
  result := 'real';
end;


var
    s: string;
    a: double;
BEGIN
	s := 'awdadw'; // Некорректная строка
    a := s;        // Используем оператор присваивания
    writeln(a); // Вывод: 0.00
    writeln(getType(s));
END.

