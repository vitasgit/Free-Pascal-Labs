Program n01;
var
    nums : array[1..15, 1..15] of Integer;
    i, j: Integer;
begin
    // Ввод
    for i := 1 to 15 do
    begin
        for j := 1 to 15 do
        begin
            if i = j then 
                nums[i,j] := 1
            else
                nums[i,j] := 0;
        end;
    end;
    
    // Вывод
    for i := 1 to 15 do
    begin
        for j := 1 to 15 do
        begin
            write(nums[i,j]:2);
        end;
        writeln();
    end;
end.
