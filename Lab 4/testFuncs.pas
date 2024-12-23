{$mode objfpc}
unit testFuncs;
interface
var
    successFuncs: boolean;


function test_getMax():boolean;
function test_getType():boolean;
function test_getIntFrac():boolean;
function test_getStrChr():boolean;


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

function test_getIntFrac():boolean;
var
    x: real = 123.000002555;
    intPart: integer;
    fracPart: real;
begin
    getIntFrac(x, intPart, fracPart);

    if (intPart = 123) and ((fracPart < 0.000002556) and (fracPart > 0.000002554)) then 
        result := true
    else 
        result := false;
end;

function test_getStrChr():boolean;
var
    s: string = '32 daw5 %';
    countDigits: integer;
    countSpaces: integer;
    countOther: integer;
begin
    getStrChr(s, countDigits, countSpaces, countOther);
    if (countDigits = 3) and (countSpaces = 2) and (countOther = 4) then
        result := true
    else
        result := false;
end;


initialization

if  (test_getMax() = true) and
    (test_getType() = true) and
    (test_getIntFrac() = true) and
    (test_getStrChr() = true) then successFuncs := true
else
    successFuncs := false;

end.
