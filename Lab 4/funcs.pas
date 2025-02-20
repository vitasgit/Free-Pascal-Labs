{$mode objfpc}
unit funcs;
interface

function getMax(a, b:integer):integer;
function getMax(a, b, c:integer):integer;
function getMax(a, b, c, d:integer):integer;
function getMax(a, b, c, d, e:integer):integer;

function getType(x:integer):string;
function getType(x:real):string;
function getType(x:string):string;
function getType(x:boolean):string;

procedure getIntFrac(x:real; var intPart:integer; var fracPart:real);
procedure getStrChr(s:string; var digits, spaces, otherChars:integer);

function validatedAll():boolean;


implementation
uses testFuncs;

function getMax(a, b:integer):integer;
begin
    if (a > b) then 
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
// end getMax

function getType(x:integer):string;
begin
    result := 'integer';
end;

function getType(x:real):string;
begin
    result := 'real';
end;

function getType(x:string):string;
begin
    result := 'string';
end;

function getType(x:boolean):string;
begin
    result := 'boolean';
end;
// end getType

procedure getIntFrac(x:real; var intPart:integer; var fracPart:real);
begin
    intPart := trunc(x);
    fracPart := frac(x);
end;

procedure getStrChr(s:string; var digits, spaces, otherChars:integer);
var
    ch: char;
begin
    digits := 0;
    spaces := 0;
    otherChars := 0;

    for ch in s do
    begin
        if ch in ['0'..'9'] then 
            digits += 1
        else if ch = ' ' then 
            spaces += 1
        else 
            otherChars += 1;
    end;
end;

function validatedAll():boolean;
begin
    result := successFuncs;
end;


end.