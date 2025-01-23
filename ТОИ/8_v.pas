program n03;

var
    nums : array[1..20, 1..20] of Integer;
    i, j: Integer;

begin
    // Ввод
    for i := 1 to 20 do
    begin
        for j := 1 to 20 do
        begin
            if (i <= j) and (i + j <= 21) then
                nums[i, j] := 1
            else if (i <= j) and (i + j > 21) then
                nums[i, j] := 2
            else if (i > j) and (i + j <= 21) then
                nums[i, j] := 4
            else
                nums[i, j] := 3;
        end;
    end;

  // Вывод
    for i := 1 to 20 do
    begin
        for j := 1 to 20 do
            write(nums[i, j]:2);
        writeln;
    end;

    writeln();
  // Первая половина
    for i := 1 to 10 do
    begin
        for j := 1 to 20 do
        begin
            if j <= i then
                nums[i, j] := 1
            else if (j > i) and (j <= 10) then
                nums[i, j] := 2
            else
                nums[i, j] := 3;
        end;
        
        for j := 1 to 20 do
            write(nums[i, j]:2);
        writeln;
    end;

  // Вторая половина
    for i := 1 to 10 do
    begin
        for j := 1 to 20 do
        begin
            if j > 10 then
            begin
                if j > 10 + i then
                    nums[i, j] := 1
                else
                    nums[i, j] := 2
            end
            else
                nums[i, j] := 3;
        end;
        
        for j := 1 to 20 do
            write(nums[i, j]:2);
        writeln;
    end;
end.