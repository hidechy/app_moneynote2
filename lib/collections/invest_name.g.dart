// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invest_name.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInvestNameCollection on Isar {
  IsarCollection<InvestName> get investNames => this.collection();
}

const InvestNameSchema = CollectionSchema(
  name: r'InvestName',
  id: -7031451711582071805,
  properties: {
    r'investName': PropertySchema(
      id: 0,
      name: r'investName',
      type: IsarType.string,
    ),
    r'investType': PropertySchema(
      id: 1,
      name: r'investType',
      type: IsarType.string,
    )
  },
  estimateSize: _investNameEstimateSize,
  serialize: _investNameSerialize,
  deserialize: _investNameDeserialize,
  deserializeProp: _investNameDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _investNameGetId,
  getLinks: _investNameGetLinks,
  attach: _investNameAttach,
  version: '3.1.0+1',
);

int _investNameEstimateSize(
  InvestName object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.investName.length * 3;
  bytesCount += 3 + object.investType.length * 3;
  return bytesCount;
}

void _investNameSerialize(
  InvestName object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.investName);
  writer.writeString(offsets[1], object.investType);
}

InvestName _investNameDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InvestName();
  object.id = id;
  object.investName = reader.readString(offsets[0]);
  object.investType = reader.readString(offsets[1]);
  return object;
}

P _investNameDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _investNameGetId(InvestName object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _investNameGetLinks(InvestName object) {
  return [];
}

void _investNameAttach(IsarCollection<dynamic> col, Id id, InvestName object) {
  object.id = id;
}

extension InvestNameQueryWhereSort
    on QueryBuilder<InvestName, InvestName, QWhere> {
  QueryBuilder<InvestName, InvestName, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InvestNameQueryWhere
    on QueryBuilder<InvestName, InvestName, QWhereClause> {
  QueryBuilder<InvestName, InvestName, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InvestNameQueryFilter
    on QueryBuilder<InvestName, InvestName, QFilterCondition> {
  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'investName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'investName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'investName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'investName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'investType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'investType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition> investTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'investType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investType',
        value: '',
      ));
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterFilterCondition>
      investTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'investType',
        value: '',
      ));
    });
  }
}

extension InvestNameQueryObject
    on QueryBuilder<InvestName, InvestName, QFilterCondition> {}

extension InvestNameQueryLinks
    on QueryBuilder<InvestName, InvestName, QFilterCondition> {}

extension InvestNameQuerySortBy
    on QueryBuilder<InvestName, InvestName, QSortBy> {
  QueryBuilder<InvestName, InvestName, QAfterSortBy> sortByInvestName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investName', Sort.asc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> sortByInvestNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investName', Sort.desc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> sortByInvestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investType', Sort.asc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> sortByInvestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investType', Sort.desc);
    });
  }
}

extension InvestNameQuerySortThenBy
    on QueryBuilder<InvestName, InvestName, QSortThenBy> {
  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenByInvestName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investName', Sort.asc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenByInvestNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investName', Sort.desc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenByInvestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investType', Sort.asc);
    });
  }

  QueryBuilder<InvestName, InvestName, QAfterSortBy> thenByInvestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investType', Sort.desc);
    });
  }
}

extension InvestNameQueryWhereDistinct
    on QueryBuilder<InvestName, InvestName, QDistinct> {
  QueryBuilder<InvestName, InvestName, QDistinct> distinctByInvestName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'investName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestName, InvestName, QDistinct> distinctByInvestType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'investType', caseSensitive: caseSensitive);
    });
  }
}

extension InvestNameQueryProperty
    on QueryBuilder<InvestName, InvestName, QQueryProperty> {
  QueryBuilder<InvestName, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InvestName, String, QQueryOperations> investNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'investName');
    });
  }

  QueryBuilder<InvestName, String, QQueryOperations> investTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'investType');
    });
  }
}
