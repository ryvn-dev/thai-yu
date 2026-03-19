/// Thai consonant classification for tone determination.
///
/// Every Thai consonant belongs to one of three classes: low, mid, or high.
/// This classification, combined with tone marks and syllable type,
/// deterministically produces the correct tone.
enum ConsonantClass {
  low,
  mid,
  high;

  static ConsonantClass fromJson(String value) =>
      ConsonantClass.values.byName(value);

  String toJson() => name;
}

/// Lookup table: Thai consonant → class
///
/// Source: standard Thai phonology reference
const Map<String, ConsonantClass> consonantClassTable = {
  // Mid class (อักษรกลาง) — 9 consonants
  'ก': ConsonantClass.mid,
  'จ': ConsonantClass.mid,
  'ฎ': ConsonantClass.mid,
  'ฏ': ConsonantClass.mid,
  'ด': ConsonantClass.mid,
  'ต': ConsonantClass.mid,
  'บ': ConsonantClass.mid,
  'ป': ConsonantClass.mid,
  'อ': ConsonantClass.mid,

  // High class (อักษรสูง) — 11 consonants
  'ข': ConsonantClass.high,
  'ฃ': ConsonantClass.high,
  'ฉ': ConsonantClass.high,
  'ฐ': ConsonantClass.high,
  'ถ': ConsonantClass.high,
  'ผ': ConsonantClass.high,
  'ฝ': ConsonantClass.high,
  'ศ': ConsonantClass.high,
  'ษ': ConsonantClass.high,
  'ส': ConsonantClass.high,
  'ห': ConsonantClass.high,

  // Low class (อักษรต่ำ) — 24 consonants
  'ค': ConsonantClass.low,
  'ฅ': ConsonantClass.low,
  'ฆ': ConsonantClass.low,
  'ง': ConsonantClass.low,
  'ช': ConsonantClass.low,
  'ซ': ConsonantClass.low,
  'ฌ': ConsonantClass.low,
  'ญ': ConsonantClass.low,
  'ฑ': ConsonantClass.low,
  'ฒ': ConsonantClass.low,
  'ณ': ConsonantClass.low,
  'ท': ConsonantClass.low,
  'ธ': ConsonantClass.low,
  'น': ConsonantClass.low,
  'พ': ConsonantClass.low,
  'ฟ': ConsonantClass.low,
  'ภ': ConsonantClass.low,
  'ม': ConsonantClass.low,
  'ย': ConsonantClass.low,
  'ร': ConsonantClass.low,
  'ล': ConsonantClass.low,
  'ว': ConsonantClass.low,
  'ฬ': ConsonantClass.low,
  'ฮ': ConsonantClass.low,
};

/// Look up the class of a Thai consonant character.
/// Returns null if the character is not a recognized consonant.
ConsonantClass? lookupConsonantClass(String char) =>
    consonantClassTable[char];
