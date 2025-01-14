{$mode objfpc}
{$WARN 6058 OFF}
uses sysutils, variants;

operator := (x:string):double;
begin
    result := StrToFloatDef(x, 0.0);
end;

operator explicit (x:string):double;
begin
    result := StrToFloatDef(x, 0.0);
end;

operator := (x:double):string;
begin
    result := FloatToStrF(x, ffFixed, 8, 6);
end;

operator explicit (x:double):string;
begin
    result := FloatToStrF(x, ffFixed, 8, 6);
end;

var
    s: string;
    a: double;
BEGIN
    s := 123.123456078;
    a := 123.123456078;
    writeln(a+a);
    writeln(string(a)+string(a));

END.

