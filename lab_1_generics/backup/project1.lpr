program project1;

uses heaptrc, Unit1;
var
  //x: TFloatMemStorage;
  //y: TIntMemStorage;
  z: TByteFileStorage;
  z2: TStringFileStorage;
  y: TInt64MemStorage;
  y2: TExtendedMemStorage;
begin
  //writeln('awdadw');

  //y:= TInt64MemStorage.Create;
  //y[5]:= 7;
  //y[3]:= 8;
  //writeln(y[0]);
  //writeln(y[3]);
  //writeln(y[5]);
  //writeln('count = ', y.count);
  //y.free;

  //y2:= TExtendedMemStorage.Create;
  //y2[0]:= 1.25;
  //y2[3]:= 2.35;
  //writeln(y2[0]:0:2);
  //writeln(y2[1]:0:2);
  //writeln(y2[3]:0:2);
  //writeln('count = ', y2.count);
  //y2.free;

  z:= TByteFileStorage.Create('byte');
  z[0]:= 1;
  z[1000000]:= 2;
  writeln(z[0]);
  writeln(z[1000000]);
  //writeln(z[2000000]);
  writeln('count = ', z.count);
  z.free;

  //z2:= TStringFileStorage.Create('str');
  //z2[0]:= 'AB';
  //z2[1]:= 'B';
  //z2[2]:= 'C';
  //writeln(z2[0]);
  //writeln(z2[1]);
  //writeln('count = ', z2.count);
  //z2.free;



end.



