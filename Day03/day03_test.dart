import 'package:test/test.dart';

import 'day03.dart';

Future<void> main() async {
  group('day 03', () {
    test('part one', () {
      final input = [
        'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))',
      ];
      expect(part1(input), 161);
    });

    test('part two', () {
      final input = [
        'xmul(2,4)&mul[3,7]!^don\'t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))',
      ];
      expect(part2(input), 48);
    });
  });
}
