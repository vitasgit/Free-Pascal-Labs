program project1;

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
//  s:=TFileStream.Create('str.dat',fmCreate);
//  WData(s);

  s:=TFileStream.Create('str.dat',fmOpenRead);
  RData(s);
  s.Free;
end.

