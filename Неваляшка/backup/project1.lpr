program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces,
  Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    procedure BClick(Sender: TObject);
  end;

procedure TForm1.BClick(Sender: TObject);
begin
  ShowMessage('Кнопка нажата');
end;

var
  Form1: TForm1;
  btn: TButton;
  panel: TPanel;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  form1.position:= poScreenCenter;

  panel:= TPanel.Create(panel);

  btn:= TButton.Create(form1);
  btn.parent:= form1;
  btn.caption:='Кнопка';
  btn.OnClick:= @form1.BClick;


  Application.Run;
end.

