{$mode objfpc}
unit testFuncs;
interface

function test_getMax():boolean;


implementation
uses funcs;

function test_getMax():boolean;
var
    count := 0;
begin
    // for i := 1 to 2 do
    //     for j := 1 to 2 do
    //         if (getMax(i, j) = ...) then ...

    if (getMax(1, 2) = 2) and
       (getMax(1, 2, 3) = 3) and
       (getMax(1, 2, 3, 4) = 4) and
       (getMax(1, 2, 3, 4, 5) = 5) then result := true
    else
        result := false;
end;


end.
