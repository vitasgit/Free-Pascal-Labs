{$mode objfpc}
uses funcs, testFuncs, sysUtils;

var
    x: real;
    int_x: integer; 
    frac_x: real;
    s: string;
    countDigits, countSpaces, countOther: integer;
    i, j, k, x1, x2, x3, x4, x5: integer;
    inputType_str: string;
    inputType_int: integer;
    inputType_real: real;
    inputType_bool: boolean;

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
        writeln('3: getIntFrac');
        writeln('4: getStrChr');
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

                2: 
                begin
                    write('Введите значение: ');
                    readln(inputType_str);

                    if tryStrToInt(inputType_str, inputType_int) then 
                        writeln(getType(inputType_int))
                    else if tryStrToFloat(inputType_str, inputType_real) then 
                        writeln(getType(inputType_real))
                    else if tryStrToBool(inputType_str, inputType_bool) then 
                        writeln(getType(inputType_bool))
                    else
                        writeln(getType(inputType_str));
                end;

                3:
                begin
                    write('Введите число: ');
                    readln(x);
                    getIntFrac(x, int_x, frac_x);
                    writeln('Целая: ', int_x);
                    writeln('Дробная: ', frac_x:0:4);
                end;

                4:
                begin
                    write('Введите строку: ');
                    readln(s);
                    getStrChr(s, countDigits, countSpaces, countOther);
                    writeln('Цифр: ', countDigits);
                    writeln('Пробелы: ', countSpaces);
                    writeln('Другие: ', countOther);
                end;
            end;
            
            writeln();
            writeln('Введите номер функции(0 - выход): ');
            readln(i);
        end;

    end;


END.

