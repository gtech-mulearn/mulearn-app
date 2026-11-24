import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/utils/count_format.dart';

void main() {
  test('formatCount groups thousands', () {
    expect(formatCount(0), '0');
    expect(formatCount(999), '999');
    expect(formatCount(1000), '1,000');
    expect(formatCount(4120), '4,120');
    expect(formatCount(1234567), '1,234,567');
    expect(formatCount(-4120), '-4,120');
  });

  test('countOf picks the singular only for 1', () {
    expect(countOf(1, 'phone'), '1 phone');
    expect(countOf(0, 'phone'), '0 phones');
    expect(countOf(4120, 'phone'), '4,120 phones');
    expect(countOf(1, 'person', 'people'), '1 person');
    expect(countOf(2, 'person', 'people'), '2 people');
  });
}
