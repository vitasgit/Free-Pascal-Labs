{$mode objfpc}
program n02;

 { тип множества }
type 
    TSingleSet = set of byte;
    TLongSet = array of TSingleSet;


procedure fillSet(mySet:TLongSet);
var
    i: integer;
begin
    for i := 0 to length(mySet)-1 do
    begin
        mySet[i] := [0..255];
    end;
end;


procedure printSet(mySet:TLongSet);
var
    i: integer;
    j: byte;
begin
    for i := 0 to length(mySet)-1 do
    begin
        for j := 0 to 255 do
        begin
            if j in mySet[i] then
                write(j:4);
        end;
        writeln();
    end;
end;


 { создание множества на count элементов
   реальное кол-во элементов всегда будет выравнено по границе, кратной 256 }
function createSet(count:integer):TLongSet;
var
    rSet: TLongSet;
    len: integer;
begin
    len := ((count + 255) div 256);
    setLength(rSet, len);
    
    result := rSet;
end;


{ изменение размера множества
   множество может как увеличено, так и уменьшено
   в последнем случае возможна утеря элементов }
procedure setSize(var dstSet:TLongSet; newCount:integer);
var
    newLen: integer;
begin
    newLen := ((newCount + 255) div 256);
    setLength(dstSet, newLen);
end;


 { получение размера множества (кратно 256) }
function getSize(bSet:TLongSet): integer;
begin
    result := length(bSet) * 256;
end;


{ уничтожение множества }
procedure destroySet(var dstSet:TLongSet);
var
    i: integer;
begin
    setLength(dstSet, 0);
end;


 { аналог операции in }
function inSet(bSet:TLongSet; e:integer):boolean;
var
    i: integer;
begin
    result := false;
    for i := 0 to Length(bSet)-1 do
    begin
        if e in bSet[i] then
        begin
            result := true;
            break;
        end;
    end;
end;


 { аналог операции +, возвращает новое множество минимально необходимого размера}
function sumSet(set1,set2:TLongSet):TLongSet; 
var
    rSet: TLongSet;
    i, len: integer;
    el: byte;
begin
    if length(set1) >= length(set2) then
        len := length(set1)
    else
        len := length(set2);

    setLength(rSet, len);

    for i := 0 to length(set1)-1 do
    begin
        for el := 0 to 255 do
        begin
            if el in set1[i] then
                rSet[i] += [el];
        end;
    end;

    for i := 0 to length(set2)-1 do
    begin
        for el := 0 to 255 do
        begin
            if el in set2[i] then
                rSet[i] += [el];
        end;
    end;

    // for i := 0 to length(set1)-1 do
    // begin
    //     rSet[i] += set1[i];
    // end;

    // for i := 0 to length(set2)-1 do
    // begin
    //     rSet[i] += set2[i];
    // end;

    result := rSet;
end;


{ аналог операции -, возвращает новое множество минимально необходимого размера}
// вычесть из пустого множества
function subSet(set1,set2:TLongSet):TLongSet; 
var
    rSet: TLongSet;
    i: integer;
    el: byte;
begin
    setLength(rSet, length(set1));

    for i := 0 to length(set1)-1 do
    begin
        for el := 0 to 255 do
        begin
            if (el in set1[i]) and not(el in set2[i]) then
                rSet[i] += [el];
        end;
    end;

    result := rSet;

end;


{ аналог операции *, возвращает новое множество минимально необходимого размера}
function mulSet(set1,set2:TLongSet):TLongSet;
var
    rSet: TLongSet;
    i, len: integer;
    el: byte;
begin
    if length(set1) >= length(set2) then
        len := length(set2)
    else
        len := length(set1);

    setLength(rSet, len);
    
    for i := 0 to len-1 do
    begin
        for el := 0 to 255 do
        begin
            if (el in set1[i]) and (el in set2[i]) then
                rSet[i] += [el];
        end;
    end;

    result := rSet;
end;


var 
    mySet: TLongSet;
    set1, set2, set3: TLongSet;
    i: integer;

begin
    // mySet := createSet(3);
    // writeln('массив: ', length(mySet));

    // writeln(getSize(mySet));


    set1 := createSet(300);
    set2 := createSet(3);
    
    set1[0] := [1..10];
    set1[1] := [10..15];
    set2[0] := [5..9];
    //set2[1] := [13..15];
    writeln('set1');
    printSet(set1);
    writeln();
    writeln('set2');
    printSet(set2);
    writeln();

    set3 := sumSet(set1, set2);
    writeln('set3');
    printSet(set3);
    writeln('массив3: ', length(set3));


end.