unit UModelGraph;

interface

Uses SysUtils;

type
TNode = class;
//����� ����
TArc = class
  Name:string;       //��� ����
  Value:array of Double;              //������ ���� ����
  VesPheromon: array of Double;       //������ ��� �������� ����� (���������� ���������)
  VesPherononFirst: array of Double;  //������ ��� �������� ���������� �������� ����� (���������� ���������)
  NextNode: array of TNode;           //������ ��� �������� ������, ���� ��������� ���� (������ ������� �� ������ ��������)
  PrevNode:array of TNode;            //������ ��� �������� ������, ������ ������� ���� (������ ������� �� ������ ��������)
  Constructor Create(NameArc:String; KolPheromon:longword);
  Destructor Destroy;
end;

//����� �������
TNode = class
  Name:string;       //��� �������
  x,y:Double;        //����������
  VesPheromon: array of Double;   //������ ��� �������� ����� (���������� ���������)
  VesPherononFirst: array of Double;  //������ ��� �������� ���������� �������� ����� (���������� ���������)
  NextArc:array of TArc;          //������ ��������� ���
  PrevArc:array of TArc;          //������ �������� ���
  Constructor Create (NameNode:String; KolPheromon:longword);
  Destructor Destroy;
end;

//����� �����
TGraph = class
  KolTypePheromon:longword;
  FirstNode:array of TNode;   //������ ��������� ������ ��� ���
  CurrentFirstNode:Longword;  //����� ����� ������� � ������� ��������� ������
  VesPherononFirst: array of Double;  //������ ��� �������� ���������� �������� ����� (���������� ���������)
  Node:Array of TNode;        //������ ������ �����
  Arc:array of TArc;          //������ ��� �����

  Function AddNode(NameNode:string):TNode; //��������� ���������� �������
  Function SearchNode(NameSearchNode:string):TNode;  //������� ������ ������� � ����� �� �����

  Function AddArcPointer(NameArc:String; Value:Double; PrevNode,NextNode:TNode):TArc;         //���������� ���� �� ���������� �� �������
  Function AddArcName(NameArc:String; Value:Double; PrevNodeName,NextNodeName:String):TArc;   //���������� ���� �� ��������� ������
  Function SearchArcName(NameArc:String):TArc;                            //����� ���� �� ����� ����
  Function SearchArcNameNode(PrevNodeName,NextNodeName:String):TArc;     //����� ���� �� ��������� ������
  Procedure AddAllArc;                                                   //�������� ��������������� ����� � ������ ��� 1
  Procedure AddAllArcDist;                                               //�������� ��������������� ����� ����� ���������

  Procedure LoadGraphInTextFile(FileName:string);
  Procedure ClearGraph;
  procedure InitializationGraph;
  Constructor Create;
  //������� ���� ����
  Destructor Destroy;
end;

Procedure CreateRandomGraphAtTextFile(FileName:string; KolNode:Longword; xmax,ymax:Double);

implementation

Procedure TGraph.InitializationGraph;
var
NomNode,NomArc,NomEl:Longword;
KolEl:Longword;
begin
  NomNode:=0;
  while NomNode<Length(Node) do
    begin
    NomEl:=0;
    SetLength(Node[NomNode].VesPheromon,KolTypePheromon);
    SetLength(Node[NomNode].VesPherononFirst,KolTypePheromon);
    while NomEl<KolTypePheromon do
      begin
      Node[NomNode].VesPherononFirst[NomEl]:=VesPherononFirst[NomEl];
      inc(NomEl);
      end;
    inc(NomNode);
    end;

  NomArc:=0;
  while NomArc<Length(Arc) do
    begin
    NomEl:=0;
    SetLength(Arc[NomArc].VesPheromon,KolTypePheromon);
    SetLength(Arc[NomArc].VesPherononFirst,KolTypePheromon);
    while NomEl<Length(Arc[NomArc].VesPheromon) do
      begin
      Arc[NomArc].VesPherononFirst[NomEl]:=VesPherononFirst[NomEl];
      inc(NomEl);
      end;
    inc(NomArc);
    end;
end;

Procedure TGraph.ClearGraph;
var
NomNode,NomArc,NomEl:Longword;
begin
  NomNode:=0;
  while NomNode<Length(Node) do
    begin
    NomEl:=0;
    while NomEl<Length(Node[NomNode].VesPheromon) do
      begin
      Node[NomNode].VesPheromon[NomEl]:=Node[NomNode].VesPherononFirst[NomEl];
      inc(NomEl);
      end;
    inc(NomNode);
    end;

  NomArc:=0;
  while NomArc<Length(Arc) do
    begin
    NomEl:=0;
    while NomEl<Length(Arc[NomArc].VesPheromon) do
      begin
      Arc[NomArc].VesPheromon[NomEl]:=Arc[NomArc].VesPherononFirst[NomEl];
      inc(NomEl);
      end;
    inc(NomArc);
    end;
end;

Procedure CreateRandomGraphAtTextFile(FileName:string; KolNode:Longword; xmax,ymax:Double);
var
  f:textFile;
  st:string;
  NomNode:Longword;
  x,y:Double;
begin
  AssignFile(f,FileName);
  rewrite(f);
  for NomNode := 1 to KolNode do
    begin
    x:=Random*XMax;
    y:=Random*YMax;
    st:=IntToStr(NomNode)+';'+FloatToStr(x)+';'+FloatToStr(y)+';';
    Writeln(f,st);
    end;
  CloseFile(f);
end;

Procedure TGraph.LoadGraphInTextFile(FileName:string);
  var
    f:TextFile;
    st:string;
    St1:string;
    CurrentNode:TNode;
  begin
  assignFile (F,FileName);
  Reset(f);
  KolTypePheromon:=1;
  while Not EOF(f) do
    begin
    Readln(f,st);
    St1:=Copy(st,1,Pos(';',st)-1);
    delete(st,1,Pos(';',st));
    CurrentNode:=AddNode(st1);
    St1:=Copy(st,1,Pos(';',st)-1);
    delete(st,1,Pos(';',st));
    CurrentNode.x:=StrToFloat(st1);
    St1:=Copy(st,1,Pos(';',st)-1);
    delete(st,1,Pos(';',st));
    CurrentNode.y:=StrToFloat(st1);
    end;
  AddAllArcDist;
  CloseFile(f);
  end;

Function TGraph.AddNode(NameNode:string):TNode; //��������� ���������� �������
  var
    KolNodeGraph:Longword;
    NewNode:TNode;
  begin
  KolNodeGraph:=Length(Node);
  SetLength(Node,KolNodeGraph+1);
  Node[KolNodeGraph]:=TNode.Create(NameNode,KolTypePheromon);
  Result:=Node[KolNodeGraph];
  end;

Function TGraph.SearchNode(NameSearchNode:string):TNode;  //������� ������ ������� � ����� �� �����
  var
    SearchNodeGraph:Longword;
  begin
  SearchNodeGraph:=0;
  while (SearchNodeGraph<Length(Node)) and (Node[SearchNodeGraph].Name<>NameSearchNode) do
    inc(SearchNodeGraph);
  if SearchNodeGraph<Length(Node) then
    Result:=Node[SearchNodeGraph]
  else
    Result:=nil;
  end;
  
Function TGraph.AddArcPointer(NameArc:String; Value:Double; PrevNode,NextNode:TNode):TArc;         //���������� ���� �� ���������� �� �������
  var
    KolArcGraph:Longword;
    NewArc:TArc;
    KolNode:Longword;
  begin
  KolArcGraph:=Length(Arc);
  SetLength(Arc,KolArcGraph+1);
  Arc[KolArcGraph]:=TArc.Create(NameArc,KolTypePheromon);
  NewArc:=Arc[KolArcGraph];
  NewArc.Value[0]:=Value;

  KolNode:=Length(NewArc.NextNode);
  SetLength(NewArc.NextNode,KolNode+1);
  NewArc.NextNode[KolNode]:=NextNode;

  KolNode:=Length(NewArc.PrevNode);
  SetLength(NewArc.PrevNode,KolNode+1);
  NewArc.PrevNode[KolNode]:=PrevNode;

  KolNode:=Length(PrevNode.NextArc);
  SetLength(PrevNode.NextArc,KolNode+1);
  PrevNode.NextArc[KolNode]:=NewArc;

  KolNode:=Length(NextNode.PrevArc);
  SetLength(NextNode.PrevArc,KolNode+1);
  NextNode.PrevArc[KolNode]:=NewArc;

  Result:=NewArc;
  end;

Function TGraph.AddArcName(NameArc:String; Value:Double; PrevNodeName,NextNodeName:String):TArc;   //���������� ���� �� ��������� ������
  var
  PrevNode,NextNode:TNode;
  begin
  PrevNode:=SearchNode(PrevNodeName);
  NextNode:=SearchNode(NextNodeName);
  if PrevNode=nil then
    PrevNode:=AddNode(PrevNodeName);
  if NextNode=nil then
    NextNode:=AddNode(NextNodeName);
  Result:=AddArcPointer(NameArc,Value,PrevNode,NextNode);
  end;

Function TGraph.SearchArcName(NameArc:String):TArc;                            //����� ���� �� ����� ����
  var
  NomArc:LongWord;
  begin
  NomArc:=0;
  while (NomArc<Length(Arc)) and (Arc[NomArc].Name<>NameArc) do
    inc(NomArc);
  if NomArc<Length(Arc) then
    Result:=Arc[NomArc]
  else
    Result:=nil;
  end;

Function TGraph.SearchArcNameNode(PrevNodeName,NextNodeName:String):TArc;     //����� ���� �� ��������� ������                          //����� ���� �� ����� ����
  var
  NomArc,NomNodeArc:LongWord;
  PrevNode,NextNode:TNode;
  BEnd:Boolean;
  begin
{  PrevNode:=SearchNode(PrevNodeName);
  NextNode:=SearchNode(NextNodeName);
  if (PrevNode<>nil) and (NextNode<>nil) then
    begin
    NomArc:=0;
    BEnd:=false;
    while (NomArc<Length(PrevNode.NextArc)) and (not BEnd) do
      begin
      NomNodeArc:=0;
      while (NomNodeArc<Length(PrevNode.NextArc[NomArc].NextNode)) and (Length(PrevNode.NextArc[NomArc].NextNode[NomNodeArc]<>NextNode) do
        inc(NomNodeArc);
      BEnd:=NomNodeArc<Length(PrevNode.NextArc[NomArc].NextNode);
      inc(NomArc);
      end;
    if (NomArc<Length(Node[NomNodeArc].NextArc)) then
      Result:=Node[NomNodeArc].NextArc[NomArc]
    else
      Result:=nil;
    end
  else
    Result:=Nil; }
  end;

Procedure TGraph.AddAllArc;
var
  NomPrevNode,NomNextNode:Longword;
begin
  NomPrevNode:=0;
  while NomPrevNode<Length(Node) do
    begin
    NomNextNode:=0;
    while NomNextNode<Length(Node) do
      begin
      if NomPrevNode<>NomNextNode then
        AddArcPointer('From'+Node[NomPrevNode].Name+' to '+Node[NomNextNode].Name,1,Node[NomPrevNode],Node[NomNextNode]);
      inc(NomNextNode);
      end;
    inc(NomPrevNode);
    end;
end;

Procedure TGraph.AddAllArcDist;
var
  NomPrevNode,NomNextNode:Longword;
  Dist:Double;
begin
  NomPrevNode:=0;
  while NomPrevNode<Length(Node) do
    begin
    NomNextNode:=0;
    while NomNextNode<Length(Node) do
      begin
      if NomPrevNode<>NomNextNode then
        begin
        Dist:=Sqrt(Sqr(Node[NomNextNode].x-Node[NomPrevNode].x)+Sqr(Node[NomNextNode].y-Node[NomPrevNode].y));
        AddArcPointer('From'+Node[NomPrevNode].Name+' to '+Node[NomNextNode].Name,Dist,Node[NomPrevNode],Node[NomNextNode]);
        end;
      inc(NomNextNode);
      end;
    inc(NomPrevNode);
    end;
end;

Constructor TArc.Create (NameArc:String; KolPheromon:longword);
  begin
  Name:=NameArc;
  SetLength(Value,KolPheromon);
  SetLength(VesPheromon,KolPheromon);
  SetLength(VesPherononFirst,KolPheromon);
  SetLength(NextNode,0);
  SetLength(PrevNode,0);
  end;

Destructor TArc.Destroy;
  begin
  Name:='';
  SetLength(VesPheromon,0);
  SetLength(VesPherononFirst,0);
  SetLength(Value,0);
  SetLength(NextNode,0);
  SetLength(PrevNode,0);
  end;

Constructor TNode.Create (NameNode:String; KolPheromon:longword);
  begin
  Name:=NameNode;
  SetLength(VesPheromon,KolPheromon);
  SetLength(VesPherononFirst,KolPheromon);
  SetLength(NextArc,0);
  SetLength(PrevArc,0);
  end;

Destructor TNode.Destroy;
  begin
  Name:='';
  SetLength(VesPheromon,0);
  SetLength(VesPherononFirst,0);
  SetLength(NextArc,0);
  SetLength(PrevArc,0);
  end;

Constructor TGraph.Create;
  begin
  SetLength(FirstNode,0);
  SetLength(Node,0);
  SetLength(Arc,0);
  KolTypePheromon:=1;
  SetLength(VesPherononFirst,KolTypePheromon);
  end;

Destructor TGraph.Destroy;
  var
    NomCurrentNode,
    NomCurrentArc:Longword;
  begin
  NomCurrentNode:=0;
  while NomCurrentNode<Length(Node) do
    begin
    Node[NomCurrentNode].Destroy;
    inc(NomCurrentNode);
    end;
  SetLength(Node,0);
  SetLength(FirstNode,0);
  NomCurrentArc:=0;
  while NomCurrentArc<Length(Arc) do
    begin
    Arc[NomCurrentArc].Destroy;
    inc(NomCurrentArc);
    end;
  SetLength(Arc,0);
  SetLength(VesPherononFirst,0)
  end;

end.
