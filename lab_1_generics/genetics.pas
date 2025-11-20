unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  //TData=pointer;

  { TAbstractStorage }

  generic TAbstractStorage<TData>=class
    protected
      function getData(position:qword):TData;virtual;abstract;
      procedure setData(position:qword; value:TData);virtual;abstract;
      function getCount:qword;virtual;abstract;

    protected
      property data[position:qword]:TData read getData write setData; default;
    public
      property count:qword read getcount;
  end;


  // класс с реализацией хранилища в оперативной памяти
 // с автоматическим расширением хранилища при попытке сохранения
 // данных за его пределами и возвратом нулевого значения
 // при попытке чтения данных за его пределами.
 { TMemStorage }

 generic TMemStorage<TData>=class(specialize TAbstractStorage<TData>)
    private
	fdata:array of TData;
    protected
	function getData(position:qword):TData;override;
	procedure setData(position:qword; value:TData);override;
	function getCount:qword;override;
 end;


 { TFileStorage }

 generic TFileStorage<TData> = class(specialize TAbstractStorage<TData>)
    private
	myFile: file;
    protected
	function getData(position:qword):TData;override;
	procedure setData(position:qword; value:TData);override;
	function getCount:qword;override;
    public
        constructor Create(fname: string);
        destructor Destroy; override;
 end;


 TInt64MemStorage = specialize TMemStorage<Int64>;
 TExtendedMemStorage = specialize TMemStorage<Extended>;
 TByteFileStorage = specialize TFileStorage<byte>;
 TStringFileStorage = specialize TFileStorage<ShortString>;


implementation

{ TMemStorage }

function TMemStorage.getData(position: qword): TData;
begin
  if position >= Length(fdata) then exit(nil);
  result:= fdata[position];

end;

procedure TMemStorage.setData(position: qword; value: TData);
begin
  if position >= Length(fdata) then SetLength(fdata, position+1);
  fdata[position]:= value;

end;

function TMemStorage.getCount: qword;
begin
  result:= Length(fdata);

end;

{ TIntMemStorage }

function TIntMemStorage.getIData(position: qword): integer;
begin
  result:= integer(getData(position));
end;

procedure TIntMemStorage.setIData(position: qword; value: integer);
begin
  setData(position, Pointer(value));
end;

{ TFloatMemStorage }

function TFloatMemStorage.getfData(position: qword): extended;
var
  p: ^extended;
begin
  p:= getData(position);  // получили адрес, где лежит число типа extended

  if p = nil then
     result:= 0.0
  else
     result:= p^;

end;

procedure TFloatMemStorage.setfData(position: qword; value: extended);
var
  p: ^extended;
begin
  if getData(position) = nil then
  begin
  //freemem(getData(position));
      p:= GetMem(sizeof(extended));
      setData(position, p);
  end;

  p^:= value;    // разыменовали p и положили значение
end;

destructor TFloatMemStorage.Destroy;
var
  i: integer;
begin
  for i:= 0 to High(fdata) do
  begin
       Freemem(fdata[i]);
  end;

  inherited Destroy;
end;

{ TFileStorage }

function TFileStorage.getData(position: qword): TData;
var
   buf: TData;
begin
  if position >= FileSize(myFile) then exit(nil);

  seek(myFile, position);
  BlockRead(myFile, buf, 1);
  result:= buf;
end;

procedure TFileStorage.setData(position: qword; value: TData);
begin
  //if position >= Length(fdata) then SetLength(fdata, position+1);
  //fdata[position]:= value;

  //if position >= FileSize(myFile) then seek(myFile, position);

  seek(myFile, position);
  BlockWrite(myFile, value, 1);
  end;

function TFileStorage.getCount: qword;
begin
  result:= FileSize(myFile);
end;

constructor TFileStorage.Create(fname: string);
begin
  Assign(myFile, fname);

  if FileExists(fname) then
  begin
    Reset(myFile, sizeof(TData));
  end
  else
  begin
    Rewrite(myFile, sizeof(TData));
  end
end;

destructor TFileStorage.Destroy;
begin
  close(myFile);
  inherited Destroy;
end;

{ TIntFileStorage }

function TIntFileStorage.getFIData(position: qword): integer;
begin
  result:= integer(getData(position));
end;

procedure TIntFileStorage.setFIData(position: qword; value: integer);
begin
  setData(position, Pointer(value));
end;

end.



