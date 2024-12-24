import 'dart:io';
import 'dart:math';

class Gate {
  List<String> inputNodes;
  String outputNode;
  String operation;

  bool? outputValue;

  Gate(this.inputNodes, this.outputNode, this.operation);

  /// returns true if changed, false otherwise
  bool? evaluate(Map<String, bool?> nodeValues) {
    if (outputValue != null) {
      return false;
    }

    if (inputNodes.every((element) => nodeValues[element] != null)) {
      switch (operation) {
        case 'AND':
          outputValue =
              nodeValues[inputNodes[0]]! && nodeValues[inputNodes[1]]!;
          break;
        case 'OR':
          outputValue =
              nodeValues[inputNodes[0]]! || nodeValues[inputNodes[1]]!;
          break;
        case 'XOR':
          outputValue = nodeValues[inputNodes[0]]! == nodeValues[inputNodes[1]]!
              ? false
              : true;
          break;
      }
      nodeValues[outputNode] = outputValue;

      return true;

      // print(
      //     '${inputNodes[0]} (${nodeValues[inputNodes[0]]}) $operation ${inputNodes[1]} (${nodeValues[inputNodes[1]]}) -> ${outputNode} ($outputValue)');
    }

    return false;
  }
}

Future<void> main() async {
  final input = await File('./Day24/day24_input.txt').readAsLines();
  print(part1(input));
  print(part2(input));
}

int part1(List<String> input) {
  Map<String, bool?> nodeValues = {};

  var i = 0;
  for (i = 0; i < input.length; i++) {
    if (input[i].isEmpty) {
      break;
    }

    var parts = input[i].split(': ');

    nodeValues[parts[0]] = parts[1] == '1' ? true : false;
  }

  int highZ = 0;
  List<String> zNodes = [];

  var regex = RegExp(
      r"(?<node1>[a-z0-9]{3}) (?<operation>(AND)|(OR)|(XOR)) (?<node2>[a-z0-9]{3}) -> (?<node3>[a-z0-9]{3})");
  final gates = <Gate>[];
  for (; i < input.length; i++) {
    var match = regex.firstMatch(input[i]);
    if (match != null) {
      var node1 = match.namedGroup('node1')!;
      var operation = match.namedGroup('operation')!;
      var node2 = match.namedGroup('node2')!;
      var node3 = match.namedGroup('node3')!;

      if (!nodeValues.containsKey(node1)) {
        nodeValues[node1] = null;
      }

      if (!nodeValues.containsKey(node2)) {
        nodeValues[node2] = null;
      }

      if (!nodeValues.containsKey(node3)) {
        nodeValues[node3] = null;
      }

      if (node3.startsWith('z')) {
        final zVal = int.parse(node3.substring(1));
        highZ = max(highZ, zVal);

        zNodes.add(node3);
      }

      gates.add(Gate(
        [node1, node2],
        node3,
        operation,
      ));
    }
  }

  while (zNodes.any((zKey) => nodeValues[zKey] == null)) {
    var changed = false;
    for (var gate in gates) {
      if (gate.evaluate(nodeValues) != null) {
        changed = true;
      }
    }
    if (!changed) {
      break;
    }
  }

  var outputStr = '';
  for (var n = 0; n <= highZ; n++) {
    var key = 'z${n.toString().padLeft(2, '0')}';
    if (nodeValues[key] == null) {
      outputStr += '0';
      continue;
    }

    print('$key: ${nodeValues[key]}');

    outputStr = (nodeValues[key]! ? '1' : '0') + outputStr;
  }

  return int.parse(outputStr, radix: 2);
}

int part2(List<String> input) {
  return 0;
}
