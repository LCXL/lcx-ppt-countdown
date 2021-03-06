object frmSet: TfrmSet
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'PPT'#35745#26102#34920#35774#32622
  ClientHeight = 384
  ClientWidth = 396
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    396
    384)
  PixelsPerInch = 96
  TextHeight = 12
  object btnOK: TButton
    Left = 313
    Top = 355
    Width = 75
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #20851#38381'(&C)'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object pgcSetting: TPageControl
    Left = 8
    Top = 8
    Width = 380
    Height = 337
    ActivePage = tsgeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object tsgeneral: TTabSheet
      Caption = #24120#35268
      DesignSize = (
        372
        309)
      object lblTimeout: TLabel
        Left = 15
        Top = 24
        Width = 48
        Height = 12
        Caption = #24635#26102#38388#65306
      end
      object lblS: TLabel
        Left = 350
        Top = 24
        Width = 12
        Height = 12
        Anchors = [akTop, akRight]
        Caption = #31186
        ExplicitLeft = 194
      end
      object lblTransparent: TLabel
        Left = 18
        Top = 208
        Width = 108
        Height = 12
        Caption = #28436#31034#26102#31383#21475#36879#26126#24230#65306
      end
      object lblTransparentValue: TLabel
        Left = 341
        Top = 208
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '100%'
      end
      object lblMinute: TLabel
        Left = 196
        Top = 24
        Width = 12
        Height = 12
        Anchors = [akTop, akRight]
        Caption = #20998
        ExplicitLeft = 197
      end
      object edtSecond: TEdit
        Left = 215
        Top = 21
        Width = 117
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        NumbersOnly = True
        TabOrder = 0
        Text = '0'
        OnChange = edtSecondChange
      end
      object chkClickable: TCheckBox
        Left = 8
        Top = 73
        Width = 198
        Height = 17
        Caption = #28436#31034#26102#31383#20307#21487#28857#20987
        TabOrder = 1
      end
      object rgShowType: TRadioGroup
        Left = 3
        Top = 96
        Width = 359
        Height = 41
        Anchors = [akLeft, akTop, akRight]
        Caption = #26174#31034#31867#22411
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #20498#35745#26102
          #27491#35745#26102)
        TabOrder = 2
      end
      object udSecond: TUpDown
        Left = 332
        Top = 21
        Width = 16
        Height = 20
        Anchors = [akTop, akRight]
        Associate = edtSecond
        Max = 59
        TabOrder = 3
      end
      object edtMinute: TEdit
        Left = 73
        Top = 21
        Width = 103
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        NumbersOnly = True
        TabOrder = 4
        Text = '0'
        OnChange = edtMinuteChange
      end
      object udMinute: TUpDown
        Left = 176
        Top = 21
        Width = 16
        Height = 20
        Anchors = [akTop, akRight]
        Associate = edtMinute
        TabOrder = 5
      end
      object chkAutoHide: TCheckBox
        Left = 8
        Top = 50
        Width = 137
        Height = 17
        Caption = #36793#32536#22788#33258#21160#38544#34255
        TabOrder = 6
      end
      object trckbrTransparent: TTrackBar
        Left = 132
        Top = 202
        Width = 204
        Height = 31
        Max = 255
        PageSize = 1
        Position = 255
        TabOrder = 7
        OnChange = trckbrTransparentChange
      end
      object btnTextColor: TButtonColor
        Left = 15
        Top = 252
        Width = 130
        Anchors = [akTop, akRight]
        Caption = 'LED'#25991#23383#39068#33394
        TabOrder = 8
      end
      object btnBackgroundColor: TButtonColor
        Left = 225
        Top = 252
        Width = 126
        Anchors = [akTop, akRight]
        Caption = 'LED'#32972#26223#39068#33394
        TabOrder = 9
      end
      object rgMode: TRadioGroup
        Left = 3
        Top = 143
        Width = 359
        Height = 54
        Anchors = [akLeft, akTop, akRight]
        Caption = #35745#26102#27169#24335
        ItemIndex = 0
        Items.Strings = (
          #33258#21160#35745#26102#65292'PPT'#28436#31034#26102#33258#21160#35745#26102
          #25163#21160#35745#26102#65292#35745#26102#26102#38656#35201#25353#19979#35745#26102#25353#38062)
        TabOrder = 10
      end
    end
    object tsTip: TTabSheet
      Caption = #25552#37266
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 375
      ExplicitHeight = 298
      object grpTimeOut: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 366
        Height = 126
        Align = alTop
        Caption = #36229#26102#35774#32622
        TabOrder = 0
        ExplicitWidth = 369
        DesignSize = (
          366
          126)
        object lblTimeoutSoundFilePath: TLabel
          Left = 32
          Top = 73
          Width = 60
          Height = 12
          Caption = #25991#20214#36335#24452#65306
          Enabled = False
        end
        object chkTimeoutMsgBox: TCheckBox
          Left = 32
          Top = 24
          Width = 97
          Height = 17
          Caption = #25552#31034#26694#25552#37266
          TabOrder = 0
        end
        object chkTimeoutSound: TCheckBox
          Left = 32
          Top = 47
          Width = 97
          Height = 17
          Caption = #22768#38899#25552#37266
          TabOrder = 1
          OnClick = chkTimeoutSoundClick
        end
        object btnTimeoutSoundFilePath: TButtonedEdit
          Left = 98
          Top = 70
          Width = 238
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Images = ilSet
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 2
          OnRightButtonClick = btnSoundFilePathRightButtonClick
          ExplicitWidth = 241
        end
        object chkTimeoutColor: TCheckBox
          Left = 32
          Top = 96
          Width = 113
          Height = 17
          Caption = #36229#26102#21518'LED'#39068#33394#65306
          TabOrder = 3
          OnClick = chkTimeoutColorClick
        end
        object btnTimeoutColor: TButtonColor
          Left = 239
          Top = 92
          Width = 97
          Anchors = [akTop, akRight]
          Caption = #26356#25913#39068#33394
          Enabled = False
          TabOrder = 4
          ExplicitLeft = 242
        end
      end
      object grpWarning: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 135
        Width = 366
        Height = 154
        Align = alTop
        Caption = #21363#23558#36229#26102#25552#37266#35774#32622
        TabOrder = 1
        ExplicitWidth = 369
        DesignSize = (
          366
          154)
        object lblWarningSoundFilePath: TLabel
          Left = 32
          Top = 73
          Width = 60
          Height = 12
          Caption = #25991#20214#36335#24452#65306
          Enabled = False
        end
        object lblWarningTime1: TLabel
          Left = 32
          Top = 122
          Width = 84
          Height = 12
          Caption = #31163#36229#26102#26102#38388#36824#26377
        end
        object lblWarningTime3: TLabel
          Left = 258
          Top = 122
          Width = 72
          Height = 12
          Anchors = [akTop, akRight]
          Caption = #31186#26102#24320#22987#25552#37266
          ExplicitLeft = 261
        end
        object lblWarningTime2: TLabel
          Left = 180
          Top = 123
          Width = 12
          Height = 12
          Anchors = [akTop, akRight]
          Caption = #20998
          ExplicitLeft = 183
        end
        object btnWarningSoundFilePath: TButtonedEdit
          Left = 98
          Top = 70
          Width = 238
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Images = ilSet
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 0
          OnRightButtonClick = btnSoundFilePathRightButtonClick
          ExplicitWidth = 241
        end
        object chkWarningSound: TCheckBox
          Left = 32
          Top = 47
          Width = 97
          Height = 17
          Caption = #22768#38899#25552#37266
          TabOrder = 1
          OnClick = chkWarningSoundClick
        end
        object chkWarningMsgBox: TCheckBox
          Left = 32
          Top = 24
          Width = 97
          Height = 17
          Caption = #25552#31034#26694#25552#37266
          TabOrder = 2
        end
        object chkWarningColor: TCheckBox
          Left = 32
          Top = 96
          Width = 113
          Height = 17
          Caption = #25552#37266#26102'LED'#39068#33394#65306
          TabOrder = 3
          OnClick = chkWarningColorClick
        end
        object edtWarningTimeSec: TEdit
          Left = 201
          Top = 119
          Width = 39
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight]
          NumbersOnly = True
          TabOrder = 4
          Text = '0'
          OnChange = edtWarningTimeSecChange
          ExplicitWidth = 42
        end
        object btnWarningColor: TButtonColor
          Left = 239
          Top = 92
          Width = 97
          Anchors = [akTop, akRight]
          Caption = #26356#25913#39068#33394
          Enabled = False
          TabOrder = 5
          ExplicitLeft = 242
        end
        object edtWarningTimeMin: TEdit
          Left = 122
          Top = 119
          Width = 39
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight]
          NumbersOnly = True
          TabOrder = 6
          Text = '0'
          OnChange = edtWarningTimeMinChange
          ExplicitWidth = 42
        end
        object udWarningTimeMin: TUpDown
          Left = 164
          Top = 119
          Width = 16
          Height = 20
          Associate = edtWarningTimeMin
          TabOrder = 7
        end
        object udWarningTimeSec: TUpDown
          Left = 243
          Top = 119
          Width = 16
          Height = 20
          Associate = edtWarningTimeSec
          Max = 59
          TabOrder = 8
        end
      end
    end
  end
  object dlgColor1: TColorDialog
    Left = 288
    Top = 168
  end
  object ilSet: TImageList
    Left = 344
    Top = 16
    Bitmap = {
      494C010101000800240010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000859DD5002963D6002A64D5002A64
      D5002A64D6002A64D6002A64D6002A64D6002A64D6002A64D6002A64D6002A64
      D6002A64D6002A63D6002963D5003C6FD5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005C82D5001C5EDC001E5EDD001F5F
      DE002060DF002061E0002061E0002061E0002061E0002061E0002061E0002060
      DF002161DF00205FDE001F5FDD00245FD8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000577ED000235FD8002662DA002863
      DA002963DA002963DA002963DA002963DA002963DA002963DA002963DA002963
      DA002A65DB002965DB002662DA002E64CF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000527DD3002665DB002A68DE002C69
      DF002D6AE0002D6AE0002D6AE0002D6AE0002D6AE0002D6AE0002D6AE0002D6A
      E0002F6BDF002E6BE0002B69DE00386AD0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004D7DD800296BE1002E6FE5003070
      E7003071E7003071E7003071E7003071E7003071E7003071E7003071E7003071
      E7003374E7003274E6002E70E5003E71D1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A7EDC002E72E7003376EB003578
      ED003579ED003579ED003579ED003579ED003579ED003579ED003579ED003579
      ED003A7DED00387BEC003376E9004578D3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004984DF00367FEA003B84EE003E86
      F0003E87F0003E87F0003E87F0003E87F0003E86EF003E86F0003E86F0003E86
      F000428AF0003F89EE003A82EB005283D3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000498AE5003E8AED004390F2004692
      F3004693F4004693F4004693F3004693F3004692F3004593F3004591F2004592
      F3004895F4004691F100408AEC005B8CD3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004892E7004395F000489AF3004A9C
      F4004A9CF4004A9CF4004A9CF4004A9CF400499CF400489AF1004698F0004697
      F0004898F0004695EE004292ED006595D4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A99E900469AEE004A9EF1004BA0
      F2004BA0F2004BA0F2004BA0F2004BA0F1004B9FF10056A7F2006DAEE70087B0
      D9008DAFD6008CAED6008BACD400AEB5C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C5D3E400B3C7DF00B5CBE100B8CD
      E300B9CEE500BACEE600B9CEE400B7CBE300B5CAE000CDCCD700D4CED400D4CC
      D400D2C9D200CFC6CF00CCC2CC00CCC3CC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5F4F500E9E7E900E9E7E900EAE8
      EA00EAE7EA00EAE8EA00EAE8EA00EAE8EA00E7E5E700DAD5DA00D0C8CF00D2C9
      D200D0C6D000CEC3CD00CCC0CB00CBC3CB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F2
      F300F3F1F300F2F0F200F2F0F200FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object dlgOpenSound: TOpenDialog
    Filter = #27874#24418#25991#20214'(*.wav)|*.wav'
    Left = 248
    Top = 168
  end
end
