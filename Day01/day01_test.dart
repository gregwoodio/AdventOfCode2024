import 'package:test/test.dart';

import 'day01.dart';

Future<void> main() async {
  group('day 01', () {
    final input = [
      '3   4',
      '4   3',
      '2   5',
      '1   3',
      '3   9',
      '3   3',
    ];

    test('part one', () {
      expect(part1(input), 11);
    });

    test('part one', () {
      expect(part2(input), 31);
    });
  });
}
