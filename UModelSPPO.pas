unit UModelSPPO;

interface

uses USBS,StdCtrls,SysUtils;

Type
TElement = record
  NomElement:Longword;
  State:Byte;
end;

TEventCreateElement = class (TEvent)
   DoubleEvent:TEventCreateElement;
   NextState:Byte;
   Constructor Create;
   Destructor Destroy; override;
end;

TStat = record
  MxElement,M2xElement:Array [1..4] of Double;
  end;

TEventStatistics = class (TEvent)
  NomStat:longword;
  Constructor Create;
  Destructor Destroy; override;
end;

TEventPomeha = class (TEvent)
  TypePomeha:longword;
  Constructor Create;
  Destructor Destroy; override;
end;

Function GoPuasonStream(NomStream:byte; Parametrs:Double):double;
Procedure ProcessingEvent(var EndTime:Double; vivod:boolean; Me:TMemo);
Procedure VitDzetAlf(CurrentModelTime:Double);

var
ArrElement:Array of TElement;
ElementOnState:Array [1..4] of Longword;
ParametrPuasonStream:Array [2..4] of Double;
ParametrB:Array [1..2] of Double;
IntensivnostWhite:array [1..4] of Longword;
Statistacs:array  of TStat;
DeltaStatisticsTime,ProbabilityTimeModel:Double;
Alf,Dzet:array [1..2] of Double;
Mu12:double;

implementation

Procedure VitDzetAlf(CurrentModelTime:Double);
begin
if ElementOnState[1]<>0 then
begin
Dzet[1]:=exp(-Mu12*CurrentModelTime/100);
Dzet[2]:=2-exp(-Mu12*CurrentModelTime/100);
Alf[1]:=ParametrB[1]*ElementOnState[1]*Dzet[1]*(Mu12-ParametrPuasonStream[2])/(ElementOnState[1]+ParametrB[1]*ElementOnState[1]*Dzet[1]);
Alf[2]:=(ParametrB[2]*ElementOnState[1]*Dzet[2]*(ParametrPuasonStream[3]-ParametrPuasonStream[4])+Dzet[1]*(ParametrB[2]*ElementOnState[1]*Mu12-ParametrB[1]*ElementOnState[1]*ParametrPuasonStream[2]))/(ElementOnState[1]+ParametrB[1]*ElementOnState[1]*Dzet[1]);
end;
end;

Procedure GoSaveStatistics(Nomstat:Longword);
var
i,j:byte;
KolStat:Byte;
begin
{if Length(Statistacs)<Nomstat+1 then
  begin
  KolStat:=Length(Statistacs);
  setLength(Statistacs,Nomstat+1);
  for i:=1 to length(Statistacs[Nomstat].MxElement) do
  if Nomstat<>0 then
    begin
    Statistacs[Nomstat].MxElement[i]:=Statistacs[Nomstat-1].MxElement[i];
    Statistacs[Nomstat].M2xElement[i]:=Statistacs[Nomstat-1].M2xElement[i];
    end
  else
    begin
    Statistacs[Nomstat].MxElement[i]:=0;
    Statistacs[Nomstat].M2xElement[i]:=0;
    end;
  end;   }
if Length(Statistacs)>Nomstat+1 then
for i:=1 to length(Statistacs[Nomstat].MxElement) do
    begin
    Statistacs[Nomstat].MxElement[i]:=Statistacs[Nomstat].MxElement[i]+ElementOnState[i];
    Statistacs[Nomstat].M2xElement[i]:=Statistacs[Nomstat].M2xElement[i]+ElementOnState[i]*ElementOnState[i];
    end;
end;

Function GoPuasonStream(NomStream:byte; Parametrs:Double):double;
begin
if Parametrs=0 then
result:=0
else
result:=-1/Parametrs*Ln(Random+0.0000001);
end;

Procedure ProcessingEvent(var EndTime:Double; vivod:boolean; Me:TMemo);
var
  Event,CurrentEvent:TEvent;
  NewEvent,NewEvent2:TEventCreateElement;
  NewEventStatistics:TEventStatistics;
  GenerateTime:Double;
  KolPomeh:Longword;
  ArrEvent:array of TEventCreateElement;

Procedure GoState;
begin
if vivod then
Me.Lines.Add(IntToStr(ElementOnState[1])+' '+IntToStr(ElementOnState[2])+' '+IntToStr(ElementOnState[3])+' '+IntToStr(ElementOnState[4]));
end;

Procedure Go2event;
var
Time3,Time4:Double;
begin
Time3:=GoPuasonStream(3,ParametrPuasonStream[3]);
Time4:=GoPuasonStream(4,ParametrPuasonStream[4]);

NewEvent:=TEventCreateElement.Create;
if Time3<Time4 then
  NewEvent.EventTime:=EndTime+Time3
else
  NewEvent.EventTime:=EndTime+Time4;
if Time3<Time4 then
  NewEvent.NextState:=23
else
  NewEvent.NextState:=24;
NewEvent.DoubleEvent:=nil;
Sbs.AddEvent(NewEvent);

if vivod then
Me.Lines.Add('+23  Time='+FloatToStr(NewEvent.EventTime));
if vivod then
Me.Lines.Add('+24  Time='+FloatToStr(NewEvent2.EventTime));
end;

Procedure Go1event;
begin
GenerateTime:=GoPuasonStream(2,ParametrPuasonStream[2]);
NewEvent:=TEventCreateElement.Create;
NewEvent.EventTime:=EndTime+GenerateTime;
NewEvent.DoubleEvent:=nil;
NewEvent.NextState:=12;
Sbs.AddEvent(NewEvent);

if vivod then
Me.Lines.Add('+12  Time='+FloatToStr(NewEvent.EventTime));

end;

var
i,j,k:Longword;


begin
Event:=Sbs.GetFirstEvent;
IF Event<>nil then
  begin
  EndTime:=Event.EventTime;

  If (Event is TEventCreateElement) then
    begin
    if vivod then
      Me.Lines.Add('Time='+FloatToStr(Event.EventTime)+'  '+IntToStr((Event as TEventCreateElement).NextState));
    case (Event as TEventCreateElement).NextState of
      01:begin
         if ElementOnState[1]>0 then
         begin
         inc(ElementOnState[1]);
         VitDzetAlf(EndTime);

         NewEvent:=TEventCreateElement.Create;
         NewEvent.EventTime:=EndTime+GoPuasonStream(1,Alf[1]);
         NewEvent.DoubleEvent:=nil;
         NewEvent.NextState:=01;
         Sbs.AddEvent(NewEvent);
         end;
         end;
      02:begin
         if ElementOnState[1]>0 then
         begin
         inc(ElementOnState[2]);
         VitDzetAlf(EndTime);

         NewEvent:=TEventCreateElement.Create;
         NewEvent.EventTime:=EndTime+GoPuasonStream(2,Alf[2]);
         NewEvent.DoubleEvent:=nil;
         NewEvent.NextState:=02;
         Sbs.AddEvent(NewEvent);
         end;

        end;
      12:begin
      If ElementOnState[1]>0 then
      begin
        inc(ElementOnState[2]);
        if ElementOnState[2]=1 then
          Go2event;

        dec(ElementOnState[1]);
        if ElementOnState[1]<>0 then
          Go1event;

      end;
        end;
      23:begin
        If ElementOnState[2]>0 then
        begin
        inc(ElementOnState[3]);

        dec(ElementOnState[2]);
        if ElementOnState[2]<>0 then
          Go2event;
        end;
//        (Event as TEventCreateElement).DoubleEvent.Destroy;
        end;

      24:begin
        If ElementOnState[2]>0 then
        begin
        inc(ElementOnState[4]);

        dec(ElementOnState[2]);
        if ElementOnState[2]<>0 then
          Go2event;
        end;
//        (Event as TEventCreateElement).DoubleEvent.Destroy;
        end;
    end; //Case

    end
  else
  If (Event is TEventStatistics) then
    begin

    GoSaveStatistics((Event as TEventStatistics).NomStat);

    if Sbs.KolEvent=0 then
      begin
      GoState;
      if Length(Statistacs)>(Event as TEventStatistics).NomStat+1 then
      for j := (Event as TEventStatistics).NomStat+1 to Length(Statistacs) - 1 do
       for i:=1 to length(Statistacs[0].MxElement) do
         begin
         Statistacs[j].MxElement[i]:=Statistacs[j].MxElement[i]+ElementOnState[i];
         Statistacs[j].M2xElement[i]:=Statistacs[j].M2xElement[i]+ElementOnState[i]*ElementOnState[i];
         end;
      EndTime:=1000000000000000;
      end;
    NewEventStatistics:=TEventStatistics.Create;
    NewEventStatistics.EventTime:=EndTime+DeltaStatisticsTime;
    NewEventStatistics.NomStat:=(Event as TEventStatistics).NomStat+1;
    Sbs.AddEvent(NewEventStatistics);
    end
  else
  If (Event is TEventPomeha) then
    begin
    KolPomeh:=random(IntensivnostWhite[(Event as TEventPomeha).TypePomeha]);
    if ElementOnState[(Event as TEventPomeha).TypePomeha]<KolPomeh then
      KolPomeh:=ElementOnState[(Event as TEventPomeha).TypePomeha];
    ElementOnState[(Event as TEventPomeha).TypePomeha]:=ElementOnState[(Event as TEventPomeha).TypePomeha]-KolPomeh;
    if ElementOnState[(Event as TEventPomeha).TypePomeha]<0 then
      ElementOnState[(Event as TEventPomeha).TypePomeha]:=0;

    i:=0;
    Setlength(ArrEvent,0);
    CurrentEvent:=Sbs.FirstEvent;
    while CurrentEvent<>nil do
      begin
      if (CurrentEvent is TEventCreateElement) and
         ((((CurrentEvent as TEventCreateElement).NextState=12) and ((Event as TEventPomeha).TypePomeha=1)) or
         (((CurrentEvent as TEventCreateElement).NextState=23) and ((Event as TEventPomeha).TypePomeha=2))) then
        begin
        Inc(i);
        Setlength(ArrEvent,i);
        ArrEvent[i-1]:=(CurrentEvent as TEventCreateElement);
        end;

      CurrentEvent:=CurrentEvent.NextEvent;
      end;

    i:=1;
    while i<KolPomeh do
      begin
      j:=random(Length(ArrEvent));
   {   k:=0;
      While (ArrEvent[j]=nil) and (k<10000) do
        begin
        j:=random(Length(ArrEvent));
        inc(k);
        end;           }
      If (j<Length(ArrEvent)) and (ArrEvent[j]<>nil) then
      begin
      if ((Event as TEventPomeha).TypePomeha=2) and (ArrEvent[j].DoubleEvent<>nil) then
        ArrEvent[j].DoubleEvent.Destroy;
      ArrEvent[j].Destroy;
      ArrEvent[j]:=nil;
      end;
      inc(i);
      end;
  end;
  Event.Destroy;
  end
else
  begin
  GoState;
  EndTime:=1000000000000000;
  end;
end;

Constructor TEventCreateElement.Create;
  begin
    inherited;
  NextEvent:=nil;
  PreEvent:=nil;
  EventTime:=0;
  end;

Destructor TEventCreateElement.Destroy;
  begin
  If SBS.FirstEvent=self then
    Sbs.FirstEvent:=NextEvent;
  If NextEvent<>nil then
    NextEvent.PreEvent:=PreEvent;
  If PreEvent<>nil then
    PreEvent.NextEvent:=NextEvent;
  NextEvent:=nil;
  PreEvent:=nil;
  inherited;
  end;

Constructor TEventPomeha.Create;
  begin
    inherited;
  NextEvent:=nil;
  PreEvent:=nil;
  EventTime:=0;
  end;

Destructor TEventPomeha.Destroy;
  begin
  If SBS.FirstEvent=self then
    Sbs.FirstEvent:=NextEvent;
  If NextEvent<>nil then
    NextEvent.PreEvent:=PreEvent;
  If PreEvent<>nil then
    PreEvent.NextEvent:=NextEvent;
  NextEvent:=nil;
  PreEvent:=nil;
  inherited;
  end;

Constructor TEventStatistics.Create;
  begin
    inherited;
  NextEvent:=nil;
  PreEvent:=nil;
  EventTime:=0;
  end;

Destructor TEventStatistics.Destroy;
  begin
  If SBS.FirstEvent=self then
    Sbs.FirstEvent:=NextEvent;
  If NextEvent<>nil then
    NextEvent.PreEvent:=PreEvent;
  If PreEvent<>nil then
    PreEvent.NextEvent:=NextEvent;
  NextEvent:=nil;
  PreEvent:=nil;
  inherited;
  end;

end.
