{$mode objfpc}
program n02;

 { тип множества }
type 
    TSingleSet = set of byte;
    TLongSet = array of TSingleSet;


procedure printSet(mySet:TLongSet);
var
    i, j: integer;
begin
    for i := 0 to length(mySet)-1 do
    begin
        for j := 0 to 255 do
        begin
            if j in mySet[i] then
            begin
				write(256*i + j);
				write(' ');
            end;
        end;
    end;
    writeln();
end;


 { создание множества на count элементов
   реальное кол-во элементов всегда будет выравнено по границе, кратной 256 }
function createSet(count:integer):TLongSet;
var
    rSet: TLongSet;
    len: integer;
begin
    len := (count + 256) div 256;
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
var
	i, len, el: integer;
	j: byte;
begin
    // i := length(bSet) - 1;
    // for j := 0 to 255 do
    // begin
    //     if j in bSet[i] then
    //     begin
    //         el := 256*i + j;
    //     end;
    // end;

	result := length(bSet) * 256;
    //result := el + (256 - (el mod 256));
end;


{ уничтожение множества }
procedure destroySet(var dstSet:TLongSet);
begin
    setLength(dstSet, 0);
end;


 { аналог операции in }
function inSet(bSet:TLongSet; e:integer):boolean;
var
    i, start: integer;
begin
    result := false;
    start := ((e + 256) div 256)-1;
    e := (e mod 256);

    for i := start to Length(bSet)-1 do
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
    i, len, count: integer;
begin

    if length(set1) >= length(set2) then
    begin
        len := length(set1);
        setLength(set2, len);
    end
    else
    begin
        len := length(set2);
        setLength(set1, len);
    end;

    setLength(rSet, len);

    count := 0;
    for i := 0 to len-1 do
    begin
        rSet[i] := set1[i] - set2[i];

        if rSet[i] <> [] then count := i;
    end;

    setLength(rSet, count+1);

    result := rSet;
end;


{ аналог операции *, возвращает новое множество минимально необходимого размера}
function mulSet(set1,set2:TLongSet):TLongSet;
var
    rSet: TLongSet;
    i, len, count: integer;
begin
    if length(set1) >= length(set2) then
        len := length(set2)
    else
        len := length(set1);

    setLength(rSet, len);

    count := 0;
    for i := 0 to len-1 do
    begin
        rSet[i] := set1[i] * set2[i];

        if rSet[i] <> [] then count := i;
    end;

    setLength(rSet, count+1);


    result := rSet;
end;


{ симметричная разность множеств}
function symSet(set1,set2:TLongSet):TLongSet;
var
    rSet: TLongSet;
    i, len, count: integer;
begin
    if length(set1) >= length(set2) then
    begin
        len := length(set1);
        setLength(set2, len);
    end
    else
    begin
        len := length(set2);
        setLength(set1, len);
    end;

    setLength(rSet, len);

    count := 0;
    for i := 0 to len-1 do
    begin
        rSet[i] := set1[i] >< set2[i];

        if rSet[i] <> [] then count := i;
    end;

    setLength(rSet, count+1);
    result := rSet;
end;


 { аналог функции include, изменяет переданное множество
   при необходимости увеличивает его размер }
procedure includeSet(var dstSet:TLongSet; e:integer);
var
    i, minLen: integer;
begin
    minLen := (e + 256) div 256;
    if (Length(dstSet) < minLen) then setLength(dstSet, minLen);

    i := minLen - 1;
    e := (e + 256) mod 256;
    Include(dstSet[i], e);
end;


 { аналог функции exclude, изменяет переданное множество  }
procedure excludeSet(var dstSet:TLongSet; e:integer);
var
    i: integer;
begin
    i := ((e + 256) div 256) - 1;
    e := (e + 256) mod 256;
    exclude(dstSet[i], e);
end;


var 
    mySet: TLongSet;
    set1, set2, set3: TLongSet;
    i: integer;

begin
{
    mySet := createSet(600);
    includeSet(mySet, 1000);
    includeSet(mySet, 5000);
	printSet(mySet);
	writeln(getSize(mySet));
}
	
    set1 := createSet(3);
    set2 := createSet(3);
    includeSet(set1, 1000);
    includeSet(set1, 2000);
    includeSet(set1, 5000);
    includeSet(set2, 1001);
    includeSet(set2, 5000);
    printSet(set1);
    printSet(set2);
    set3 := symSet(set1, set2);
    printSet(set3);
    writeln(getSize(set3));

end.
