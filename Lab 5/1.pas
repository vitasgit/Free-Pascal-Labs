{$mode objfpc}
{$WARN 6058 OFF}
uses sysutils, variants;

// operator := (x:string):double;
// begin
// 	result := StrToFloatDef(x, 0.0);
// end;

operator explicit (x:string):double;
begin
    result := StrToFloatDef(x, 0.0);
end;


var
    s: variant;
    a: double;
BEGIN
	s := 'awdadw';  // не присваивает 0.0
    writeln(s);  // не выводит 0.0
    a := 1.2;
    writeln(a + s);  // 2.5
END.

