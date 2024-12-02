import 'package:test/test.dart';

import 'day02.dart';

Future<void> main() async {
  group('day 02', () {
    final input = [
      '7 6 4 2 1',
      '1 2 7 8 9',
      '9 7 6 2 1',
      '1 3 2 4 5',
      '8 6 4 4 1',
      '1 3 6 7 9',
    ];

    test('part one', () {
      expect(part1(input), 2);
    });

    test('part one', () {
      expect(part2(input), 4);
    });
  });
}
