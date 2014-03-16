unit untIni;
/// <author>LCXL</author>
/// <summary>
/// PPT��ʱϵͳ������Ϣ��Ԫ��lcx87654321@163.com
/// </summary>
interface
uses
  Windows, SysUtils, IniFiles;

const
  SEC_MAIN = 'Main';
  SEC_TIMEOUT = 'Timeout';
  SEC_WARNING = 'Warning';
const
  IDE_TIMEOUT = 'Timeout';
  /// <summary>
  /// ��ʾʱ�Ƿ�ɴ�͸
  /// </summary>
  IDE_CLICKABLE = 'Clickable';
  IDE_AUTOHIDE = 'AutoHide';
  /// <summary>
  /// ��ʾ���ͣ�����ʱ���ǵ���ʱ
  /// </summary>
  IDE_SHOWTYPE = 'ShowType';
  IDE_TRANSPARENT = 'Transparent';
  IDE_TOP = 'Top';
  IDE_LEFT = 'Left';
  IDE_WIDTH = 'Width';
  IDE_HEIGHT = 'Height';
  IDE_LED_TEXT_COLOR = 'LEDTextColor';
  IDE_LED_BACKGROUND_COLOR = 'LEDBackgroundColor';
  IDE_MODE_TYPE = 'ModeType';
const//Timeout,Warning
  IDE_WARNINGTIME = 'Warning';
  IDE_SHOW_MSG_BOX = 'ShowMsgBox';
  IDE_PLAY_SOUND = 'PlaySound';
  IDE_SOUND_FILE_PATH = 'SoundFilePath';
  IDE_CHANGE_COLOR = 'ChangeColor';
  IDE_COLOR = 'Color';
var
  Ini: TIniFile;
implementation

initialization
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'set.ini');

finalization
  Ini.Free;
end.
