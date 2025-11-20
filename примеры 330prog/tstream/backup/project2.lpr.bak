program project2;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, sRW
  { you can add units after this };
  // TStream

 var s:TStream;
begin
  s:=TMemoryStream.Create();
  WData(s);
  writeln('------------');
  s.position:=0;
  RData(s);
  s.Free;
end.

