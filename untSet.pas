unit untSet;
/// <author>LCXL</author>
/// <summary>
/// PPT计时系统设置窗口单元，lcx87654321@163.com
/// </summary>
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untIni, ExtCtrls, ComCtrls, ActnMan, ActnColorMaps,
  ImgList, VCLTee.TeCanvas;

type
  TfrmSet = class(TForm)
    btnOK: TButton;
    pgcSetting: TPageControl;
    tsgeneral: TTabSheet;
    lblTimeout: TLabel;
    lblS: TLabel;
    edtSecond: TEdit;
    chkClickable: TCheckBox;
    rgShowType: TRadioGroup;
    dlgColor1: TColorDialog;
    lblTransparent: TLabel;
    lblTransparentValue: TLabel;
    udSecond: TUpDown;
    edtMinute: TEdit;
    udMinute: TUpDown;
    lblMinute: TLabel;
    chkAutoHide: TCheckBox;
    tsTip: TTabSheet;
    trckbrTransparent: TTrackBar;
    grpTimeOut: TGroupBox;
    chkTimeoutMsgBox: TCheckBox;
    chkTimeoutSound: TCheckBox;
    btnTimeoutSoundFilePath: TButtonedEdit;
    ilSet: TImageList;
    lblTimeoutSoundFilePath: TLabel;
    dlgOpenSound: TOpenDialog;
    grpWarning: TGroupBox;
    btnWarningSoundFilePath: TButtonedEdit;
    lblWarningSoundFilePath: TLabel;
    chkWarningSound: TCheckBox;
    chkWarningMsgBox: TCheckBox;
    lblWarningTime1: TLabel;
    chkTimeoutColor: TCheckBox;
    chkWarningColor: TCheckBox;
    lblWarningTime3: TLabel;
    edtWarningTimeSec: TEdit;
    btnTimeoutColor: TButtonColor;
    btnWarningColor: TButtonColor;
    btnTextColor: TButtonColor;
    btnBackgroundColor: TButtonColor;
    edtWarningTimeMin: TEdit;
    lblWarningTime2: TLabel;
    udWarningTimeMin: TUpDown;
    udWarningTimeSec: TUpDown;
    rgMode: TRadioGroup;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure trckbrTransparentChange(Sender: TObject);
    procedure edtMinuteChange(Sender: TObject);
    procedure edtSecondChange(Sender: TObject);
    procedure btnSoundFilePathRightButtonClick(Sender: TObject);
    procedure chkTimeoutSoundClick(Sender: TObject);
    procedure chkWarningSoundClick(Sender: TObject);
    procedure chkTimeoutColorClick(Sender: TObject);
    procedure chkWarningColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtWarningTimeMinChange(Sender: TObject);
    procedure edtWarningTimeSecChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSet: TfrmSet;

procedure ShowSet(AOwner: TForm);

implementation

{$R *.dfm}

procedure ShowSet(AOwner: TForm);
begin
  frmSet := TfrmSet.Create(AOwner);
  //SetWindowLong(frmSet.Handle, GWL_HWNDPARENT, NativeInt(AOwner.Handle));
  frmSet.ShowModal;
  frmSet.Free;
end;

procedure TfrmSet.btnOKClick(Sender: TObject);
var
  TimeOut: Integer;
begin

  TimeOut := udMinute.Position*60+udSecond.Position;
  Ini.WriteInteger(SEC_MAIN, IDE_TIMEOUT, TimeOut);
  Ini.WriteBool(SEC_MAIN, IDE_CLICKABLE, chkClickable.Checked);
  Ini.WriteBool(SEC_MAIN, IDE_AUTOHIDE, chkAutoHide.Checked);
  Ini.WriteInteger(SEC_MAIN, IDE_SHOWTYPE, rgShowType.ItemIndex);
  Ini.WriteInteger(SEC_MAIN, IDE_TRANSPARENT, trckbrTransparent.Position);
  Ini.WriteInteger(SEC_MAIN, IDE_LED_TEXT_COLOR, btnTextColor.SymbolColor);
  Ini.WriteInteger(SEC_MAIN, IDE_LED_BACKGROUND_COLOR, btnBackgroundColor.SymbolColor);
  Ini.WriteInteger(SEC_MAIN,IDE_MODE_TYPE, rgMode.ItemIndex);
  Ini.WriteInteger(SEC_WARNING, IDE_WARNINGTIME, udWarningTimeMin.Position*60+udWarningTimeSec.Position);

  Ini.WriteBool(SEC_TIMEOUT, IDE_SHOW_MSG_BOX, chkTimeoutMsgBox.Checked);
  Ini.WriteBool(SEC_TIMEOUT, IDE_PLAY_SOUND, chkTimeoutSound.Checked);
  Ini.WriteString(SEC_TIMEOUT, IDE_SOUND_FILE_PATH, btnTimeoutSoundFilePath.Text);
  Ini.WriteBool(SEC_TIMEOUT, IDE_CHANGE_COLOR, chkTimeoutColor.Checked);
  Ini.WriteInteger(SEC_TIMEOUT, IDE_CHANGE_COLOR, btnTimeoutColor.SymbolColor);

  Ini.WriteBool(SEC_WARNING, IDE_SHOW_MSG_BOX, chkWarningMsgBox.Checked);
  Ini.WriteBool(SEC_WARNING, IDE_PLAY_SOUND, chkWarningSound.Checked);
  Ini.WriteString(SEC_WARNING, IDE_SOUND_FILE_PATH, btnWarningSoundFilePath.Text);
  Ini.WriteBool(SEC_WARNING, IDE_CHANGE_COLOR, chkWarningColor.Checked);
  Ini.WriteInteger(SEC_WARNING, IDE_CHANGE_COLOR, btnWarningColor.SymbolColor);
  Close;
end;

procedure TfrmSet.btnSoundFilePathRightButtonClick(Sender: TObject);
begin
  if dlgOpenSound.Execute(Handle) then
  begin
    if UpperCase(ExtractFilePath(dlgOpenSound.FileName))= UpperCase(ExtractFilePath(ParamStr(0))) then
    begin
      (Sender as TButtonedEdit).Text := ExtractFileName(dlgOpenSound.FileName);
    end
    else
    begin
      (Sender as TButtonedEdit).Text := dlgOpenSound.FileName;
    end;
  end;
end;

procedure TfrmSet.chkTimeoutColorClick(Sender: TObject);
begin
  btnTimeoutColor.Enabled := chkTimeoutColor.Checked;
end;

procedure TfrmSet.chkTimeoutSoundClick(Sender: TObject);
begin
  lblTimeoutSoundFilePath.Enabled := chkTimeoutSound.Checked;
  btnTimeoutSoundFilePath.Enabled := chkTimeoutSound.Checked;
end;

procedure TfrmSet.chkWarningColorClick(Sender: TObject);
begin
   btnWarningColor.Enabled := chkWarningColor.Checked;
end;

procedure TfrmSet.chkWarningSoundClick(Sender: TObject);
begin
  lblWarningSoundFilePath.Enabled := chkWarningSound.Checked;
  btnWarningSoundFilePath.Enabled := chkWarningSound.Checked;
end;

procedure TfrmSet.edtMinuteChange(Sender: TObject);
var
  _tmpInt: Integer;
begin
  if TryStrToInt((Sender as TEdit).Text, _tmpInt) then
  begin
    if udMinute.Position <> _tmpInt then
    begin
      udMinute.Position := _tmpInt;
    end;
  end;
end;

procedure TfrmSet.edtSecondChange(Sender: TObject);
var
  _tmpInt: Integer;
begin
  if TryStrToInt((Sender as TEdit).Text, _tmpInt) then
  begin
    if udSecond.Position <> _tmpInt then
    begin
      udSecond.Position := _tmpInt;
    end;
  end;
end;

procedure TfrmSet.edtWarningTimeMinChange(Sender: TObject);
var
  _tmpInt: Integer;
begin
  if TryStrToInt((Sender as TEdit).Text, _tmpInt) then
  begin
    if udWarningTimeMin.Position <> _tmpInt then
    begin
      udWarningTimeMin.Position := _tmpInt;
    end;
  end;
end;

procedure TfrmSet.edtWarningTimeSecChange(Sender: TObject);
var
  _tmpInt: Integer;
begin
  if TryStrToInt((Sender as TEdit).Text, _tmpInt) then
  begin
    if udWarningTimeSec.Position <> _tmpInt then
    begin
      udWarningTimeSec.Position := _tmpInt;
    end;
  end;
end;

procedure TfrmSet.FormCreate(Sender: TObject);
begin
  pgcSetting.ActivePageIndex := 0;
end;

procedure TfrmSet.FormShow(Sender: TObject);
var
  _TimeOut: Integer;
  _WarningTime: Integer;
begin
  _TimeOut := Ini.ReadInteger(SEC_MAIN, IDE_TIMEOUT, 300);
  udSecond.Position := _TimeOut mod 60;
  udMinute.Position := _TimeOut div 60;
  chkClickable.Checked := Ini.ReadBool(SEC_MAIN, IDE_CLICKABLE, chkClickable.Checked);
  chkAutoHide.Checked := Ini.ReadBool(SEC_MAIN, IDE_AUTOHIDE, chkAutoHide.Checked);
  rgShowType.ItemIndex := Ini.ReadInteger(SEC_MAIN, IDE_SHOWTYPE, rgShowType.ItemIndex);
  trckbrTransparent.Position :=  Ini.ReadInteger(SEC_MAIN, IDE_TRANSPARENT, trckbrTransparent.Position);
  btnTextColor.SymbolColor := Ini.ReadInteger(SEC_MAIN, IDE_LED_TEXT_COLOR, clWhite);
  btnBackgroundColor.SymbolColor := Ini.ReadInteger(SEC_MAIN, IDE_LED_BACKGROUND_COLOR, clBlack);
  rgMode.ItemIndex := Ini.ReadInteger(SEC_MAIN,IDE_MODE_TYPE, rgMode.ItemIndex);
  _WarningTime := Ini.ReadInteger(SEC_WARNING, IDE_WARNINGTIME, 2);
  udWarningTimeMin.Position := _WarningTime div 60;
  udWarningTimeSec.Position := _WarningTime mod 60;

  chkTimeoutMsgBox.Checked := Ini.ReadBool(SEC_TIMEOUT, IDE_SHOW_MSG_BOX, chkTimeoutMsgBox.Checked);
  chkTimeoutSound.Checked := Ini.ReadBool(SEC_TIMEOUT, IDE_PLAY_SOUND, chkTimeoutSound.Checked);
  btnTimeoutSoundFilePath.Text := Ini.ReadString(SEC_TIMEOUT, IDE_SOUND_FILE_PATH, btnTimeoutSoundFilePath.Text);
  chkTimeoutColor.Checked := Ini.ReadBool(SEC_TIMEOUT, IDE_CHANGE_COLOR, chkTimeoutColor.Checked);
  btnTimeoutColor.SymbolColor := Ini.ReadInteger(SEC_TIMEOUT, IDE_CHANGE_COLOR, clRed);

  chkWarningMsgBox.Checked := Ini.ReadBool(SEC_WARNING, IDE_SHOW_MSG_BOX, True);
  chkWarningSound.Checked := Ini.ReadBool(SEC_WARNING, IDE_PLAY_SOUND, True);
  btnWarningSoundFilePath.Text := Ini.ReadString(SEC_WARNING, IDE_SOUND_FILE_PATH, '');
  chkWarningColor.Checked := Ini.ReadBool(SEC_WARNING, IDE_CHANGE_COLOR, True);
  btnWarningColor.SymbolColor := Ini.ReadInteger(SEC_WARNING, IDE_CHANGE_COLOR, clYellow);
end;

procedure TfrmSet.trckbrTransparentChange(Sender: TObject);
begin
  lblTransparentValue.Caption := Format('%.0f%%', [trckbrTransparent.Position*100/255]);
end;

end.
