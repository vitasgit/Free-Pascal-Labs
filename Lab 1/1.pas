program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: string;
        childrenID: string;
        childrenFIO: array of string;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j, dataLenght: integer;
    s: string;

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

        readln(s);
        while s <> '' do
        begin
            readln(person.childrenID);
        end;

        data[i] := person;
        i := i + 1;
        dataLenght := dataLenght + 1;
    end;

    for j := 0 to high(data)+1 do
    begin
        writeln(j+1, ')');
        writeln('ФИО: ', data[j].fio);
        writeln('Пол: ', data[j].gender);
        writeln('рожд: ', data[j].bdate);
        writeln('Номер: ', data[j].id);
        writeln();
    end;
end.

