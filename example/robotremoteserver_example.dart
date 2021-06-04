import 'package:robotremoteserver_dart/robotremoteserver.dart';
import 'spacecraft.dart';

void main() async {
  final rrs = RobotRemoteServer(Spacecraft("voyager", DateTime(1977, 9, 5)));
  rrs.serve();
}
