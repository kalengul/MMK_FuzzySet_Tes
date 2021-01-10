object FPrimer1: TFPrimer1
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1083#1103' '#1055#1088#1080#1084#1077#1088#1072'1'
  ClientHeight = 548
  ClientWidth = 882
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 438
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 223
      Height = 436
      Align = alClient
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      TabOrder = 0
      object LaN0: TLabeledEdit
        Left = 11
        Top = 32
        Width = 54
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'N0'
        TabOrder = 0
        Text = '200'
      end
      object LaRo12: TLabeledEdit
        Left = 11
        Top = 72
        Width = 55
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaRo12'
        TabOrder = 1
        Text = '0,7'
      end
      object LaRo23: TLabeledEdit
        Left = 11
        Top = 110
        Width = 55
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaRo23'
        TabOrder = 2
        Text = '0,49'
      end
      object LaRo24: TLabeledEdit
        Left = 11
        Top = 152
        Width = 54
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaRo24'
        TabOrder = 3
        Text = '0,21'
      end
      object LaTimeStatistics: TLabeledEdit
        Left = 11
        Top = 328
        Width = 78
        Height = 21
        EditLabel.Width = 76
        EditLabel.Height = 13
        EditLabel.Caption = 'LaTimeStatistics'
        TabOrder = 4
        Text = '5'
      end
      object BtStart: TButton
        Left = 0
        Top = 395
        Width = 75
        Height = 25
        Caption = #1057#1058#1040#1056#1058
        TabOrder = 5
        OnClick = BtStartClick
      end
      object LaKolProgonov: TLabeledEdit
        Left = 11
        Top = 368
        Width = 121
        Height = 21
        EditLabel.Width = 71
        EditLabel.Height = 13
        EditLabel.Caption = 'LaKolProgonov'
        TabOrder = 6
        Text = '1000'
      end
      object LaN1: TLabeledEdit
        Left = 71
        Top = 32
        Width = 54
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'N1'
        TabOrder = 7
        Text = '10'
      end
      object LaEndStat: TLabeledEdit
        Left = 95
        Top = 328
        Width = 57
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'TimeStat'
        TabOrder = 8
        Text = '400'
      end
      object LaNu11: TLabeledEdit
        Left = 11
        Top = 192
        Width = 54
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaNu11'
        TabOrder = 9
        Text = '0'
      end
      object LaNu12: TLabeledEdit
        Left = 11
        Top = 232
        Width = 55
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaNu12'
        TabOrder = 10
        Text = '0'
      end
      object LaNu13: TLabeledEdit
        Left = 71
        Top = 192
        Width = 61
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaNu13'
        TabOrder = 11
        Text = '0'
      end
      object LaNu14: TLabeledEdit
        Left = 72
        Top = 232
        Width = 60
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'LaNu14'
        TabOrder = 12
        Text = '0'
      end
      object LaB21: TLabeledEdit
        Left = 11
        Top = 272
        Width = 55
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'LaB21'
        TabOrder = 13
        Text = '0'
      end
      object LaB22: TLabeledEdit
        Left = 72
        Top = 272
        Width = 60
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'LaB22'
        TabOrder = 14
        Text = '0'
      end
      object LaMu12: TLabeledEdit
        Left = 72
        Top = 72
        Width = 54
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'LaMu12'
        TabOrder = 15
        Text = '1'
      end
    end
  end
  object MeProtocol: TMemo
    Left = 225
    Top = 0
    Width = 657
    Height = 438
    Align = alClient
    Lines.Strings = (
      'MeProtocol')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 438
    Width = 882
    Height = 110
    Align = alBottom
    TabOrder = 2
  end
end
