{$mode objfpc}
program n02;

 { тип множества }
type 
    TSingleSet = set of byte;
    TLongSet = array of TSingleSet;

procedure printSet(mySet:TLongSet);
var
    i: integer;
    j: byte;
begin
    for i := 0 to high(mySet) do
    begin
        for j := 0 to 255 do
        begin
            if j in mySet[i] then
                writeln(j);
        end;
    end;
end;

 { создание множества на count элементов
   реальное кол-во элементов всегда будет выравнено по границе, кратной 256 }
function createSet(count:integer):TLongSet;
var
    resSet: TLongSet;
    i, len: integer;
    j: byte;
begin
    len := ((count + 255) div 256);
    setLength(resSet, len);

    for i := 0 to len-1 do
    begin
        for j := 0 to 255 do
        begin
            resSet[i] += [j];
        end;
    end;
    
    result := resSet;
end;


{ изменение размера множества
   множество может как увеличено, так и уменьшено
   в последнем случае возможна утеря элементов }
procedure setSize(var dstSet:TLongSet; newCount:integer);
var
    newLen, oldLen: integer;
    i: integer;
    j: byte;
begin
    oldLen := Length(dstSet);
    newLen := ((newCount + 255) div 256);
    setLength(dstSet, newLen);

    if oldLen < newLen then
    begin
        for i := oldLen to newLen-1 do
        begin
            for j := 0 to 255 do
            begin
                dstSet[i] += [j];
            end;
        end;
    end;

    // if oldLen < newLen then
    // begin
    //     for i := oldLen to newLen-1 do
    //     begin
    //         dstSet[i] := []
    //     end;
    // end;
end;


 { получение размера множества (кратно 256) }
function getSize(bSet:TLongSet): integer;
var
    i, counter: integer;
    j: byte;
    
begin
    counter := 0;
    for i := 0 to high(bSet) do
    begin
        for j := 0 to 255 do
        begin
            if j in bSet[i] then
                counter += 1;
        end;
    end;

    result := counter;
end;


{ уничтожение множества }
procedure destroySet(var dstSet:TLongSet);
var
    i: integer;
begin
    for i := 0 to Length(dstSet)-1 do
    begin
        dstSet[i] := [];
    end;
end;


 { аналог операции in }
function inSet(bSet:TLongSet; e:integer):boolean;
var
    i: integer;
    j: byte;
begin
    result := false;
    for i := 0 to Length(bSet)-1 do
    begin
        if e in bSet[i] then
        begin
            result := true;
            break;
        end;
        // for j := 0 to 255 do
        // begin
        //     if (j = e) and (j in bSet[i]) then
        //     begin
        //         result := true;
        //     end;
        // end;
    end;
end;


 { аналог операции +, возвращает новое множество минимально необходимого размера}
function sumSet(set1,set2:TLongSet):TLongSet; 
var
    len: integer;
    resSet: TLongSet;
begin
    len := Length(set1) + Length(set2);
    setLength(resSet, len);

    
    
    result := resSet;
end;


var 
    mySet: TLongSet;
    set1, set2: TLongSet;

begin
    mySet := createSet(3);
    writeln('массив: ', Length(mySet));
    
    set1 := createSet(3);
    set2 := createSet(3);
    writeln('массив1: ', Length(set1));
    writeln('массив2: ', Length(set2));

    mySet := sumSet(set1, set2);
    writeln('массив(+): ', Length(mySet));
    printSet(mySet);

    

end.