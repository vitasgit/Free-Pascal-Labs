program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: string;
        childrenID: array of string;
        //childrenFIO: array of string;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j, k, g, g2, dataLenght, childrenIDLenght: integer;
    s, day: string;

begin
    i := 0;

    dataLenght := 1;
    setLength(data, dataLenght);

    // считывание данных
    while not eof do
    begin
        readln(person.fio);
        readln(person.gender);
        readln(person.bdate);
        readln(person.id);
		
		childrenIDLenght := 1;
		setLength(person.childrenID, childrenIDLenght);
		
		k := 0;  // индекс массива детей
        readln(s);
        while s <> '' do
        begin
			person.childrenID[k] := s;
			k := k + 1;
			childrenIDLenght := childrenIDLenght + 1;
			setLength(person.childrenID, childrenIDLenght);
            readln(s);
        end;
        
        setLength(person.childrenID, k);
        data[i] := person;
        i := i + 1;
        dataLenght := dataLenght + 1;
        setLength(data, dataLenght);
    end;

    // вывод
    for j := 0 to i-1 do
    begin
        writeln(j+1, ')');
        writeln('ФИО: ', data[j].fio);
        writeln('Пол: ', data[j].gender);
        writeln('рожд: ', data[j].bdate);
        writeln('Номер: ', data[j].id);
        writeln('Дети: ');
        
        for g := 0 to high(data[j].childrenID) do
        begin
            writeln(data[j].childrenID[g]);

            for g2 := 0 to i-1 do
            begin
                if data[g2].id = data[j].childrenID[g] then
                begin
                    writeln(data[g2].fio);
                    break;
                end;
            end;
        end;

        writeln();
    end;

    // Дана дата, найти всех женщин, родившихся в этот день
    //day := '06.12';
    write('Введите дату для поиска женщин: ');
    readln(day);  // не работает readln()

    for j := 0 to i-1 do
    begin
        if (data[j].gender = 'женский') and (copy(data[j].bdate, 1, 5) = day) then
        begin
            writeln('ФИО: ', data[j].fio);
            writeln('Пол: ', data[j].gender);
            writeln('рожд: ', data[j].bdate);
            writeln();
        end;
    end;

end.
