program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: string;
        childrenID: string;
        childrenFIO: string;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j, dataLenght: integer;

begin
    i := 0;

    dataLenght := 1;
    setLength(data, dataLenght);

    while not eof do
    begin
        readln(person.fio);
        readln(person.gender);
        readln(person.bdate);
        readln(person.id);

        data[i] := person;
        i := i + 1;
        dataLenght := dataLenght + 1;
    end;

    for j := 0 to high(data)+1 do
    begin
        writeln(j+1, ')');
        writeln(data[j].fio);
        writeln(data[j].gender);
        writeln(data[j].bdate);
        writeln(data[j].id);
        writeln();
    end;
end.

