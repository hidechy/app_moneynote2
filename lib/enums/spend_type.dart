enum SpendType {
  food,
  room,
  transportation,
  payment,
  credit,
  playing,
  hobby,
  entertainment,
  miscellaneous,
  education,
  equipment,
  clothing,
  medical,
  beauty,
  communication,
  insurance,
  lifeline,
  aid,
  investment,
  commission,
  tax,
  pension,
  nationalPension,
  healthInsurance,
  interest,
  unknown,
  plus,
}

extension SpendTypeExtension on SpendType {
  // ignore: unused_element
  String? get japanName {
    switch (this) {
      case SpendType.food:
        return '食費';
      case SpendType.room:
        return '住居費';
      case SpendType.transportation:
        return '交通費';
      case SpendType.payment:
        return '支払い';
      case SpendType.credit:
        return 'クレジット';
      case SpendType.playing:
        return '遊興費';
      case SpendType.hobby:
        return '趣味';
      case SpendType.entertainment:
        return '交際費';
      case SpendType.miscellaneous:
        return '雑費';
      case SpendType.education:
        return '教育費';
      case SpendType.equipment:
        return '機材費';
      case SpendType.clothing:
        return '被服費';
      case SpendType.medical:
        return '医療費';
      case SpendType.beauty:
        return '美容費';
      case SpendType.communication:
        return '通信費';
      case SpendType.insurance:
        return '保険料';
      case SpendType.lifeline:
        return '水道光熱費';
      case SpendType.aid:
        return '共済代';
      case SpendType.investment:
        return '投資';
      case SpendType.commission:
        return '手数料';
      case SpendType.tax:
        return '税金';
      case SpendType.pension:
        return '年金';
      case SpendType.nationalPension:
        return '国民年金基金';
      case SpendType.healthInsurance:
        return '健康保険代';
      case SpendType.interest:
        return '利息';
      case SpendType.unknown:
        return '不明';
      case SpendType.plus:
        return 'プラス';
    }
  }
}
