program n01;

var
    f: text;
    letters: integer = 0;
    digits: integer = 0;
    line: string;
    i, words: integer;
    inWord: boolean;


begin
    Assign(f, 'file.txt');
    reset(f);
    inWord := false;
    words := 0;

    While not eof(f) do
    begin
        readln(f, line);

        for i := 1 to length(line) do
        begin
            if line[i] in ['0'..'9'] then digits += 1;

            if line[i] in ['a'..'z'] then
            begin
                letters += 1;

                if not inWord then
                begin
                    inWord := true;
                    words += 1;
                end;
            end
            else if line[i] in [' ', '.', ',', '!', '?', ';', ':'] then
            begin
                inWord := False;
            end;
        end;
    end;
    writeln(digits);
    writeln(letters);
    writeln(words);

    close(f);
end.
