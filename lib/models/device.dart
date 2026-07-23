import 'package:isar/isar.dart';

part 'device.g.dart';

@collection
class Device {
  Id id = Isar.autoIncrement;

  late String name;

  /// e.g. "Billiards", "PingPong", "PS1", "PS2"
  late String type;

  /// Hourly rate for single player
  late double hourlyRate;

  /// Hourly rate for multiplayer (if applicable)
  double? multiplayerHourlyRate;

  /// Fixed price per match (if applicable)
  double? matchRate;

  /// Fixed price per match for multiplayer (if applicable)
  double? multiplayerMatchRate;

  /// Is it currently active
  bool isActive = true;
}
