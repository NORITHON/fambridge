import 'package:uuid/uuid.dart';

void main() {
  var uuid = const Uuid();
  var v4 = uuid.v4();
  var Familycode = v4.substring(31); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
}
