import 'package:robotremoteserver/robotremoteserver.dart';
import 'spacecraft.dart';

void main() async {
  final rrs = RobotRemoteServer(Spacecraft("voyager", DateTime(1977, 9, 5)));
  rrs.serve();
}
