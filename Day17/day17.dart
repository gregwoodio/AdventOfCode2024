import 'dart:io';
import 'dart:math';

Future<void> main() async {
  final input = await File('./Day17/day17_input.txt').readAsLines();
  print(part1(input));
  print(part2(input));
}

String part1(List<String> input) {
  return run(input);
}

String part2(List<String> input) {
  return 'part 2';
}

String run(List<String> input) {
  int a = int.parse(input[0].split(': ')[1]);
  int b = int.parse(input[1].split(': ')[1]);
  int c = int.parse(input[2].split(': ')[1]);

  var program =
      input[4].substring(8).split(',').map((e) => int.parse(e)).toList();
  int ip = 0;
  List<int> output = [];

  while (ip < program.length) {
    int operand = program[ip + 1];
    int comboOperand = operand;
    if (comboOperand == 4) {
      comboOperand = a;
    } else if (comboOperand == 5) {
      comboOperand = b;
    } else if (comboOperand == 6) {
      comboOperand = c;
    }

    switch (program[ip]) {
      case 0: // adv - a division
        a = a ~/ pow(2, comboOperand);
        break;

      case 1: // bxl - b bitwise xor
        b = b ^ operand;
        break;

      case 2: // bst - combo operand mod 8, store in b
        b = comboOperand % 8;
        break;

      case 3: // jnz - jump if a is not zero
        if (a != 0) {
          ip = operand;
          continue;
        }

      case 4: // bxc - b bitwise XOR c
        b = b ^ c;
        break;

      case 5: // out
        output.add(comboOperand % 8);
        break;

      case 6: // bdv - b division
        b = a ~/ pow(2, comboOperand);
        break;

      case 7: // cdv - c division
        c = a ~/ pow(2, comboOperand);
        break;
    }

    ip += 2;
  }

  return output.join(',');
}
