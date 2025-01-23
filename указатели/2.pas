{$mode objfpc}
program n0;
type 
    TSingleSet = set of byte;
    TLongSet = array of TSingleSet;

procedure poo(dstSet:TLongSet);  // процедура принимает в переменную dstSet адрес 
begin
    WriteLn('dstSet: ', HexStr(NativeInt(@dstSet), 8));
end;


var
    mySet: TLongSet;
begin
    setLength(mySet, 1);
    mySet[0] := [0..10];

    WriteLn('mySet: ', HexStr(NativeInt(@mySet), 8));  // выводит адрес массива mySet

    poo(mySet);  // передаем адрес на массив mySet
end.
