enum InvestType {
  goldInvestment,
  stockInvestment,
  exchangeTradedFund,
  investmentTrust,
  foreignCurrencyDeposits,
  nationalDebt,
  foreignExchangeMarginTrading,
  cryptoAssets,
  realEstateInvestment,
  corporateBondsForIndividuals,
  futuresTrading,
  optionsTrading,
  moneyManagementFund,
  moneyReserveFund
}

extension InvestTypeExtension on InvestType {
  String get japanName {
    switch (this) {
      case InvestType.goldInvestment:
        return '金（きん）';
      case InvestType.stockInvestment:
        return '株式投資';
      case InvestType.exchangeTradedFund:
        return 'ETF（上場投資信託）';
      case InvestType.investmentTrust:
        return '投資信託';
      case InvestType.foreignCurrencyDeposits:
        return '外貨預金';
      case InvestType.nationalDebt:
        return '国債';
      case InvestType.foreignExchangeMarginTrading:
        return 'FX（外国為替証拠金取引）';
      case InvestType.cryptoAssets:
        return '暗号資産（仮想通貨）';
      case InvestType.realEstateInvestment:
        return '不動産投資';
      case InvestType.corporateBondsForIndividuals:
        return '個人向け社債';
      case InvestType.futuresTrading:
        return '先物取引';
      case InvestType.optionsTrading:
        return 'オプション取引';
      case InvestType.moneyManagementFund:
        return 'MMF';
      case InvestType.moneyReserveFund:
        return 'MRF';
    }
  }
}
