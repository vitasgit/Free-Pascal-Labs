program project3;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, sRW
  { you can add units after this };
  // TStream

 var s,f:TStream;
begin
  s:=TMemoryStream.Create();
  WData(s);
  writeln('------------');
  s.position:=0;
  f:=TFileStream.Create('str.dat',fmOpenWrite);
  f.position:=f.size;
  f.copyFrom(s,s.Size);
  f.free;
  s.Free;
end.

