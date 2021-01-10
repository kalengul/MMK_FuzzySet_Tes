unit UPrimer1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UModelSPPO, USBS, ComObj;

type
  TFPrimer1 = class(TForm)
    Panel1: TPanel;
    MeProtocol: TMemo;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    LaN0: TLabeledEdit;
    LaRo12: TLabeledEdit;
    LaRo23: TLabeledEdit;
    LaRo24: TLabeledEdit;
    LaTimeStatistics: TLabeledEdit;
    BtStart: TButton;
    LaKolProgonov: TLabeledEdit;
    LaN1: TLabeledEdit;
    LaEndStat: TLabeledEdit;
    LaNu11: TLabeledEdit;
    LaNu12: TLabeledEdit;
    LaNu13: TLabeledEdit;
    LaNu14: TLabeledEdit;
    LaB21: TLabeledEdit;
    LaB22: TLabeledEdit;
    LaMu12: TLabeledEdit;
    procedure BtStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrimer1: TFPrimer1;

implementation

{$R *.dfm}

Procedure VivodStatisticExcel(KolProgon:Longword; NameFile:String);
var
  Excel: Variant;
  Nomstat:longword;
begin
Excel := CreateOleObject('Excel.Application');
Excel.WorkBooks.Add;
Excel.Cells[1,1]:='Интервал';
Excel.Cells[1,2]:='Сост №1';
Excel.Cells[1,3]:='Сост №2';
Excel.Cells[1,4]:='Сост №3';
Excel.Cells[1,5]:='Сост №4';
Excel.Cells[1,7]:='Сост №1';
Excel.Cells[1,8]:='Сост №2';
Excel.Cells[1,9]:='Сост №3';
Excel.Cells[1,10]:='Сост №4';
for Nomstat := 0 to length(Statistacs) - 1 do
    begin
    Excel.Cells[Nomstat+2,1]:=DeltaStatisticsTime*(NomStat+1);
    Excel.Cells[Nomstat+2,2]:=Statistacs[Nomstat].MxElement[1]/KolProgon;
    Excel.Cells[Nomstat+2,3]:=Statistacs[Nomstat].MxElement[2]/KolProgon;
    Excel.Cells[Nomstat+2,4]:=Statistacs[Nomstat].MxElement[3]/KolProgon;
    Excel.Cells[Nomstat+2,5]:=Statistacs[Nomstat].MxElement[4]/KolProgon;

    Excel.Cells[Nomstat+2,7]:=Statistacs[Nomstat].M2xElement[1]/KolProgon-Statistacs[Nomstat].MxElement[1]/KolProgon;
    Excel.Cells[Nomstat+2,8]:=Statistacs[Nomstat].M2xElement[2]/KolProgon-Statistacs[Nomstat].MxElement[2]/KolProgon;
    Excel.Cells[Nomstat+2,9]:=Statistacs[Nomstat].M2xElement[3]/KolProgon-Statistacs[Nomstat].MxElement[3]/KolProgon;
    Excel.Cells[Nomstat+2,10]:=Statistacs[Nomstat].M2xElement[4]/KolProgon-Statistacs[Nomstat].MxElement[4]/KolProgon;
    end;
Excel.Workbooks[1].saveas(NameFile+'.xlsx');
Excel.Workbooks.Close;
Excel.Application.Quit;
end;


Procedure VivodStatistics(KolProgon:Longword; Me:TMemo);
var
i:Byte;
Nomstat:longword;
stArr:array [0..4] of string;
stvr:string;
begin
for Nomstat := 0 to length(Statistacs) - 1 do
 // for i := 1 to length(Statistacs[Nomstat].MxElement) do
    begin
    Me.Lines.Add(FloatToStr(DeltaStatisticsTime*(NomStat+1))+'  ;1- '+FloatToStr(Statistacs[Nomstat].MxElement[1]/KolProgon)+'  ;2- '+FloatToStr(Statistacs[Nomstat].MxElement[2]/KolProgon)+'  ;3- '+FloatToStr(Statistacs[Nomstat].MxElement[3]/KolProgon)+'  ;4- '+FloatToStr(Statistacs[Nomstat].MxElement[4]/KolProgon))
    end;
end;

procedure TFPrimer1.BtStartClick(Sender: TObject);
var
NomProgon:Longword;
EndModelTime,CurrentModelTime,GenerateTime:Double;
NewEvent,NewEvent2:TEventCreateElement;
NewEventStatistics:TEventStatistics;
NewEventPomeha:TEventPomeha;
NomEvetNext:Longword;
NomProgonExcelFile,NomRow:Longword;
VivodTime,buf:Double;
Time3,Time4:double;
GoVivod:Boolean;
i:byte;
  Excel: Variant;
begin
Excel := CreateOleObject('Excel.Application');
Excel.WorkBooks.Add;
Excel.Cells[1,1]:='N 0'; Excel.Cells[1,2]:='N 1'; Excel.Cells[1,3]:='Ro 12';
Excel.Cells[1,4]:='Ro 23'; Excel.Cells[1,5]:='Ro 24';  Excel.Cells[1,6]:='Nu 11';
Excel.Cells[1,7]:='Nu 12'; Excel.Cells[1,8]:='Nu 13';  Excel.Cells[1,9]:='Nu 14';
Excel.Cells[1,10]:='B 21'; Excel.Cells[1,11]:='B 22';

Excel.Cells[2,1]:=LaN0.Text; Excel.Cells[2,2]:=LaN1.Text; Excel.Cells[2,3]:=LaRo12.Text;
Excel.Cells[2,4]:=LaRo23.Text; Excel.Cells[2,5]:=LaRo24.Text;  Excel.Cells[2,6]:=LaNu11.Text;
Excel.Cells[2,7]:=LaNu12.Text; Excel.Cells[2,8]:=LaNu13.Text;  Excel.Cells[2,9]:=LaNu14.Text;
Excel.Cells[2,10]:=LaB21.Text; Excel.Cells[2,11]:=LaB22.Text;

randomize;
NomProgonExcelFile:=Trunc(random*StrToInt(LaKolProgonov.Text));

Excel.Cells[3,1]:='№ прогона'; Excel.Cells[3,2]:=NomProgonExcelFile;
Excel.Cells[4,1]:='time'; Excel.Cells[4,2]:='N1'; Excel.Cells[4,3]:='N2'; Excel.Cells[4,4]:='N3'; Excel.Cells[4,5]:='N4';
Excel.Cells[4,14]:='Dzet1'; Excel.Cells[4,15]:='Dzet2'; Excel.Cells[4,16]:='Alf1'; Excel.Cells[4,17]:='Alf2'; 
NomRow:=5;

NomProgon:=0;
SetLength(Statistacs,Trunc(StrToFloat(LaEndStat.Text)/StrToFloat(LaTimeStatistics.Text))+1);
while NomProgon<StrToInt(LaKolProgonov.Text) do
  begin
  MeProtocol.Lines.Add('Старт прогона №'+IntToStr(NomProgon));
  //Задание начальных параметров
  ElementOnState[1]:=StrToInt(LaN0.Text);
  ElementOnState[2]:=StrToInt(LaN1.Text);
  ElementOnState[3]:=0;
  ElementOnState[4]:=0;
  ParametrPuasonStream[2]:=StrToFloat(LaRo12.Text);
  ParametrPuasonStream[3]:=StrToFloat(LaRo23.Text);
  ParametrPuasonStream[4]:=StrToFloat(LaRo24.Text);
  ParametrB[1]:=StrToFloat(LaB21.Text);
  ParametrB[2]:=StrToFloat(LaB22.Text);
  Mu12:=StrToInt(LaMu12.Text);
  IntensivnostWhite[1]:=StrToInt(LaNu11.Text);
  IntensivnostWhite[2]:=StrToInt(LaNu12.Text);
  IntensivnostWhite[3]:=StrToInt(LaNu13.Text);
  IntensivnostWhite[4]:=StrToInt(LaNu14.Text);
  DeltaStatisticsTime:=StrToFloat(LaTimeStatistics.Text);
  ProbabilityTimeModel:=20;

  //Создание начального события
  SBS:=TQueueEvent.Create;
 {
  If ParametrB[1]<>0 then
  for NomEvetNext := 0 to ParametrB[1] - 1 do
  begin
  NewEventPomeha:=TEventPomeha.Create;
  NewEventPomeha.EventTime:=random*ProbabilityTimeModel;
  NewEventPomeha.TypePomeha:=1;
  Sbs.AddEvent(NewEventPomeha);
  end;

  If ParametrB[2]<>0 then
  for NomEvetNext := 0 to ParametrB[2] - 1 do
  begin
  NewEventPomeha:=TEventPomeha.Create;
  NewEventPomeha.EventTime:=random*ProbabilityTimeModel;
  NewEventPomeha.TypePomeha:=2;
  Sbs.AddEvent(NewEventPomeha);
  end;              }

  VitDzetAlf(0);

  If Alf[1]<>0 then
  begin
  NewEvent:=TEventCreateElement.Create;
  NewEvent.EventTime:=GoPuasonStream(1,Alf[1]);
  NewEvent.DoubleEvent:=nil;
  NewEvent.NextState:=01;
  Sbs.AddEvent(NewEvent);
  end;

  If Alf[2]<>0 then
  begin
  NewEvent:=TEventCreateElement.Create;
  NewEvent.EventTime:=GoPuasonStream(2,Alf[2]);
  NewEvent.DoubleEvent:=nil;
  NewEvent.NextState:=02;
  Sbs.AddEvent(NewEvent);
  end;


  If ElementOnState[1]<>0 then
//  for NomEvetNext := 0 to ElementOnState[1] - 1 do
  begin
  NewEvent:=TEventCreateElement.Create;
  NewEvent.EventTime:=GoPuasonStream(2,ParametrPuasonStream[2]);
  NewEvent.DoubleEvent:=nil;
  NewEvent.NextState:=12;
  Sbs.AddEvent(NewEvent);
  end;
  If ElementOnState[2]<>0 then
//  for NomEvetNext := 0 to ElementOnState[2] - 1 do
  begin
  Time3:=GoPuasonStream(3,ParametrPuasonStream[3]);
  Time4:=GoPuasonStream(4,ParametrPuasonStream[4]);

  NewEvent:=TEventCreateElement.Create;
  if Time3<Time4 then
    NewEvent.EventTime:=Time3
  else
    NewEvent.EventTime:=Time4;
  if Time3<Time4 then
    NewEvent.NextState:=23
  else
    NewEvent.NextState:=24;
  NewEvent.DoubleEvent:=nil;
  Sbs.AddEvent(NewEvent);
  end;

  NewEventStatistics:=TEventStatistics.Create;
  NewEventStatistics.EventTime:=DeltaStatisticsTime;
  NewEventStatistics.NomStat:=0;
  Sbs.AddEvent(NewEventStatistics);

  //Проведение моделирования до необходимого времени
  CurrentModelTime:=0;
  VivodTime:=0;
  //EndModelTime:=StrToFloat(LaTime.Text);

  while CurrentModelTime<100000000000000 do
    begin
    If (NomProgon=NomProgonExcelFile){ and (CurrentModelTime>VivodTime) }then
      begin
      VivodTime:=VivodTime+0.01;
      Excel.Cells[NomRow,1]:=CurrentModelTime;
      for i := 1 to 4 do
        begin
        buf:=ElementOnState[i]+random*IntensivnostWhite[i]*2-IntensivnostWhite[i];
        if Buf<0 then  buf:=0;
        Excel.Cells[NomRow,i+1]:=buf;
        end;
      if (ParametrB[1]<>0) or (ParametrB[2]<>0) then
      begin
      VitDzetAlf(CurrentModelTime);
      Excel.Cells[NomRow,14]:=Dzet[1];
      Excel.Cells[NomRow,15]:=Dzet[2];
      Excel.Cells[NomRow,16]:=Alf[1];
      Excel.Cells[NomRow,17]:=Alf[2];
      end;

      inc(NomRow);
      end;
    ProcessingEvent(CurrentModelTime,false,MeProtocol);
    end;

  inc(NomProgon);
  end;
Excel.Workbooks[1].saveas(GetCurrentDir+'\Прогон.xlsx');
Excel.Workbooks.Close;
Excel.Application.Quit;
VivodStatistics(NomProgon,MeProtocol);
VivodStatisticExcel(NomProgon,GetCurrentDir+'\Статистика');
MeProtocol.Lines.Add('Данные статистики сохранены в Статистика.xlsx')

end;

end.
