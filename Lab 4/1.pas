{$mode objfpc}

function getMax(a, b:integer):integer;
begin
    if (a >= b) then 
        result := a
    else 
        result := b;
end;

function getMax(a, b, c:integer):integer;
begin
    result := getMax(getMax(a, b), c); 
end;

function getMax(a, b, c, d:integer):integer;
begin
    result := getMax(getMax(a, b, c), d); 
end;

function getMax(a, b, c, d, e:integer):integer;
begin
    result := getMax(getMax(a, b, c, d), e); 
end;


BEGIN
    writeln(getMax(5, 4, 3, 3, 0));
END.

