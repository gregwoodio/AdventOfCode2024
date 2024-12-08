import 'package:test/test.dart';

import 'day07.dart';

Future<void> main() async {
  group('day 07', () {
    test('part one', () {
      final input = [
        '190: 10 19',
        '3267: 81 40 27',
        '83: 17 5',
        '156: 15 6',
        '7290: 6 8 6 15',
        '161011: 16 10 13',
        '192: 17 8 14',
        '21037: 9 7 18 13',
        '292: 11 6 16 20',
      ];
      expect(part1(input), 3749);
    });

    test('part two', () {
      final input = [
        '190: 10 19',
        '3267: 81 40 27',
        '83: 17 5',
        '156: 15 6',
        '7290: 6 8 6 15',
        '161011: 16 10 13',
        '192: 17 8 14',
        '21037: 9 7 18 13',
        '292: 11 6 16 20',
      ];
      expect(part2(input), 11387);
    });
  });
}
