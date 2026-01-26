unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

//для реализации п2, необходимо перезаписать: read write seek
{
пример из исходников, как люди перезаписывают read write seek

TProxyStream = class(TStream)
public
  function Read(var Buffer; Count: Longint): Longint; override;
  function Write(const Buffer; Count: Longint): Longint; override;
  function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
end;
}

// структура записи
type
    TPerson = record
        fio: AnsiString;
        gender: AnsiString;
        bdate: AnsiString;
        id: AnsiString;
        childrenID: array of AnsiString;
    end;

// реализация п2
  { TMyStream }

  TMyStream = Class(TStream)
    private
      FData: array of Byte;   // место, куда будут записыватья данные
      FPosition: Int64;  // позиция в потоке
    Public
      Constructor Create();
      Destructor Destroy; override;
      function Read(var Buffer; Count: Longint): Longint; override;
      function Write(const Buffer; Count: Longint): Longint; override;
      function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
    end;

// глобальный массив для п1
var
  data: array of TPerson;

// п1
procedure LoadData(S: TStream);
procedure SaveData(S: TStream);

// п1
procedure inputData;  // нужен для stdin потока
procedure outData;  // вывод в stdin

//п3
procedure ReaderData(S: TStream);
procedure WriterData(S: TStream);


implementation

// загружает данные из потока, из бинарного файла
// загружает в глобальный масссив data
procedure LoadData(S: TStream);
var
  i, j, len, len2: Integer;
begin
  len := 0;
  // ReadBuffer - записывает в len размер потока s в байтах
  s.ReadBuffer(len, SizeOf(len));
  SetLength(data, len);  // уст размер для data в соот с размером потока

  // перебор потока
  for i:= 0 to len-1 do
  begin
    data[i].fio := S.ReadAnsiString;  // записываем AnsiString из потока в данные data
    data[i].gender := S.ReadAnsiString;
    data[i].bdate := S.ReadAnsiString;
    data[i].id := S.ReadAnsiString;

    // работаем с потоком детей
    len2 := 0;
    S.ReadBuffer(len2, SizeOf(len2));
    SetLength(data[i].childrenID, len2);
    for j:= 0 to len2-1 do
    begin
      data[i].childrenID[j] := S.ReadAnsiString;
    end;

  end;
end;

// сохраняет данные в поток, в бинарный файл (в дальнейшем с него можно считывать данные)
procedure SaveData(S: TStream);
var
  i, j, len: Integer;
begin
  len := Length(data);
  S.WriteBuffer(len, SizeOf(len));  // устанавливаем потоку размер, размер берем из буффера

  for i:= 0 to High(data) do
  begin
    S.WriteAnsiString(data[i].fio);  // записываем строки в буффер
    S.WriteAnsiString(data[i].gender);
    S.WriteAnsiString(data[i].bdate);
    S.WriteAnsiString(data[i].id);

    len := Length(data[i].childrenID);
    S.WriteBuffer(len, SizeOf(len));

    for j:= 0 to len-1 do
    begin
      S.WriteAnsiString(data[i].childrenID[j]);
    end;
  end;
end;

procedure WriterData(S: TStream);
var
  w: TWriter;
  i, j: Integer;
begin
  // экзмепляр класса TWriter
  w := TWriter.Create(s, 1024);  // s - поток, 1024кб - буфер

  w.WriteListBegin;  // сигнатура начала всего списка
  for i:= 0 to High(data) do
  begin
    //w.WriteListBegin;  // лишняя сигнатура данных
    w.WriteString(data[i].fio);
    w.WriteString(data[i].gender);
    w.WriteString(data[i].bdate);
    w.WriteString(data[i].id);

    w.WriteListBegin; // сигантура начала детей
    for j:= 0 to High(data[i].childrenID) do
    begin
      w.WriteString(data[i].childrenID[j]);
    end;

    w.WriteListEnd; // сигнатура конца детей
    //w.WriteListEnd;  // лишняя сигнатура данных
  end;

  w.WriteListEnd; // сигнатура конца всего списка
  w.Free; // освобождаем экз класса TWriter, поток сохраняется
end;

{
сигнатуру начал и конца необходимо выставлять там, где неопределенное количество даннах
если известно, что всегда считываеются 4 строчки, то выставлять сигнатуру необязательно
сигнатура конца работает в связки с циклом while not r.EndOfList do
}
procedure ReaderData(S: TStream);
var
  r: TReader;
  i, j: Integer;
begin
  // экзмепляр класса TReader
  r := TReader.Create(s, 1024);  // s - поток, 1024кб - буфер
  SetLength(data, 0);  // инициализируем массив людей
  i := 0;

  r.ReadListBegin;  // сигнатура начала всего списка
  while not r.EndOfList do // пока не встретится сиганутра конца
  begin
    SetLength(data, i+1);
    //r.ReadListBegin;  // лишняя сигнатура данных
    data[i].fio:= r.ReadString;  // записываем данные в data из потока
    data[i].gender:= r.ReadString;
    data[i].bdate:= r.ReadString;
    data[i].id:= r.ReadString;

    r.ReadListBegin;  // сигнатура начала детей
    j := 0;
    SetLength(data[i].childrenID, 0);  // инициализируем массив детей
    while not r.EndOfList do
    begin
      SetLength(data[i].childrenID, j+1);  // расширяем массив
      data[i].childrenID[j] := r.ReadString;  // записываем данные в data из потока
      j:= j+1; // переход на след ребенка
    end;

    r.ReadListEnd;  // сигнатура конца детей
    //r.ReadListEnd; // лишняя сигнатура данных
    i := i+1;
  end;

  r.ReadListEnd;  // сигантура конца всего списка
  r.Free;  // освобождаем экз класса TReader, поток сохраняется
end;


// ввод данных как в первой лабораторной с учетом AnsiString
procedure inputData;
var
  p: TPerson;
  s: AnsiString;
  i, k, dataLenght, childrenIDLenght: Integer;
begin
  i := 0;

  dataLenght := 0;
  setLength(data, dataLenght);

  while not eof do
  begin
    dataLenght := dataLenght+1;
    setLength(data, dataLenght);

    readln(p.fio);
    readln(p.gender);
    readln(p.bdate);
    readln(p.id);

    childrenIDLenght := 0;
    setLength(p.childrenID, childrenIDLenght);

    k := 0;  // индекс массива детей
    readln(s);
    while s <> '' do
    begin
      childrenIDLenght := childrenIDLenght+1;
      setLength(p.childrenID, childrenIDLenght);

      p.childrenID[k] := s;
      k := k+1;
      readln(s);
    end;

    data[i] := p;
    i := i+1;
  end;
end;

// вывод данных как в первой лабораторной
procedure outData;
var
  i, j, g2: Integer;
  find: Boolean;
begin
  for i:= 0 to High(data) do
  begin
    writeln(i+1, ')');
    writeln('ФИО:  ', data[i].fio);
    writeln('Пол:  ', data[i].gender);
    writeln('рожд: ', data[i].bdate);
    writeln('id:   ', data[i].id);

    write('Дети: ');
    if Length(data[i].childrenID) = 0 then
      writeln('Нет')
    else
    begin
      for j := 0 to High(data[i].childrenID) do
      begin
        find:= False;
        write('id: ', data[i].childrenID[j], ', ');
        for g2:= 0 to High(data) do
            begin
                if data[g2].id = data[i].childrenID[j] then
                begin
                    find := True;
                    writeln('ФИО: ', data[g2].fio);
                    break;
                end;
            end;
      end;
      if not find then writeln('ФИО: ---');

    end;
    writeln('-----------------------------------');
  end;
end;

{ TMyStream }

constructor TMyStream.Create();
begin
  inherited Create;
  SetLength(FData, 0);
  FPosition:=0;
end;

destructor TMyStream.Destroy;
begin
  SetLength(FData, 0);
  inherited Destroy;
end;

function TMyStream.Read(var Buffer; Count: Longint): Longint;
var
  countBytes: LongInt;
begin
  countBytes:= Length(FData) - FPosition;
  if countBytes <= 0 then Exit(0);
  if countBytes < count then count:= countBytes;

  move(FData[FPosition], Buffer, count);
  FPosition:= FPosition + count;
  Result:= count;
end;

function TMyStream.Write(const Buffer; Count: Longint): Longint;
begin
  if FPosition+count > Length(FData) then SetLength(FData, FPosition+count);

  move(Buffer, FData[FPosition], count);
  FPosition:= FPosition + count;

  Result:= count;
end;

function TMyStream.Seek(const Offset: int64; Origin: TSeekOrigin): int64;
begin
  Case Word(Origin) of
    soFromBeginning: FPosition:= Offset;
    soFromEnd: FPosition:= Length(FData)+Offset;
    soFromCurrent: FPosition:= FPosition+Offset;
  end;
  if FPosition < 0 then FPosition:= 0;
  Result:= FPosition;
end;

// пример seek из исходников
{
function TCustomMemoryStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Case Word(Origin) of
    soFromBeginning : FPosition:=Offset;
    soFromEnd       : FPosition:=FSize+Offset;
    soFromCurrent   : FPosition:=FPosition+Offset;
  end;
  Result:=FPosition;
  {$IFDEF DEBUG}
  if Result < 0 then
    raise Exception.Create('TCustomMemoryStream');
  {$ENDIF}
end;
}

end.
