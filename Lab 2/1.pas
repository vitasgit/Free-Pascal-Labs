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

    // for i := 0 to Length(dstSet)-1 do
    // begin
    //     dstSet[i] := [];
    // end;
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
    i, j, len: integer;
    k: byte;
begin
    if length(set1) >= length(set2) then
        len := length(set1)
    else
        len := length(set2);

    setLength(rSet, len);
    
    for i := 0 to length(set1)-1 do
    begin
        rSet[i] += set1[i];
    end;

    for i := 0 to length(set2)-1 do
    begin
        rSet[i] += set2[i];
    end;

    result := rSet;
end;


{ аналог операции -, возвращает новое множество минимально необходимого размера}
function subSet(set1,set2:TLongSet):TLongSet; 
var
    rSet: TLongSet;
    len: integer;
begin
    
    result := rSet;
end;


{ аналог операции *, возвращает новое множество минимально необходимого размера}
// убрать hardcode
function mulSet(set1,set2:TLongSet):TLongSet;
var
    rSet: TLongSet;
    len: integer;
    i, j: integer;
    k: byte;
begin
    len := 1;
    setLength(rSet, len);

    for i := 0 to length(set1)-1 do
    begin
        for j := 0 to length(set2)-1 do
        begin
            for k := 0 to 255 do
            begin
                if (k in set1[i]) and (k in set2[j]) then
                begin
                    rSet[0] += [k];
                end;
            end;
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

    set1 := createSet(3);
    set2 := createSet(300);
    
    set1[0] := [0..10];
    set2[0] := [0..15];
    set2[1] := [0..5];
    printSet(set1);
    writeln();
    printSet(set2);
    writeln();

    set3 := sumSet(set1, set2);
    printSet(set3);
    writeln('массив3: ', length(set3));


    
    


end.