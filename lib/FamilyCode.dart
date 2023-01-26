import 'package:uuid/uuid.dart';

void main() {
  print(generateUuid());
}

String generateUuid() {
  var uuid = const Uuid();
  var FamilyCode = uuid.v4();
  return FamilyCode.substring(30); // uuid was long -> slice
}
