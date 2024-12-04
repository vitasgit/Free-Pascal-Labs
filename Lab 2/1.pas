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

// поменять тип переменной j
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
    len: integer;
begin
    len := Length(set1) + Length(set2);
    setLength(rSet, len);

    result := rSet;
end;


var 
    mySet: TLongSet;
    set1, set2, set3: TLongSet;
    i: integer;

begin
    mySet := createSet(320);
    writeln('массив: ', length(mySet));

    set1 := createSet(3);
    set2 := createSet(300);

    set3 := sumSet(set1, set2);
    
    writeln(length(set3));

end.