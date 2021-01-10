unit UAnt;

interface

Uses UModelGraph;

type
TAnt = class
  CurrentNode:TNode;
  LastLength: array of TNode;
  LastLengthArc:array of TArc;
  Constructor Create;
  Destructor Destroy;
  Procedure InitialiazeAnt;
  Procedure GoToNextNode;
end;

implementation

Uses UMain;

Procedure TAnt.GoToNextNode;
  var
    VariantnexNode:array of TNode;
  begin

  end;

Procedure TAnt.InitialiazeAnt;
  begin
  CurrentNode:=Graph.FirstNode[Graph.CurrentFirstNode];
  SetLength(LastLength,0);
  SetLength(LastLengthArc,0);
  end;

Constructor TAnt.Create;
begin
CurrentNode:=nil;
SetLength(LastLength,0);
SetLength(LastLengthArc,0);
end;

Destructor TAnt.Destroy;
begin
CurrentNode:=nil;
SetLength(LastLength,0);
SetLength(LastLengthArc,0);
end;




end.
