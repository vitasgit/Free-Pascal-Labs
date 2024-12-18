{$mode objfpc}
{$WARN 6058 OFF}
uses sysutils, variants;

operator := (x:string):double;
begin
	result := StrToFloatDef(x, 0.0);
    writeln(x);
end;

var
    s: variant;
    a: double;
BEGIN
	s := 'awdwa';  // не присваивает 0.0
    writeln(s);  // не выводит 0.0
    a := 1.2;
    writeln(a + s);  // 2.5
END.

