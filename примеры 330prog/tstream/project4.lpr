program project4;

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
//  s:=TMemoryStream.Create();
  s:=TFileStream.Create('multidata.dat',fmCreate);
  WriterData(s);
  s.position:=0;
  ReaderData(s);
  s.Free;
end.

