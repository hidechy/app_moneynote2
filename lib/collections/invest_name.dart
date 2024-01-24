import 'package:isar/isar.dart';

part 'invest_name.g.dart';

@collection
class InvestName {
  Id id = Isar.autoIncrement;

  late String investName;

  late String investType;
}
