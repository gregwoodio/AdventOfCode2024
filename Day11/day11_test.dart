import 'package:test/test.dart';

import 'day11.dart';

Future<void> main() async {
  group('day 11', () {
    test('part one', () {
      final input = [125, 17];
      expect(part1(input), 55312);
    });

    test('part two', () {
      final input = [125, 17];
      expect(part2(input), 0);
    });
  });
}
