import 'package:uuid/uuid.dart';

void main() {
  var uuid = const Uuid();
  var v4 = uuid.v4();
  var Familycode = v4.substring(31); // -> 5자리 코드 자도 생성
}
