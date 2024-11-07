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
    i, j, k, g, dataLenght: integer;
    s: string;

begin
    i := 0;
    k := 0;  // индекс массива детей
    g := 0;  // вывод детей

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
			person.childrenID[k] := s;
			k := k + 1;
            readln(s);
        end;
        k := 0;  // ошибка

        data[i] := person;
        i := i + 1;
        dataLenght := dataLenght + 1;
        setLength(data, dataLenght);
    end;

    for j := 0 to high(data)+1 do
    begin
        writeln(j+1, ')');
        writeln('ФИО: ', data[j].fio);
        writeln('Пол: ', data[j].gender);
        writeln('рожд: ', data[j].bdate);
        writeln('Номер: ', data[j].id);
        writeln('Дети: ');
        
        for g := 0 to high(data[j].childrenID)+1 do writeln (data[j].childrenID[g]);
    end;
end.
