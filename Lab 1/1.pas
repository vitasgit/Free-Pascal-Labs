program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: string;
        childrenID: array of string;
        childrenFIO: array of string;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j, g, dataLength: integer;
    s: string;

begin
    i := 0;
    dataLength := 1;
    SetLength(data, dataLength);

    while not eof do
    begin
        readln(person.fio);
        readln(person.gender);
        readln(person.bdate);
        readln(person.id);

        SetLength(person.childrenID, 0);
        readln(s);
        while s <> '' do
        begin
            SetLength(person.childrenID, Length(person.childrenID) + 1);  // поменять
            person.childrenID[High(person.childrenID)] := s;
            readln(s);
        end;

        dataLength := dataLength + 1;
        SetLength(data, dataLength);

        data[i] := person;
        i := i + 1;
    end;

    for j := 0 to i - 1 do
    begin
        writeln(j + 1, ')');
        writeln('ФИО: ', data[j].fio);
        writeln('Пол: ', data[j].gender);
        writeln('рожд: ', data[j].bdate);
        writeln('Номер: ', data[j].id);
        writeln('Дети:');

        for g := 0 to High(data[j].childrenID) do
            writeln(data[j].childrenID[g]);
    end;
end.
