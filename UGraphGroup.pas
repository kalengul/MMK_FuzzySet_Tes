unit UGraphGroup;

interface

uses SysUtils;

Type
TNodeGroup = class;
TNode = class
  Name:string;
  Pheromon:array of Double;
  Group:TNodeGroup;
  NextNode:array of TNode;
  Constructor Create(NameNode:string; KolTypePheromon:Byte);
  Destructor Destroy;
end;

TNodeGroup = class
  Name:string;
  NomGroup:Longword;
  Node:array of TNode;
  Procedure GenerateNode(XNat,XKon,ShagX:Double; KolTypePheromon:Byte);
  Constructor Create(NameGroup:string; NomGroupGraph:Longword);
  Destructor Destroy;
end;

TGraphGroup = Class
  Name:string;
  KolTypePheromon:Byte;
  Group:Array of TNodeGroup;
  Procedure LoadGraphInTxtFile(var Graph:TGraphGroup; NameFile:string);
  Procedure AddGroup(NameGroup:string);
  Constructor Create(NameGraph:string; KolTypePheromonGraph:Byte);
  Destructor Destroy;
end;

implementation

Procedure TGraphGroup.LoadGraphInTxtFile(var Graph:TGraphGroup; NameFile:string);
var
f:textfile;
st:string;
NameGraph:string;
NameGroup:string;
KolTypePheromonGraph:Byte;
XNat,XKon,ShagX:Double;
begin
AssignFile(f,NameFile);
reset(f);
if not EOF(f) then
begin
Readln(f,NameGraph);
Readln(f,st);
KolTypePheromonGraph:=StrToInt(st);
Graph:=TGraphGroup.Create(NameGraph,KolTypePheromonGraph);
while not EOF(f) do
  begin
  Readln(f,NameGroup);
  Graph.AddGroup(NameGroup);
  Readln(f,st);
  XNat:=StrToFloat(Copy(st,1,pos(';',st)-1));
  Delete(st,1,pos(';',st));
  XKon:=StrToFloat(Copy(st,1,pos(';',st)-1));
  Delete(st,1,pos(';',st));
  ShagX:=StrToFloat(Copy(st,1,pos(';',st)-1));
  end;
end;
CloseFile(f);
end;

Procedure TGraphGroup.AddGroup(NameGroup:string);
var
  KolGroup:Longword;
begin
KolGroup:=Length(Group);
SetLength(Group,KolGroup+1);
Group[KolGroup]:=TNodeGroup.Create(NameGroup,KolGroup);
end;

Procedure TNodeGroup.GenerateNode(XNat,XKon,ShagX:Double;KolTypePheromon:Byte);
var
  CurrentX:Double;
  KolNode:Longword;
begin
  CurrentX:=XNat;
  KolNode:=0;
  while CurrentX<XKon do
    begin
    Inc(KolNode);
    SetLength(Node,KolNode);
    Node[KolNode-1]:=TNode.Create(FloatToStr(CurrentX),KolTypePheromon);
    Node[KolNode-1].Group:=self;
    CurrentX:=CurrentX+ShagX;
    end;
end;

Constructor TGraphGroup.Create(NameGraph:string; KolTypePheromonGraph:Byte);
  begin
  Name:=NameGraph;
  KolTypePheromon:=KolTypePheromonGraph;
  SetLength(Group,0);
  end;
Destructor TGraphGroup.Destroy;
var
  NomGroup:Longword;
begin
NomGroup:=0;
while NomGroup<Length(Group) do
  begin
  Group[NomGroup].Destroy;
  inc(NomGroup);
  end;
SetLength(Group,0);
end;

Constructor TNodeGroup.Create(NameGroup:string; NomGroupGraph:Longword);
  begin
   Name:=NameGroup;
   NomGroup:=NomGroupGraph;

   SetLength(Node,0);
  end;

Destructor TNodeGroup.Destroy;
  var
    NomNode:Longword;
  begin
  NomNode:=0;
  while NomNode<length(Node) do
    begin
    Node[NomNode].Destroy;
    inc(NomNode);
    end;
  SetLength(Node,0);
  end;

Constructor TNode.Create(NameNode:string; KolTypePheromon:Byte);
  begin
  Name:=NameNode;
  SetLength(Pheromon,KolTypePheromon);
  setLength(NextNode,0);
  Group:=nil;
  end;

Destructor TNode.Destroy;
  begin
  SetLength(Pheromon,0);
  setLength(NextNode,0);
  Group:=nil;
  end;

end.
