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
  if position >= Length(fdata) then exit(default(TData));
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


{ TFileStorage }

function TFileStorage.getData(position: qword): TData;
begin
  if position >= FileSize(myFile) then exit(default(TData));

  seek(myFile, position);
  blockread(myFile, result, 1);
end;

procedure TFileStorage.setData(position: qword; value: TData);
begin
  seek(myFile, position);
  blockWrite(myFile, value, 1);
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
  end;
  inherited Create;
end;

destructor TFileStorage.Destroy;
begin
  close(myFile);
  inherited Destroy;
end;

end.




