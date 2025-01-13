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
    if  (getMax(-2, -2) = -2) and
        (getMax(-2, -1) = -1) and
        (getMax(0, -2) = 0) and
        (getMax(-2, 1) = 1) and
        (getMax(0, 1) = 1) and
        (getMax(1, 1) = 1) and
        (getMax(-3, -3, -3) = -3) and
        (getMax(-3, -3, -2) = -2) and
        (getMax(-3, -3, 0) = 0) and
        (getMax(-3, -2, -3) = -2) and
        (getMax(-3, -2, -2) = -2) and
        (getMax(-3, -2, 0) = 0) and
        (getMax(-2, 2, -2) = 2) and
        (getMax(1, 2, -3) = 2) and
        (getMax(2, 2, 2) = 2) and
        (getMax(1, 2, 3) = 3) and
        (getMax(-4, -4, -4, -4) = -4) and
        (getMax(-4, -4, -4, -3) = -3) and
        (getMax(-4, -4, -4, 0) = 0) and
        (getMax(-4, -3, -2, -1) = -1) and
        (getMax(-4, -4, -4, -4) = -4) and
        (getMax(-1, 4, 3, 2) = 4) and
        (getMax(2, 2, 2, 2) = 2) and
        (getMax(-4, -4, -4, -4) = -4) and
        (getMax(3, 1, -4, 2) = 3) and
        (getMax(-4, -4, -4, -4) = -4) and
        (getMax(1, 2, 3, 4) = 4) and
        (getMax(-5, -5, -5, -5, -5) = -5) and
        (getMax(-5, -5, -5, -5, 0) = 0) and
        (getMax(-5, -5, -5, -5, -5) = -5) and
        (getMax(-5, -5, -4, -5, -5) = -4) and
        (getMax(-5, -5, -5, -5, -5) = -5) and
        (getMax(-5, -5, -4, -3, -5) = -3) and
        (getMax(5, 5, 5, 5, 5) = 5) and
        (getMax(4, 3, 3, 3, 3) = 4) and
        (getMax(-5, -5, -5, -5, -5) = -5) and
        (getMax(-5, -4, -3, -2, -1) = -1) and
        (getMax(1, 2, 3, 4, 5) = 5) then result := true
    else
        result := false;
end;

function test_getType():boolean;
begin
    if  (getType(123) = 'integer') and
        (getType(1.23) = 'real') and
        (getType('abcd') = 'string') and
        (getType(true) = 'boolean') then result := true
    else
        result := false;
end;

function test_getIntFrac():boolean;
var
    intPart: integer;
    fracPart: real;
begin
    getIntFrac(456.789, intPart, fracPart);
    if not ((intPart = 456) and ((fracPart > 0.78895) and (fracPart < 0.78905))) then 
    begin
        result := false;
        exit;
    end;

    getIntFrac(-789.456, intPart, fracPart);
    if not ((intPart = -789) and ((fracPart > -0.45605) and (fracPart < -0.45595))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(1000.001, intPart, fracPart);
    if not ((intPart = 1000) and ((fracPart > 0.00095) and (fracPart < 0.00105))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(0.0, intPart, fracPart);
    if not ((intPart = 0) and ((fracPart > -0.00005) and (fracPart < 0.00005))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(-0.01, intPart, fracPart);
    if not ((intPart = 0) and ((fracPart > -0.01005) and (fracPart < -0.00995))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(1.0, intPart, fracPart);
    if not ((intPart = 1) and ((fracPart > -0.00005) and (fracPart < 0.00005))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(1.000001, intPart, fracPart);
    if not ((intPart = 1) and ((fracPart > -0.00000095) and (fracPart < 0.00000105))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(999999.999999, intPart, fracPart);
    if not ((intPart = 999999) and ((fracPart > 0.999995) and (fracPart < 1.0))) then
    begin
        result := false;
        exit;
    end;

    getIntFrac(0.999999, intPart, fracPart);
    if not ((intPart = 0) and ((fracPart > 0.999995) and (fracPart < 1.0))) then
    begin
        result := false;
        exit;
    end;

    result := true;
end;

function test_getStrChr():boolean;
var
    countDigits: integer;
    countSpaces: integer;
    countOther: integer;
begin
    getStrChr('', countDigits, countSpaces, countOther);
    if not ((countDigits = 0) and (countSpaces = 0) and (countOther = 0)) then
    begin
        result := false;
        exit;
    end;

    getStrChr('      ', countDigits, countSpaces, countOther);
    if not ((countDigits = 0) and (countSpaces = 6) and (countOther = 0)) then
    begin
        result := false;
        exit;
    end;

    getStrChr('1234', countDigits, countSpaces, countOther);
    if not ((countDigits = 4) and (countSpaces = 0) and (countOther = 0)) then
    begin
        result := false;
        exit;
    end;

    getStrChr('abc#', countDigits, countSpaces, countOther);
    if not ((countDigits = 0) and (countSpaces = 0) and (countOther = 4)) then
    begin
        result := false;
        exit;
    end;

    getStrChr('abc#', countDigits, countSpaces, countOther);
    if not ((countDigits = 0) and (countSpaces = 0) and (countOther = 4)) then
    begin
        result := false;
        exit;
    end;

    getStrChr(' abc# 123 ', countDigits, countSpaces, countOther);
    if not ((countDigits = 3) and (countSpaces = 3) and (countOther = 4)) then
    begin
        result := false;
        exit;
    end;

    getStrChr('12\n34\tad@  ', countDigits, countSpaces, countOther);
    if not ((countDigits = 4) and (countSpaces =  2) and (countOther = 7)) then
    begin
        result := false;
        exit;
    end;

    result := true
end;


initialization

if  (test_getMax() = true) and
    (test_getType() = true) and
    (test_getIntFrac() = true) and
    (test_getStrChr() = true) then successFuncs := true
else
    successFuncs := false;


end.
