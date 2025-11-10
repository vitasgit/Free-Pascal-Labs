program project1;

uses heaptrc, Unit1;
var
  //A: TMemStorage;
  x: TFloatMemStorage;
  y: TIntMemStorage;
  z: TIntFileStorage;
begin
  //A:= TMemStorage.Create;
  //writeln('класс: ', A.ClassName);
  //writeln('родитель: ', A.ClassParent.ClassName);

  //x:=TFloatMemStorage.Create;
  //x[0]:= 1.2;
  //x[0]:= 1.5;
  //writeln(x[0]:0:2);
  //writeln(x[2]:0:2);
  //writeln('count = ', x.count);
  //x.free;

  //y:= TIntMemStorage.Create;
  //y[5]:= 7;
  //y[3]:= 8;
  //writeln(y[1]);
  //writeln(y[3]);
  //writeln(y[5]);
  //writeln('count = ', y.count);
  //y.free;
  //
  z:=TIntFileStorage.Create('abc');
  z[0]:= 1;
  z[1000000]:= 2;
  writeln(z[0]);
  writeln(z[1000000]);
  writeln(z[2000000]);
  writeln('z count = ', z.count);
  z.free;
end.



