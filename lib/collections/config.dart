import 'package:isar/isar.dart';

part 'config.g.dart';

@collection
class Config {
  Id id = Isar.autoIncrement;

  @Index()
  late String configKey;

  late String configValue;
}
