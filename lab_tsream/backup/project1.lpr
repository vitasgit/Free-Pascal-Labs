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
  inputData;
  s:= TFileStream.Create('data2.dat', fmCreate);
  //SaveData(s);
  //s.free;

  t:= TMyStream.Create();
  WriterData(t);
  //saveData(t);
  t.Position:=0;
  s.CopyFrom(t, t.Size);
  s.free;
  t.free;

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

