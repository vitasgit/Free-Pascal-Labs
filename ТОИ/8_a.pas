Program n01;
var
    nums : array[1..25, 1..30] of Integer;
    i, j: Integer;
begin
    //Ввод
    for i := 1 to 25 do
    begin
        for j := 1 to 30 do
        begin
            nums[i,j] := random(9);
        end;
    end;
    
    //Вывод
    for i := 1 to 25 do
    begin
        for j := 1 to 30 do
        begin
            write(nums[i,j]:2);
        end;
        writeln();
    end;
end.
