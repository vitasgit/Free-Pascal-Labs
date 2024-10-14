program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: longint;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j: integer;

begin
    i := 0;
    setLength(data, 2);

    while not eof do
    begin
        readln(person.fio);
        readln(person.gender);
        readln(person.bdate);
        readln(person.id);

        data[i] := person;
        i := i + 1;
    end;

    for j := 0 to high(data)-1 do
    begin
        writeln(data[j].fio);
        writeln(data[j].gender);
        writeln(data[j].bdate);
        writeln(data[j].id);
    end;
end.

