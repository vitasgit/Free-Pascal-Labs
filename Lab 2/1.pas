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
            resSet[i] := resSet[i] + [j];
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
                dstSet[i] := dstSet[i] + [i];
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


var 
    mySet: TLongSet;
    i, c: integer;
    j: byte;

begin
    mySet := createSet(3);
    writeln('массив: ', Length(mySet));

    writeln(getSize(mySet));

    mySet := createSet(321);
    writeln(getSize(mySet));

end.