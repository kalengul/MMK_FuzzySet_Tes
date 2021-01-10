unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, UModelGraph, Grids,UPrimer1;

type
  TFMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    SbLoadGraph: TSpeedButton;
    SbSaveGraph: TSpeedButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    SgGraph: TStringGrid;
    KolAnt: TLabeledEdit;
    LeQnat: TLabeledEdit;
    LeRo: TLabeledEdit;
    BtModelSHV: TButton;
    procedure BtModelSHVClick(Sender: TObject);
    procedure SbLoadGraphClick(Sender: TObject);
    procedure SbSaveGraphClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure VivodGraphToStringGrid(Graph:TGraph; Sg:TStringGrid; TypeVivod:Byte);

var
  FMain: TFMain;
  Graph:TGraph;

implementation

{$R *.dfm}

Procedure VivodGraphToStringGrid(Graph:TGraph; Sg:TStringGrid; TypeVivod:Byte);
var
  KolNode:Longword;
  NomArc:Longword;
  NomPrevNode:Longword;
  NCol,NRow:Longword;
begin
if Graph<>nil then
  begin
  NomPrevNode:=0;
  KolNode:=Length(Graph.Node);
  if KolNode<>0 then
    begin
    Sg.ColCount:=KolNode+1;
    Sg.RowCount:=KolNode+1;
    end;
  while NomPrevNode<KolNode do
    begin
    NomArc:=0;
    NCol:=0;
    while NomArc<Length(Graph.Node[NomPrevNode].NextArc) do
      begin
      if NomPrevNode=NomArc then
        Inc(NCol);
      case TypeVivod of
        1:Sg.Cells[NCol+1,NomPrevNode+1]:=FloatToStr(Graph.Node[NomPrevNode].NextArc[NomArc].Value[0]);
        2:Sg.Cells[NCol+1,NomPrevNode+1]:=FloatToStr(Graph.Node[NomPrevNode].NextArc[NomArc].VesPheromon[0]);
        3:Sg.Cells[NCol+1,NomPrevNode+1]:=FloatToStr(Graph.Node[NomPrevNode].NextArc[NomArc].VesPherononFirst[0]);
      end;

      Inc(NCol);
      inc(NomArc);
      end;
    inc(NomPrevNode);
    end;
  end;
end;

procedure TFMain.BtModelSHVClick(Sender: TObject);
begin
FPrimer1.ShowModal;
end;

procedure TFMain.SbLoadGraphClick(Sender: TObject);
begin
if OpenDialog.Execute then
  begin
  Graph:=TGraph.Create;
  Graph.LoadGraphInTextFile(OpenDialog.FileName);
  Graph.VesPherononFirst[0]:=StrToFloat(LeQnat.Text);
  Graph.InitializationGraph;
  Graph.ClearGraph;
  VivodGraphToStringGrid(Graph,SgGraph,3);
  end;
end;

procedure TFMain.SbSaveGraphClick(Sender: TObject);
begin
if SaveDialog.Execute then
  CreateRandomGraphAtTextFile(SaveDialog.FileName,50,100,100);
end;

end.
