program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,heaptrc, Unit1, Unit2
  { you can add units after this };

var
  s: TStream;
  t: TMyStream;
begin
  //inputData;
  s:= TFileStream.Create('data22.dat', fmOpenRead);
  t:= TMyStream.Create();
  t.CopyFrom(s, s.size);
  t.Position:=0;
  //loaddata(t);
  ReaderData(t);
  outdata;
  s.free;
  t.free;

  //t:= TMyStream.Create();
  //s:= TFileStream.Create('data2.dat', fmOpenRead);
  ////ReaderData(s);
  //loaddata(s);
  ////t.Position:=0;
  //t.CopyFrom(s, s.Size);
  //writeln(t.Position);
  //s.free;
  //t.free;
  //outData;

  //t.CopyFrom(s, s.Size);
  //outData;
  //t.free;


  //s:= TFileStream.Create('data3.dat', fmCreate);
  //WriterData(s);
  //s.Position:=0;
  //ReaderData(s);
  //s.free;

  //s:= TFileStream.Create('data3.dat', fmOpenRead);
  //t:= TMyStream.Create();
  //t.CopyFrom(s, s.size);
  //s.free;
  //
  //t.Position:= 0;
  //ReaderData(t);
  //t.Free;
  //
  //outData;


  //writeln(s.Position);
  //s.Seek(10, soFromBeginning);
  //writeln(s.Position);
  //s.free;


end.

