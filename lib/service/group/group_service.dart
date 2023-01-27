
import 'firebase_group_provider.dart';
import 'group_provider.dart';

class GroupService implements GroupProvider {
  final GroupProvider provider;
  const GroupService(this.provider);

  factory GroupService.firebase() => GroupService(FirebaseGroupProvider());

}
