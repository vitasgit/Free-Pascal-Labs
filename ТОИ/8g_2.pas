program n8_4;
var
    nums: array[1..10, 1..10] of integer;
    i, j, num: integer;
begin
    num := 1;
    
    // второй вывод
    for i := 1 to 10 do
    begin
        for j := 10 downto 1 do
        begin
            nums[i,j] := num;
            num := num + 1;
        end;
    end;
    
    for i := 1 to 10 do
    begin
        for j := 1 to 10 do
        begin
            write(nums[i,j]:4);
        end;
        writeln();
    end;
end.
