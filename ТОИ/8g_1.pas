program n8_4;
var
    nums: array[1..10, 1..10] of integer;
    i, j, num: integer;
begin
    num := 1;
  
    // первый вывод
    for i := 1 to 10 do
    begin
        for j := 1 to 10 do
        begin
            nums[i,j] := num;
            num := num + 1;
            write(nums[i,j]:4);
        end;
        writeln();
    end;
end.
