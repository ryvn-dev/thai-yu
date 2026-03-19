// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'ไทยหยู่';

  @override
  String get pasteThaiText => 'วางข้อความภาษาไทย';

  @override
  String get analyze => 'วิเคราะห์';

  @override
  String get learningMode => 'โหมดเรียนรู้';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get apiKeySettings => 'ตั้งค่า API';

  @override
  String get apiKeyHint => 'ใส่ OpenAI API key ของคุณ';

  @override
  String get validate => 'ตรวจสอบ';

  @override
  String get apiKeyValid => 'API key ถูกต้อง';

  @override
  String get apiKeyInvalid => 'API key ไม่ถูกต้อง';

  @override
  String get apiKeyNotSet => 'ยังไม่ได้ตั้งค่า API key';

  @override
  String get ttsNote => 'เสียงสังเคราะห์ TTS — วรรณยุกต์เป็นการประมาณ';

  @override
  String get play => 'เล่น';

  @override
  String get onset => 'พยัญชนะต้น';

  @override
  String get vowel => 'สระ';

  @override
  String get coda => 'ตัวสะกด';

  @override
  String get toneMid => 'สามัญ';

  @override
  String get toneLow => 'เอก';

  @override
  String get toneFall => 'โท';

  @override
  String get toneHigh => 'ตรี';

  @override
  String get toneRise => 'จัตวา';

  @override
  String get emptyStateTitle => 'ยินดีต้อนรับ';

  @override
  String get emptyStateHint =>
      'วางข้อความภาษาไทยด้านบน เพื่อดูการแยกเสียง พยัญชนะ สระ และวรรณยุกต์ของแต่ละคำ';

  @override
  String get networkError => 'ไม่สามารถเชื่อมต่อได้ กรุณาลองอีกครั้ง';

  @override
  String get nonThaiInput => 'กรุณาใส่ข้อความภาษาไทย';

  @override
  String get silentCoda => 'เงียบ';
}
