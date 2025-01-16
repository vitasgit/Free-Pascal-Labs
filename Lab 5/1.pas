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

operator + (x:variant; y:double):double;
begin
    result := y + VarToStrDef(x, 0.0);
end;

operator + (y:double; x:variant):double;
begin
    result := y + VarToStrDef(x, 0.0);
end;

operator + (x:variant; y:string):double;
begin
    result := VarToStrDef(x, 0.0) + StrToFloatDef(y, 0.0);
end;

operator + (y:string; x:variant):double;
begin
    result := StrToFloatDef(y, 0.0) + VarToStrDef(x, 0.0);
end;

operator - (x:double; y:string):double;
begin
    result := x - StrToFloatDef(y, 0.0);
end;

operator - (x:string; y:double):double;
begin
    result := StrToFloatDef(x, 0.0) - y;
end;

operator - (x:variant; y:double):double;
begin
    result := VarToStrDef(x, 0.0) - y;
end;

operator - (y:double; x:variant):double;
begin
    result := y - VarToStrDef(x, 0.0);
end;

operator - (x:variant; y:string):double;
begin
    result := VarToStrDef(x, 0.0) - StrToFloatDef(y, 0.0);
end;

operator - (y:string; x:variant):double;
begin
    result := StrToFloatDef(y, 0.0) - VarToStrDef(x, 0.0);
end;

operator * (x:double; y:string):double;
begin
    result := x * StrToFloatDef(y, 0.0);
end;

operator * (y:string; x:double):double;
begin
    result := x * y;
end;

operator * (x:variant; y:double):double;
begin
    result := y * StrToFloatDef(x, 0.0);
end;

operator * (y:double; x:variant):double;
begin
    result := y * StrToFloatDef(x, 0.0);
end;

operator * (x:variant; y:string):double;
begin
    result := y * StrToFloatDef(x, 0.0);
end;

operator * (y:string; x:variant):double;
begin
    result := y * StrToFloatDef(x, 0.0);
end;

operator / (x:double; y:string):double;
begin
    result := x / StrToFloatDef(y, 0.0);
end;

operator / (x:string; y:double):double;
begin
    result := StrToFloatDef(x, 0.0) / y;
end;

operator / (x:variant; y:double):double;
begin
    result := VarToStrDef(x, 0.0) / y;
end;

operator / (y:double; x:variant):double;
begin
    result := y / VarToStrDef(x, 0.0);
end;

operator / (x:variant; y:string):double;
begin
    result := VarToStrDef(x, 0.0) / StrToFloatDef(y, 0.0);
end;

operator / (y:string; x:variant):double;
begin
    result := StrToFloatDef(y, 0.0) / VarToStrDef(x, 0.0);
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
    writeln('d= ', d:0:6);
    writeln('v= ', v);
    writeln('string(d) + string(d) = ', string(d) + string(d));
    writeln('double(v) + double(v) = ', double(v) + double(v):0:6);
    writeln();

    v := 'awd';
    s := '5.0';
    d := 3.0;
    writeln('v= ', v);
    writeln('s= ', s);
    writeln('d= ', d:0:6);
    writeln();

    writeln('v + s = ', v + s:0:6);
    writeln('s + v = ', s + v:0:6);
    writeln('v + d = ', v + d:0:6);
    writeln('d + v = ', d + v:0:6);
    writeln('d + s = ', d + s:0:6);
    writeln('s + d = ', s + d:0:6);
    writeln();
    
    writeln('v - s = ', v - s:0:6);
    writeln('s - v = ', s - v:0:6);
    writeln('v - d = ', v - d:0:6);
    writeln('d - v = ', d - v:0:6);
    writeln('d - s = ', d - s:0:6);
    writeln('s - d = ', s - d:0:6);
    writeln();
    
    writeln('v * s = ', v * s:0:6);
    writeln('s * v = ', s * v:0:6);
    writeln('v * d = ', v * d:0:6);
    writeln('d * v = ', d * v:0:6);
    writeln('d * s = ', d * s:0:6);
    writeln('s * d = ', s * d:0:6);
    writeln();
    
    writeln('v / s = ', v / s:0:6);
    writeln('v / d = ', v + d:0:6);
    writeln('d / s = ', d / s:0:6);
    writeln('s / d = ', s / d:0:6);
    writeln();

    // c := 123456;
    // writeln(c.IntReverse);

END.

