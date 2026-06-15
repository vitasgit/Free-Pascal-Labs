unit arrunit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, unit1;

procedure makeArr(var arr: TArr; size: integer);

implementation

procedure makeArr(var arr: TArr; size: integer);
var
  i: integer;
begin
   SetLength(arr, size);
   arr[0]:= Random(5);
   arr[1]:= arr[0];
   arr[2]:= arr[0];
   arr[3]:= arr[0];
   for i:= 4 to size-1 do
   begin
     arr[i]:= arr[i-1] + Random(5)+1;
   end;
end;

end.

