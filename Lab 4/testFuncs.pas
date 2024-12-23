{$mode objfpc}
unit testFuncs;
interface

function test_getMax():boolean;
function test_getType():boolean;


implementation
uses funcs;

function test_getMax():boolean;
begin        
    if (getMax(1, 2) = 2) and
       (getMax(1, 2, 3) = 3) and
       (getMax(1, 2, 3, 4) = 4) and
       (getMax(1, 2, 3, 4, 5) = 5) then result := true
    else
        result := false;
end;

function test_getType():boolean;
begin
    if (getType(123) = 'integer') and
       (getType(1.23) = 'real') and
       (getType('abcd') = 'string') and
       (getType(true) = 'boolean') then result := true
    else
        result := false;
end;


end.
