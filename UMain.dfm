object FMain: TFMain
  Left = 0
  Top = 0
  Caption = #1053#1077#1095#1077#1090#1082#1080#1077' '#1084#1085#1086#1078#1077#1089#1090#1074#1072' +'#1052#1052#1050
  ClientHeight = 609
  ClientWidth = 1055
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
    Width = 1055
    Height = 105
    Align = alTop
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 8
      Top = 8
      Width = 361
      Height = 89
      Caption = #1043#1088#1072#1092
      TabOrder = 0
      object SbLoadGraph: TSpeedButton
        Left = 3
        Top = 16
        Width = 39
        Height = 41
        OnClick = SbLoadGraphClick
      end
      object SbSaveGraph: TSpeedButton
        Left = 48
        Top = 16
        Width = 41
        Height = 41
        OnClick = SbSaveGraphClick
      end
    end
    object BtModelSHV: TButton
      Left = 376
      Top = 16
      Width = 105
      Height = 33
      Caption = #1052#1086#1076#1077#1083#1100' '#1057#1064#1042
      TabOrder = 1
      OnClick = BtModelSHVClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 377
    Height = 504
    Align = alLeft
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 10
      Top = 0
      Width = 361
      Height = 281
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1052#1052#1050
      TabOrder = 0
      object KolAnt: TLabeledEdit
        Left = 9
        Top = 32
        Width = 104
        Height = 21
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1075#1077#1085#1090#1086#1074
        TabOrder = 0
        Text = '10'
      end
      object LeQnat: TLabeledEdit
        Left = 9
        Top = 72
        Width = 104
        Height = 21
        EditLabel.Width = 8
        EditLabel.Height = 13
        EditLabel.Caption = 'Q'
        TabOrder = 1
        Text = '10'
      end
      object LeRo: TLabeledEdit
        Left = 9
        Top = 112
        Width = 104
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'Ro'
        TabOrder = 2
        Text = '0.9'
      end
    end
  end
  object Panel3: TPanel
    Left = 377
    Top = 105
    Width = 344
    Height = 504
    Align = alLeft
    TabOrder = 2
  end
  object Panel4: TPanel
    Left = 721
    Top = 105
    Width = 334
    Height = 504
    Align = alClient
    TabOrder = 3
    object SgGraph: TStringGrid
      Left = 1
      Top = 1
      Width = 332
      Height = 502
      Align = alClient
      DefaultColWidth = 30
      TabOrder = 0
    end
  end
  object SaveDialog: TSaveDialog
    Left = 64
    Top = 24
  end
  object OpenDialog: TOpenDialog
    Left = 16
    Top = 24
  end
end
