{$mode objfpc}
program n01;
uses
	SysUtils, math;


procedure BooleanInfo(s: string);
var
	x: Boolean;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', ord(Low(x)));
	writeln('Верхняя граница: ', ord(High(x)));
	writeln('Байт на переменную: ', sizeof(x));

	x := Boolean(Random(2));
	// for i := 0 to sizeof(x)-1 do
	// begin
	// 	px^ := 255;
	// 	Inc(px);
	// end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
        

	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure CharInfo(s: string);
var
	x: Char;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: #', s);
	writeln('Нижняя граница: #', ord(Low(x)));
	writeln('Верхняя граница: #', ord(High(x)));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: #', ord(x));

	if (x = low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: #', ord(pred(x)));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: #', ord(succ(x)));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure QWordInfo(s: string);
var
	x: QWord;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	x := low(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure CardinalInfo(s: string);
var
	x: Cardinal;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure WordInfo(s: string);
var
	x: word;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure ByteInfo(s: string);
var
	x: Byte;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure Int64Info(s: string);
var
	x: Int64;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure LongwordInfo(s: string);
var
	x: Longword;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure SmallIntInfo(s: string);
var
	x: smallint;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := High(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure ShortintInfo(s: string);
var
	x: Shortint;
	px: ^Byte;
	i: Integer;
begin
	px := @x;

    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	//x := low(x);
	writeln('Случайное значение: ', x);

	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));
	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


procedure LongintInfo(s: string);
var
	x: Longint;
	px: ^Byte;
	i: Integer;
begin
	px := @x;
    writeln('Исследуемый тип: ', s);
	writeln('Нижняя граница: ', Low(x));
	writeln('Верхняя граница: ', High(x));
	writeln('Байт на переменную: ', sizeof(x));

	//x :=  randomrange(Low(x), High(x)+1);
	for i := 0 to sizeof(x)-1 do
	begin
		px^ := Random(256);
		Inc(px);
	end;
	x := High(x);
	writeln('Случайное значение: ', x);
	
	if (x = Low(x)) then
		writeln('Предыдущее значение: Overflow')
	else
		writeln('Предыдущее значение: ', pred(x));

	if (x = High(x)) then
		writeln('Последующее значение: Overflow')
	else
		writeln('Последующее значение: ', succ(x));

	
	px := @x;
	write('Содержимое оперативной памяти: ');
    for i := 0 to sizeof(x)-1 do
    begin
        write(px^, ' ');
        Inc(px);
    end;
    writeln;
end;


var 
	s: string;
begin
	Randomize;
	readln(s);

	writeln(s);
	if s = 'shortint' then ShortintInfo(s)
	else if s = 'smallint' then SmallIntInfo(s)
	else if s = 'longint' then LongintInfo(s)
	else if s = 'longword' then LongwordInfo(s)
	else if s = 'int64' then Int64Info(s)
	else if s = 'byte' then ByteInfo(s)
	else if s = 'word' then WordInfo(s)
	else if s = 'cardinal' then CardinalInfo(s)
	else if s = 'qword' then QWordInfo(s)
	else if s = 'char' then CharInfo(s)
	else if s = 'boolean' then BooleanInfo(s)
	else writeln('Error');

end.
