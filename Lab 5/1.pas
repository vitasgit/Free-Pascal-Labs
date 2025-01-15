{$mode objfpc}
{$WARN 6058 OFF}
{$modeswitch typehelpers}  
{$H+}
uses sysutils, variants;

// type  
//     TIntReverseHelper = type helper (TIntegerHelper) for integer  
//         procedure IntReverse;
// end;

// procedure TIntReverseHelper.IntReverse;
// var
//     tmp: integer;
// begin
//     tmp := self;
//     result := 0;
//     while tmp > 0 do
//     begin
//         result := (result * 10) + (tmp mod 10);
//         tmp := tmp div 10;
//     end;
// end;


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

operator + (x:double; y:string):double;
begin
    result := x + StrToFloatDef(y, 0.0);
end;

operator + (y:string; x:double):double;
begin
    result := x + y;
end;

operator - (x:double; y:string):double;
begin
    result := x - StrToFloatDef(y, 0.0);
end;

operator - (x:string; y:double):double;
begin
    result := StrToFloatDef(x, 0.0) - y;
end;

operator * (x:double; y:string):double;
begin
    result := x * StrToFloatDef(y, 0.0);
end;

operator * (y:string; x:double):double;
begin
    result := x * y;
end;

operator / (x:double; y:string):double;
begin
    result := x / StrToFloatDef(y, 0.0);
end;

operator / (x:string; y:double):double;
begin
    result := StrToFloatDef(x, 0.0) / y;
end;



var
    s: string;
    d: double;
    v: variant;
    c: integer;
BEGIN
    s := 5.0;
    d := '3.0';
    v := '123.0';
    writeln('s= ', s);
    writeln('d= ', d);
    writeln('v= ', v);
    writeln('s+d= ',s + d);
    writeln('s-d= ', s - d);
    writeln('string(d) + string(d)= ', string(d) + string(d));
    writeln('double(v) + double(v)= ', double(v) + double(v));
    writeln('v+d= ', v + d);

    // writeln(1.5 + '2.0');
    // writeln('2.0' + 1.5);
    writeln('s*d= ', s * d);
    writeln('3.0*2.0= ', '3.0' * 2.0);
    writeln('s/d= ', s / d);
    
    // c := 123456;
    // writeln(c.IntReverse);

END.

