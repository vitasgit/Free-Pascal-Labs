Program n04;
var
    nums : array[1..10, 1..10] of Integer;
    i, j, num: Integer;
begin

    //Ввод
    num := 1;
    for i := 1 to 10 do
    begin
        if (i mod 2 = 1) then
        begin
            for j := 1 to 10 do
            begin
                nums[j,i] := num;
                inc(num);
            end;
        end
        else
        begin
            for j := 10 downto 1 do
            begin
                nums[j,i] := num;
                inc(num);
            end;
        end;
    end;
    
    //Вывод
    for i := 1 to 10 do
    begin
        for j := 1 to 10 do
        begin
            write(nums[i,j]:4);
        end;
        writeln();
    end;
end.
