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
    s, day, checkID: string;
    find: Boolean;

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
		
		childrenIDLenght := 0;
		setLength(person.childrenID, childrenIDLenght);
		
		k := 0;  // индекс массива детей
        readln(s);
        while s <> '' do
        begin
            childrenIDLenght := childrenIDLenght + 1;
			setLength(person.childrenID, childrenIDLenght);

			person.childrenID[k] := s;
			k := k + 1;
            readln(s);
        end;
        
        data[i] := person;
        i := i + 1;
        dataLenght := dataLenght + 1;
        setLength(data, dataLenght);
    end;
    setLength(data, i);

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

    writeln('---- задания -----');

    // Дана дата, найти всех женщин, родившихся в этот день
    day := '06.12';
    writeln('1) Поиск по дате:');

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

    // Дан номер удостоверения личности ребенка, найти его родителей
    checkID := 'a123654';
    writeln('2) Поиск родителей:');

    for j := 0 to i-1 do
    begin
        for g := 0 to high(data[j].childrenID[g]) do
        begin
            if data[j].childrenID[g] = checkID then
                begin
                    writeln('ФИО: ', data[j].fio);
                    writeln('Пол: ', data[j].gender);
                    writeln('рожд: ', data[j].bdate);
                    writeln('Номер: ', data[j].id);
                    
                    writeln('Дети:');
                    for g2 := 0 to high(data[j].childrenID) do
                    begin
                        writeln(data[j].childrenID[g2]);
                    end;

                    writeln();
                end;
        end;
    end;
    
    // Найти всех дедушек
    writeln('3) Поиск дедушек:');
    for j := 0 to i-1 do
    begin
        find := False;

        if data[j].gender = 'мужской' then
        begin
            for g := 0 to high(data[j].childrenID) do
            begin
                if find then break;

                for k := 0 to i-1 do
                begin
                    if (data[j].childrenID[g] = data[k].id) and (data[k].childrenID[0] <> '---') then
                    begin
                        writeln('Дедушка: ', data[j].fio);
                        find := True;
                        break;
                    end;
                end;
            end;
        end;
    end;
    writeln();

    // Найти всех сирот
    writeln('4) Поиск сирот:');
    for j := 0 to i-1 do
    begin
        find := False;

        for g := 0 to i-1 do
        begin
            if find then break;

            for k := 0 to high(data[g].childrenID) do
            begin

                if data[j].id = data[g].childrenID[k] then
                begin
                    find := True;
                    break;
                end;
            end;
        end;

        if not find then
            writeln('Сирота: ', data[j].fio);
    end;
    
end.
