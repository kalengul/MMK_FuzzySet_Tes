unit UNLogic;

interface

Type
TFPrinEl = record
           Pos,FPren:Double;
           end;
DMassFPrin = array of  TFPrinEl;

implementation

Function Minimum (a,b:double):Double;
begin
  if a<b then
    result:=a
  else
    result:=b;
end;

Procedure SortDMssFPrin(Mass:DMassFPrin);
var
Min,Current:Longword;
Buf:TFPrinEl;
begin
Min:=0;
while Min<Length(Mass) do
  begin
  Current:=Min;
  while Current<Length(Mass) do
    begin
    if Mass[Min].Pos>Mass[Current].Pos then
      begin
      Buf:=Mass[Min];
      Mass[Min]:=Mass[Current];
      Mass[Current]:=Buf;
      end;
    inc(Current);
    end;
  inc(Min);
  end;
end;

Procedure AddDMassFPrin (FPrinFirst,FPrinSecond:DMassFPrin; var FPrinRes:DMassFPrin);
  var
  iFirst,iSecond,iRes,KolRes:longword;
  begin
  KolRes:=0;
  Setlength(FPrinRes,KolRes);
  iFirst:=0;
  while iFirst<Length(FPrinFirst) do
    begin
    iSecond:=0;
    while iSecond<Length(FPrinSecond) do
      begin
      iRes:=0;
      while (iRes<Length(FPrinRes)) and (FPrinRes[iRes].Pos<>FPrinFirst[iFirst].Pos*FPrinSecond[iSecond].Pos) do
        inc(iRes);
      if not (iRes<Length(FPrinRes)) then
        if FPrinRes[iRes].FPren<Minimum(FPrinFirst[iFirst].FPren,FPrinSecond[iSecond].FPren) then
          begin
          FPrinRes[iRes].FPren:=Minimum(FPrinFirst[iFirst].FPren,FPrinSecond[iSecond].FPren);
          end
      else
        begin
        inc(KolRes);
        Setlength(FPrinRes,KolRes);
        FPrinRes[KolRes-1].Pos:=FPrinFirst[iFirst].Pos*FPrinSecond[iSecond].Pos;
        FPrinRes[KolRes-1].FPren:=Minimum(FPrinFirst[iFirst].FPren,FPrinSecond[iSecond].FPren)
        end;
      inc(iSecond);
      end;
    inc(iFirst);
    end;
  SortDMssFPrin(FPrinRes);
  end;


end.
