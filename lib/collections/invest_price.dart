import 'package:isar/isar.dart';

part 'invest_price.g.dart';

@collection
class InvestPrice {
  Id id = Isar.autoIncrement;

  @Index()
  late String date;

  late int investId;

  late int price;
}
