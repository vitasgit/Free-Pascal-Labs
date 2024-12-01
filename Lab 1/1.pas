program n01;

type
    TPerson = record
        fio: string;
        gender: string;
        bdate: string;
        id: string;
        childrenID: array of string;
    end;

var
    person: TPerson;
    data: array of TPerson;
    i, j, k, g, g2, dataLenght, childrenIDLenght: integer;
    count_m, count_w: byte;
    s, day, checkID: string;
    find: Boolean;

begin
    i := 0;

    dataLenght := 0;
    setLength(data, dataLenght);

    // считывание данных
    while not eof do
    begin
        dataLenght := dataLenght + 1;
        setLength(data, dataLenght);

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
        if Length(data[j].childrenID) = 0 then
            begin
                writeln('Нет');
            end;

        for g := 0 to high(data[j].childrenID) do
        begin
            find := False;

            write('id: ', data[j].childrenID[g], ', ');
            for g2 := 0 to i-1 do
            begin
                if data[g2].id = data[j].childrenID[g] then
                begin
                    find := True;
                    writeln('ФИО: ', data[g2].fio);
                    break;
                end;
            end;

            if not find then
                writeln('ФИО: ---');
        end;

        writeln();
    end;

    writeln('---- задания -----');
    {
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
    }
    // Дан номер удостоверения личности ребенка, найти его родителей
    // выводить должно максимум 2-х родителей
    // исправить

    writeln('2) Поиск родителей:');
    checkID := 'a123654';
    count_m := 0;
    count_w := 0;

    for j := 0 to i-1 do
    begin
        for g := 0 to high(data[j].childrenID) do
        begin
            if data[j].childrenID[g] = checkID then
            begin
                if data[j].gender = 'мужской' then 
                begin
                    count_m := count_m + 1;
                    if count_m > 1 then break;
                end;

                if data[j].gender = 'женский' then 
                begin
                    count_w := count_w + 1;
                    if count_w > 1 then break;
                end;

                if (count_m = 1) and (count_w = 1) then break;
                

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

        if (data[j].gender = 'мужской') and (Length(data[j].childrenID) <> 0) then
        begin
            for g := 0 to high(data[j].childrenID) do
            begin
                if find then break;

                for k := 0 to i-1 do
                begin
                    if (data[k].id = data[j].childrenID[g]) and (Length(data[k].childrenID) <> 0) then
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
    
    exit();
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
