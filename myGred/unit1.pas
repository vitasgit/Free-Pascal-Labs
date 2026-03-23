unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
    FlowPanel1: TFlowPanel;
    ImageList1: TImageList;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
  private

  public

  end;

var
  Form1: TForm1;

implementation

initialization
  {$I unit1.lrs}

end.

