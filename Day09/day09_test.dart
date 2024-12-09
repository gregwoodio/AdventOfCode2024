import 'package:test/test.dart';

import 'day09.dart';

Future<void> main() async {
  group('day 09', () {
    test('expand', () {
      expect(expand('12345'),
          [0, null, null, 1, 1, 1, null, null, null, null, 2, 2, 2, 2, 2]);
      expect(expand('2333133121414131402'), [
        0,
        0,
        null,
        null,
        null,
        1,
        1,
        1,
        null,
        null,
        null,
        2,
        null,
        null,
        null,
        3,
        3,
        3,
        null,
        4,
        4,
        null,
        5,
        5,
        5,
        5,
        null,
        6,
        6,
        6,
        6,
        null,
        7,
        7,
        7,
        null,
        8,
        8,
        8,
        8,
        9,
        9
      ]);
    });

    test('fragment', () {
      expect(fragment(expand('12345')),
          [0, 2, 2, 1, 1, 1, 2, 2, 2, null, null, null, null, null, null]);
    });

    test('part one', () {
      final input = ['2333133121414131402'];
      expect(part1(input), 1928);
    });

    test('part two', () {
      final input = ['2333133121414131402'];
      expect(part2(input), 0);
    });
  });
}
