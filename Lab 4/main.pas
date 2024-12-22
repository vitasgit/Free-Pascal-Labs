{$mode objfpc}
uses funcs;

var
    x: real = 123.026;
    int_x, frac_x: real;
    s: string = 'abc123 *7., h ';
    countDigits, countSpaces, countOther: integer;

BEGIN
    //writeln(getMax(5, 4, 3, 3, 0));
    //writeln(getType(a));
    //getIntFrac(x, int_x, frac_x);
    //writeln(x:0:4, ' ',  int_x:0:1, ' ',  frac_x:0:4);
    getStrChr(s, countDigits, countSpaces, countOther);
    writeln(countDigits, ' ', countSpaces, ' ', countOther);

END.

