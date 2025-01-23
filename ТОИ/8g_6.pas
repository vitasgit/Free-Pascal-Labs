program SpiralArrayReverse;
var
  nums: array[1..10, 1..10] of Integer;
  i, j, num, startRow, endRow, startCol, endCol: Integer;
begin
  num := 1;
  startRow := 1;
  endRow := 10;
  startCol := 1;
  endCol := 10;

  while (startRow <= endRow) and (startCol <= endCol) do
  begin
    for j := endCol downto startCol do
    begin
      nums[endRow, j] := num;
      Inc(num);
    end;
    Dec(endRow);

    for i := endRow downto startRow do
    begin
      nums[i, startCol] := num;
      Inc(num);
    end;
    Inc(startCol);

    if startRow <= endRow then
    begin
      for j := startCol to endCol do
      begin
        nums[startRow, j] := num;
        Inc(num);
      end;
      Inc(startRow);
    end;

    if startCol <= endCol then
    begin
      for i := startRow to endRow do
      begin
        nums[i, endCol] := num;
        Inc(num);
      end;
      Dec(endCol);
    end;
  end;

  // Вывод массива
  for i := 1 to 10 do
  begin
    for j := 1 to 10 do
    begin
      write(nums[i, j]:4);
    end;
    writeln();
  end;
end.
