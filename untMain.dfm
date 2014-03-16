object frmMain: TfrmMain
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderIcons = []
  Caption = 'PPT'#35745#26102#34920
  ClientHeight = 67
  ClientWidth = 260
  Color = clBtnFace
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 600
  Constraints.MinHeight = 6
  Constraints.MinWidth = 6
  DoubleBuffered = True
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = pmMain
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object rzledTime: TRzLEDDisplay
    Left = 0
    Top = 29
    Width = 260
    Height = 38
    Align = alClient
    Alignment = taCenter
    Caption = 'WAITING'
    SegOnColor = clWhite
    SegOffColor = clBlack
    PopupMenu = pmMain
    ExplicitLeft = -2
    ExplicitTop = -2
    ExplicitWidth = 328
    ExplicitHeight = 44
  end
  object pnlControl: TPanel
    Left = 0
    Top = 0
    Width = 260
    Height = 29
    Align = alTop
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      260
      29)
    object lblMode: TLabel
      Left = 8
      Top = 7
      Width = 102
      Height = 12
      Caption = #24403#21069#27169#24335':'#33258#21160#35745#26102
    end
    object btnStart: TButton
      Left = 176
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #33258#21160#35745#26102
      Enabled = False
      TabOrder = 0
      OnClick = btnStartClick
    end
  end
  object tmrMain: TTimer
    Interval = 20
    OnTimer = tmrMainTimer
    Left = 112
    Top = 16
  end
  object tryicoMain: TTrayIcon
    PopupMenu = pmMain
    Visible = True
    OnMouseUp = tryicoMainMouseUp
    Left = 176
    Top = 15
  end
  object pmMain: TPopupMenu
    Left = 144
    Top = 16
    object mniS1: TMenuItem
      Caption = #35774#32622'(&S)'
      OnClick = mniS1Click
    end
    object mniN1: TMenuItem
      Caption = '-'
    end
    object mniC1: TMenuItem
      Caption = #36864#20986'(&C)'
      OnClick = mniC1Click
    end
  end
end
