{$mode objfpc}
program n01;
uses
  SysUtils;
 
procedure shortintInfo(s: string);
var
	min, max, x: shortint;
	bites: integer;
	l_x, r_x: shortint;
	//oper: ....;
begin
    writeln(s);
    writeln(High(x));
    //n := random(max_i-min_i+1) + min_i;
    //min = High()
    //max = 
end;


var 
	s: string;
begin
	
	readln(s);
	
	if s = 'shortint' then
		shortintInfo(s)
	else
		writeln('err');
	
	// aWriteLn('Верхняя граница: ', High(Longint));
end.
