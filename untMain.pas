unit untMain;
/// <author>LCXL</author>
/// <summary>
/// PPT��ʱϵͳ����Ԫ��lcx87654321@163.com
/// </summary>
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzBorder, Menus, StdCtrls, DateUtils, untSet, untIni, MMSystem;

const
  /// <summary>
  /// ����ʱ�ı߽���
  /// </summary>
  BORDER_WIDTH = 5;
  /// <summary>
  /// ���ڶ����ٶ�(5����/s)
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
    // �Ƿ��Ѿ���ʱ
    FIsTimeout: Boolean;
    // �Ƿ��Ѿ���������
    FIsWarning: Boolean;
    FIsClickStartBtn: Boolean;
    /// <summary>
    /// ֮ǰ��ʱ��
    /// </summary>
    FPrepTime: TDateTime;
    FCurrTime: TDateTime;
    /// <summary>
    /// ��ʱģʽ��0�Զ���1�ֶ�
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
    /// PPT�Ƿ�ȫ��
    /// </summary>
    function IsPPTFullScreen(): Boolean;
    /// <summary>
    /// ��һ�������ӻ����step������DestNum
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
    tryicoMain.BalloonHint := '��ͨ�������Ҽ��˳�������';
    tryicoMain.ShowBalloonHint;
  end
  else
  begin
    if MessageBox(Handle, '�Ƿ��˳�PPT��ʱ�����', '��ʾ', MB_ICONQUESTION or MB_YESNO)<>IDYES then
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

  tryicoMain.Hint := 'PPT��ʱ��';
  tryicoMain.BalloonHint := 'PPT��ʱ���Ѿ�������Ҫ������ʾʱ�����ʾ��ʽ����������ͼ�ꡣ';
  tryicoMain.BalloonTitle := '��ܰ��ʾ';
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
    MessageBox(Handle, 'PPT��ʾ�ڼ䲻�ܸ������ã������˳�PPT��ʾ��', 'ע��', MB_ICONWARNING);
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

          //�������д������ȥ��
          FIsTimeout := False;
          FIsWarning := False;
        end;
      SR_STARTED:
        begin
          FRecTime := Now;
          //����
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
              btnStart.Caption := '�Զ���ʱ';
              lblMode.Caption := '��ǰģʽ:�Զ���ʱ';
            end;
          1:
            begin
              btnStart.Enabled := False;
              btnStart.Caption := '�ֶ���ʱ';
              lblMode.Caption := '��ǰģʽ:�ֶ���ʱ';
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
        btnStart.Caption := '��ʼ��ʱ';
        lblMode.Caption := '��ʾ�ѿ�ʼ������ʱ��ť';
      end;
    SR_STARTED:
      begin
        case ModeType of
        0:
        begin
          btnStart.Caption := '�ѿ�ʼ��ʱ';
          btnStart.Enabled := False;
        end;
        1:
        begin
          btnStart.Caption := 'ֹͣ��ʱ';
          btnStart.Enabled := True;
        end;
        end;

        lblMode.Caption := '���ڼ�ʱ...';
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
  // ��������Ƿ��ڴ�����
  IsCurInWin := (hCursor.X >= Left) and (hCursor.X <= Left + Width) and (hCursor.Y >= Top)
    and (hCursor.Y <= Top + Height);
  _IsPPTFullScreen := IsPPTFullScreen();

  if _IsPPTFullScreen then
  begin
    FormStyle := fsNormal;
    FormStyle := fsStayOnTop;
    // �Ƿ�ʼ��ʾ��
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
            // �Ƿ�Ҫ�ı���ɫ
            if FIsChangeTimeoutColor then
            begin
              rzledTime.SegOnColor := FTimeoutColor;
            end;
            // �Ƿ�Ҫ��������
            if FTimeoutSound then
            begin
              sndPlaySound(PChar(FTimeoutSoundFilePath), SND_ASYNC);
            end;
            // �Ƿ�Ҫ�����Ի���
            if FTimeoutMsgBox then
            begin
              MessageBox(Handle, 'ʱ���ѳ�ʱ��', 'ע��', MB_ICONWARNING);
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
              // �Ƿ�Ҫ�ı���ɫ
              if FIsChangeWarningColor then
              begin
                rzledTime.SegOnColor := FWarningColor;
              end;
              // �Ƿ�Ҫ��������
              if FWarningSound then
              begin
                sndPlaySound(PChar(FWarningSoundFilePath), SND_ASYNC);
              end;

              // �Ƿ�Ҫ�����Ի���
              if FWarningMsgBox then
              begin
                MessageBox(Handle, '������ʱ����ע�����ʱ�䡣', 'ע��', MB_ICONWARNING);
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
          0: // ����ʱ
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
          1: // ����ʱ
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
