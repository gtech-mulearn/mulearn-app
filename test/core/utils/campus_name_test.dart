import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/utils/campus_name.dart';

/// Real titles from the college leaderboard (2026-11-23): many are stored
/// in ALL CAPS, which reads as shouting and runs wide on a phone.
void main() {
  const cases = <(String?, String?, String)>[
    (
      'ST JOSEPHS COLLEGE OF ENGINEERING AND TECHNOLOGY PALAI',
      'SJC',
      'St Josephs College of Engineering and Technology Palai',
    ),
    ('AWH ENGINEERING COLLEGE', 'AWH', 'AWH Engineering College'),
    (
      'GOVERNMENT COMMERCIAL INSTITUTE, MANNANTHALA, THIRUVANANTHAPURAM',
      'GCI-01',
      'Government Commercial Institute, Mannanthala, Thiruvananthapuram',
    ),
    (
      'M.DASAN INSTITUTE OF TECHNOLOGY',
      'DMC',
      'M.Dasan Institute of Technology',
    ),
    ('LBS COLLEGE OF ENGINEERING', 'KSD', 'LBS College of Engineering'),
    (
      'ADI SHANKARA INSTITUTE OF ENGG AND TECHNOLOGY',
      'ASI',
      'Adi Shankara Institute of Engg and Technology',
    ),
    (
      'Mar Baselios College of Engineering and Technology',
      'MBT',
      'Mar Baselios College of Engineering and Technology',
    ),
    (
      'MES MK Mackar Pillay College For Advanced Studies',
      'MESCAS',
      'MES MK Mackar Pillay College For Advanced Studies',
    ),
    // Short acronyms stay acronyms; short real words don't.
    ('NIT CALICUT', 'NITC', 'NIT Calicut'),
    ('IES COLLEGE OF ENGINEERING', 'IESCE', 'IES College of Engineering'),
    ('APJ ABDUL KALAM SCHOOL OF IT', 'APJ', 'APJ Abdul Kalam School of IT'),
    ('SRI SAI RAM COLLEGE', 'SSRC', 'Sri Sai Ram College'),
    ('MAR ATHANASIUS COLLEGE', 'MAC', 'Mar Athanasius College'),
    (null, 'MBT', 'MBT'),
    ('  ', null, 'Unknown college'),
  ];

  for (final (title, code, expected) in cases) {
    test('"$title" ($code) reads "$expected"', () {
      expect(campusDisplayName(title: title, code: code), expected);
    });
  }
}
