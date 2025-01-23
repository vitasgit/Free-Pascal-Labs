{$mode objfpc}
{$modeswitch typehelpers}
program n0;

type
    TIntReverseHelper = type helper for integer
        function IntReverse: integer;
    end;

function TIntReverseHelper.IntReverse: integer;
var
    tmp, reversed: integer;
begin
    tmp := Self;
    reversed := 0;

    while tmp > 0 do
    begin
        reversed := (reversed * 10) + (tmp mod 10);
        tmp := tmp div 10;
    end;

    Result := reversed;
end;


var
    x: integer;
begin
    x := 123;
    Writeln(x.IntReverse);
end.
