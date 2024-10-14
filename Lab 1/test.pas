program data_people;

type 
  data = record
    fio: string;
    gender: string;
    date_b: integer;
    number_person: integer;
  end;

var
  f: text;
  a1, a2: string;

begin
    // Открытие стандартного ввода
    assign(f, ''); 
    reset(f);     

    // Чтение данных из файла
    while not eof(f) do
    begin
        readln(f, a1);
        writeln(a1);
        readln(f, a2);
        writeln(a2);
    end;

    // Закрытие файла
    close(f);
end.
