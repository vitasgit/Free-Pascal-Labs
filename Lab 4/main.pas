{$mode objfpc}
uses funcs, testFuncs;

var
    x: real = 123.000002555;
    int_x: integer; 
    frac_x: real;
    s: string = 'abc123 *7., h ';
    countDigits, countSpaces, countOther: integer;
    i, j, k, x1, x2, x3, x4, x5: integer;

BEGIN
    // writeln(getMax(5, 4, 3, 3, 0));
    // writeln(getType(a));
    // getIntFrac(x, int_x, frac_x);
    // writeln(x:0:4, ' ',  int_x:0:1, ' ',  frac_x:0:4);
    // getStrChr(s, countDigits, countSpaces, countOther);
    // writeln(countDigits, ' ', countSpaces, ' ', countOther);

    // writeln(test_getMax());
    // writeln(test_getType());
    // writeln(test_getIntFrac());
    // writeln(test_getStrChr());

    // writeln(validatedAll());

    if validatedAll then
    begin
        writeln('1: getMax');
        writeln('2: getType');
        writeln();

        writeln('Введите номер функции(0 - выход): ');
        readln(i);

        while i <> 0 do
        begin
            case i of 
                1: 
                begin
                    write('Введите 5 чисел: ');
                    readln(x1, x2, x3, x4, x5);
                    writeln('Макс(', x1, ', ', x2,'): ', getMax(x1, x2));
                    writeln('Макс(', x1, ', ', x2, ', ', x3, '): ', getMax(x1, x2, x3));
                    writeln('Макс(', x1, ', ', x2, ', ', x3, ', ', x4, '): ', getMax(x1, x2, x3, x4));
                    writeln('Макс(', x1, ', ', x2, ', ', x3, ', ', x4, ', ', x5, '): ', getMax(x1, x2, x3, x4, x5));
                end;
            end;
            
            writeln();
            writeln('Введите номер функции(0 - выход): ');
            readln(i);
        end;

    end;


END.

