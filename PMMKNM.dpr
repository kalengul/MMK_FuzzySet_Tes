program PMMKNM;

uses
  Forms,
  UMain in 'UMain.pas' {FMain},
  UModelGraph in 'UModelGraph.pas',
  UAnt in 'UAnt.pas',
  USolutionProduction in 'USolutionProduction.pas',
  UGraphGroup in 'UGraphGroup.pas',
  UModelSPPO in 'UModelSPPO.pas',
  USBS in 'USBS.pas',
  UPrimer1 in 'UPrimer1.pas' {FPrimer1},
  UNLogic in 'UNLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFPrimer1, FPrimer1);
  Application.Run;
end.
