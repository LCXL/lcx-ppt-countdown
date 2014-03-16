unit untMain;
/// <author>LCXL</author>
/// <summary>
/// PPT计时系统主单元，lcx87654321@163.com
/// </summary>
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzBorder, Menus, StdCtrls, DateUtils, untSet, untIni, MMSystem;

const
  /// <summary>
  /// 隐藏时的边界宽度
  /// </summary>
  BORDER_WIDTH = 5;
  /// <summary>
  /// 窗口动画速度(5像素/s)
  /// </summary>
  ANIMATION_SPEED = 800;

type
  TSTART_REC_ENUM = (SR_NOT_STATRED, SR_MANUAL_START, SR_STARTED);

type
  TfrmMain = class(TForm)
    tmrMain: TTimer;
    rzledTime: TRzLEDDisplay;
    tryicoMain: TTrayIcon;
    pmMain: TPopupMenu;
    mniC1: TMenuItem;
    mniS1: TMenuItem;
    mniN1: TMenuItem;
    pnlControl: TPanel;
    btnStart: TButton;
    lblMode: TLabel;
    procedure mniC1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMainTimer(Sender: TObject);
    procedure mniS1Click(Sender: TObject);
    procedure tryicoMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    FFormClickable: Boolean;
    FCanClose: Boolean;
    FIsStartRec: TSTART_REC_ENUM;
    FRecTime: TDateTime;
    // 是否已经超时
    FIsTimeout: Boolean;
    // 是否已经可以提醒
    FIsWarning: Boolean;
    FIsClickStartBtn: Boolean;
    /// <summary>
    /// 之前的时间
    /// </summary>
    FPrepTime: TDateTime;
    FCurrTime: TDateTime;
    /// <summary>
    /// 计时模式，0自动，1手动
    /// </summary>
    FModeType: Integer;
    FTimeout: Integer;
    FIsAutoHide: Boolean;
    FClickable: Boolean;
    FShowType: Integer;
    FAlphaBlendValueWhenPPT: Integer;
    FWarningTime: Integer;

    FTimeoutMsgBox: Boolean;
    FTimeoutSound: Boolean;
    FTimeoutSoundFilePath: string;
    FIsChangeTimeoutColor: Boolean;
    FTimeoutColor: TColor;

    FWarningMsgBox: Boolean;
    FWarningSound: Boolean;
    FWarningSoundFilePath: string;
    FIsChangeWarningColor: Boolean;
    FWarningColor: TColor;

    procedure WinMove(IsHide: Boolean);
    procedure LoadSetting();
    procedure SaveSetting();
    /// <summary>
    /// PPT是否全屏
    /// </summary>
    function IsPPTFullScreen(): Boolean;
    /// <summary>
    /// 让一个数增加或减少step来靠近DestNum
    /// </summary>
    function CloseToNumber(SourNum: Integer; DestNum: Integer; Step: Integer): Integer;
    procedure SetFormClickable(Value: Boolean);
    procedure SetUIbyStartandMode(Start: TSTART_REC_ENUM; ModeType: Integer);
    procedure SetModeType(const Value: Integer);
    procedure SetIsStartRec(const Value: TSTART_REC_ENUM);
  protected
    procedure CreateWnd; override;
  public
    { Public declarations }

    property FormClickable: Boolean read FFormClickable write SetFormClickable;
    property ModeType: Integer read FModeType write SetModeType;
    property IsStartRec: TSTART_REC_ENUM read FIsStartRec write SetIsStartRec;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  case IsStartRec of
  SR_STARTED:
  begin
    IsStartRec := SR_MANUAL_START;
  end;
  SR_MANUAL_START:
  begin
    FIsClickStartBtn := True;
  end;
  end;


end;

function TfrmMain.CloseToNumber(SourNum, DestNum, Step: Integer): Integer;
begin
  if SourNum > DestNum then
  begin
    SourNum := SourNum - Step;
    if SourNum < DestNum then
    begin
      SourNum := DestNum;
    end;
  end
  else if SourNum < DestNum then
  begin
    SourNum := SourNum + Step;
    if SourNum > DestNum then
    begin
      SourNum := DestNum;
    end;
  end;
  Result := SourNum;
end;

procedure TfrmMain.CreateWnd;
begin
  inherited;
  // SetFormClickable(False);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FCanClose then
  begin
    Action := caNone;
    tryicoMain.BalloonHint := '请通过托盘右键退出本程序。';
    tryicoMain.ShowBalloonHint;
  end
  else
  begin
    if MessageBox(Handle, '是否退出PPT计时软件？', '提示', MB_ICONQUESTION or MB_YESNO)<>IDYES then
    begin
      Action := caNone;
    end;
  end;
  SaveSetting();
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FPrepTime := Now();
  LoadSetting();
  FIsStartRec := SR_NOT_STATRED;
  SetUIbyStartandMode(FIsStartRec, FModeType);

  tryicoMain.Hint := 'PPT计时器';
  tryicoMain.BalloonHint := 'PPT计时器已经启动，要更改演示时间和显示方式，请点击托盘图标。';
  tryicoMain.BalloonTitle := '温馨提示';
  tryicoMain.ShowBalloonHint;
end;

function TfrmMain.IsPPTFullScreen: Boolean;
begin
  Result := (FindWindow('screenClass', nil) <> 0) or
    (FindWindow('paneClassDC', nil) <> 0);
end;

procedure TfrmMain.LoadSetting;
begin
  ClientWidth := Ini.ReadInteger(SEC_MAIN, IDE_WIDTH, ClientWidth);
  ClientHeight := Ini.ReadInteger(SEC_MAIN, IDE_HEIGHT, ClientHeight);
  Top := Ini.ReadInteger(SEC_MAIN, IDE_TOP, Top);
  Left := Ini.ReadInteger(SEC_MAIN, IDE_LEFT, Left);

  FClickable := Ini.ReadBool(SEC_MAIN, IDE_CLICKABLE, False);
  FTimeout := Ini.ReadInteger(SEC_MAIN, IDE_TIMEOUT, 300);
  FIsAutoHide := Ini.ReadBool(SEC_MAIN, IDE_AUTOHIDE, False);
  FShowType := Ini.ReadInteger(SEC_MAIN, IDE_SHOWTYPE, 0);
  FAlphaBlendValueWhenPPT := Ini.ReadInteger(SEC_MAIN, IDE_TRANSPARENT, AlphaBlendValue);
  rzledTime.SegOnColor := Ini.ReadInteger(SEC_MAIN, IDE_LED_TEXT_COLOR, clWhite);
  rzledTime.SegOffColor := Ini.ReadInteger(SEC_MAIN, IDE_LED_BACKGROUND_COLOR, clBlack);
  ModeType := Ini.ReadInteger(SEC_MAIN, IDE_MODE_TYPE, 0);
  FWarningTime := Ini.ReadInteger(SEC_WARNING, IDE_WARNINGTIME, 2);

  FTimeoutMsgBox := Ini.ReadBool(SEC_TIMEOUT, IDE_SHOW_MSG_BOX, True);
  FTimeoutSound := Ini.ReadBool(SEC_TIMEOUT, IDE_PLAY_SOUND, True);
  FTimeoutSoundFilePath := Ini.ReadString(SEC_TIMEOUT, IDE_SOUND_FILE_PATH, '');
  FIsChangeTimeoutColor := Ini.ReadBool(SEC_TIMEOUT, IDE_CHANGE_COLOR, True);
  FTimeoutColor := Ini.ReadInteger(SEC_TIMEOUT, IDE_CHANGE_COLOR, clRed);

  FWarningMsgBox := Ini.ReadBool(SEC_WARNING, IDE_SHOW_MSG_BOX, True);
  FWarningSound := Ini.ReadBool(SEC_WARNING, IDE_PLAY_SOUND, True);
  FWarningSoundFilePath := Ini.ReadString(SEC_WARNING, IDE_SOUND_FILE_PATH, '');
  FIsChangeWarningColor := Ini.ReadBool(SEC_WARNING, IDE_CHANGE_COLOR, True);
  FWarningColor := Ini.ReadInteger(SEC_WARNING, IDE_CHANGE_COLOR, clYellow);

end;

procedure TfrmMain.mniC1Click(Sender: TObject);
begin
  FCanClose := True;

  Close;
end;

procedure TfrmMain.mniS1Click(Sender: TObject);
begin
  if IsStartRec <> SR_NOT_STATRED then
  begin
    MessageBox(Handle, 'PPT演示期间不能更改设置，请先退出PPT演示。', '注意', MB_ICONWARNING);
    Exit;
  end;
  SaveSetting();
  ShowSet(Self);
  LoadSetting();
end;

procedure TfrmMain.SaveSetting;
begin
  Ini.WriteInteger(SEC_MAIN, IDE_WIDTH, ClientWidth);
  Ini.WriteInteger(SEC_MAIN, IDE_HEIGHT, ClientHeight);
  Ini.WriteInteger(SEC_MAIN, IDE_TOP, Top);
  Ini.WriteInteger(SEC_MAIN, IDE_LEFT, Left);
end;

procedure TfrmMain.SetFormClickable(Value: Boolean);
begin
  if FFormClickable <> Value then
  begin
    if Value then
    begin
      SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) and
        not WS_EX_TRANSPARENT and not WS_EX_LAYERED);
    end
    else
    begin
      SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
        WS_EX_TRANSPARENT or WS_EX_LAYERED);

      // SetLayeredWindowAttributes(Handle, Color, 150, LWA_ALPHA or LWA_COLORKEY);
    end;
    FFormClickable := Value;
  end;
end;

procedure TfrmMain.SetIsStartRec(const Value: TSTART_REC_ENUM);
begin
  if Value <> FIsStartRec then
  begin
    FIsStartRec := Value;

    case FIsStartRec of
      SR_NOT_STATRED:
        begin

          //下面两行代码可以去掉
          FIsTimeout := False;
          FIsWarning := False;
        end;
      SR_STARTED:
        begin
          FRecTime := Now;
          //重置
          FIsTimeout := False;
          FIsWarning := False;
        end;
    end;
    SetUIbyStartandMode(FIsStartRec, FModeType);
  end;
end;

procedure TfrmMain.SetModeType(const Value: Integer);
begin
  if Value <> FModeType then
  begin
    FModeType := Value;
    SetUIbyStartandMode(FIsStartRec, FModeType);
  end;
end;

procedure TfrmMain.SetUIbyStartandMode(Start: TSTART_REC_ENUM; ModeType: Integer);
begin
  case Start of
    SR_NOT_STATRED:
      begin
        case ModeType of
          0:
            begin
              btnStart.Enabled := False;
              btnStart.Caption := '自动计时';
              lblMode.Caption := '当前模式:自动计时';
            end;
          1:
            begin
              btnStart.Enabled := False;
              btnStart.Caption := '手动计时';
              lblMode.Caption := '当前模式:手动计时';
            end;
        else

        end;
        rzledTime.Caption := 'WAITING';
        rzledTime.SegOnColor := clWhite;
        AlphaBlendValue := 255;
      end;
    SR_MANUAL_START:
      begin
        btnStart.Enabled := True;
        btnStart.Caption := '开始计时';
        lblMode.Caption := '演示已开始，请点计时按钮';
      end;
    SR_STARTED:
      begin
        case ModeType of
        0:
        begin
          btnStart.Caption := '已开始计时';
          btnStart.Enabled := False;
        end;
        1:
        begin
          btnStart.Caption := '停止计时';
          btnStart.Enabled := True;
        end;
        end;

        lblMode.Caption := '正在计时...';
        AlphaBlendValue := FAlphaBlendValueWhenPPT;
      end;
  end;
end;

procedure TfrmMain.tmrMainTimer(Sender: TObject);
var
  hCursor: TPoint;
  IsCurInWin: Boolean;
  Timeout: Integer;
  I: Integer;
  _IsPPTFullScreen: Boolean;
begin
  FCurrTime := Now();
  GetCursorPos(hCursor);
  // 查找鼠标是否在窗口上
  IsCurInWin := (hCursor.X >= Left) and (hCursor.X <= Left + Width) and (hCursor.Y >= Top)
    and (hCursor.Y <= Top + Height);
  _IsPPTFullScreen := IsPPTFullScreen();

  if _IsPPTFullScreen then
  begin
    FormStyle := fsNormal;
    FormStyle := fsStayOnTop;
    // 是否开始演示了
    case IsStartRec of
      SR_NOT_STATRED:
        begin
          if ModeType = 1 then
          begin
            IsStartRec := SR_MANUAL_START;
          end
          else
          begin
            IsStartRec := SR_STARTED;
          end;
        end;
      SR_MANUAL_START:
        begin
          if FIsClickStartBtn then
          begin
            FIsClickStartBtn := False;
            IsStartRec := SR_STARTED;
          end;
        end;
      SR_STARTED:
        begin
        end;
    end;
  end
  else
  begin
    FormClickable := True;
    IsStartRec := SR_NOT_STATRED;

  end;

  case IsStartRec of
    SR_NOT_STATRED:
      begin
        if IsCurInWin then
        begin
          WinMove(False);
        end
        else
        begin
          WinMove(True);
        end;
      end;
    SR_MANUAL_START:
      begin
        WinMove(False);
      end;
    SR_STARTED:
      begin
        FormClickable := FClickable;
        Timeout := SecondsBetween(Now, FRecTime);
        if Timeout > FTimeout then
        begin
          if not FIsTimeout then
          begin
            FIsTimeout := True;
            // 是否要改变颜色
            if FIsChangeTimeoutColor then
            begin
              rzledTime.SegOnColor := FTimeoutColor;
            end;
            // 是否要播放声音
            if FTimeoutSound then
            begin
              sndPlaySound(PChar(FTimeoutSoundFilePath), SND_ASYNC);
            end;
            // 是否要弹出对话框
            if FTimeoutMsgBox then
            begin
              MessageBox(Handle, '时间已超时。', '注意', MB_ICONWARNING);
            end;

          end;

          WinMove(False);
        end
        else
        begin
          if Timeout > FTimeout - FWarningTime then
          begin
            if not FIsWarning then
            begin
              FIsWarning := True;
              // 是否要改变颜色
              if FIsChangeWarningColor then
              begin
                rzledTime.SegOnColor := FWarningColor;
              end;
              // 是否要播放声音
              if FWarningSound then
              begin
                sndPlaySound(PChar(FWarningSoundFilePath), SND_ASYNC);
              end;

              // 是否要弹出对话框
              if FWarningMsgBox then
              begin
                MessageBox(Handle, '即将超时，请注意把握时间。', '注意', MB_ICONWARNING);
              end;

            end;
          end
          else
          begin
            rzledTime.SegOnColor := clWhite;
          end;
          if IsCurInWin then
          begin
            WinMove(False);
          end
          else
          begin
            WinMove(True);
          end;
        end;
        case FShowType of
          0: // 倒计时
            begin
              I := FTimeout - Timeout;
              if I >= 0 then
              begin
                rzledTime.Caption := Format('%.2d:%.2d', [I div 60, I mod 60]);
              end
              else
              begin
                rzledTime.Caption := Format('-%.2d:%.2d', [(-I) div 60, (-I) mod 60]);
              end;
            end;
          1: // 正计时
            begin
              rzledTime.Caption := Format('%.2d:%.2d', [Timeout div 60, Timeout mod 60]);
            end;
        end;
      end;
  end;

  FPrepTime := FCurrTime;

end;

procedure TfrmMain.tryicoMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SetForegroundWindow(Application.Handle);
    Application.ProcessMessages;
    pmMain.Popup(X, Y);
  end;
end;

procedure TfrmMain.WinMove(IsHide: Boolean);
var
  _Interval: Integer;
begin
  _Interval := Round(MilliSecondsBetween(FPrepTime, FCurrTime) / 1000 * ANIMATION_SPEED);
  if FIsAutoHide then
  begin
    //
    if Left <= 0 then
    begin
      if IsHide then
      begin
        Left := CloseToNumber(Left, BORDER_WIDTH - Width, _Interval);
      end
      else
      begin
        Left := CloseToNumber(Left, 0, _Interval);
      end;
    end
    else if Top <= 0 then
    begin
      if IsHide then
      begin
        Top := CloseToNumber(Top, BORDER_WIDTH - Height, _Interval);
      end
      else
      begin
        Top := CloseToNumber(Top, 0, _Interval);
      end;
    end
    else if Left + Width >= Screen.Width then
    begin
      if IsHide then
      begin
        Left := CloseToNumber(Left, Screen.Width - BORDER_WIDTH, _Interval);
      end
      else
      begin
        Left := CloseToNumber(Left, Screen.Width - Width, _Interval);
      end;
    end
    else if Top + Height >= Screen.Height then
    begin
      if IsHide then
      begin
        Top := CloseToNumber(Top, Screen.Height - BORDER_WIDTH, _Interval);
      end
      else
      begin
        Top := CloseToNumber(Top, Screen.Height - Height, _Interval);
      end;
    end;

  end;
end;

end.
