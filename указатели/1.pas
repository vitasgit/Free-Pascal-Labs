{$mode objfpc}
program n0;
var 
    x: integer;
    px: ^integer;  // указатель типа integer
begin
    x := 0;
    px := @x; // присваиваем адрес переменной x

    WriteLn('px: ', HexStr(NativeInt(px), 8));
    WriteLn('x: ', HexStr(NativeInt(@x), 8));
end.