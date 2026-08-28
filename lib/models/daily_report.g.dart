// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyReportCollection on Isar {
  IsarCollection<DailyReport> get dailyReports => this.collection();
}

const DailyReportSchema = CollectionSchema(
  name: r'DailyReport',
  id: 253067269952573,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'totalIncome': PropertySchema(
      id: 1,
      name: r'totalIncome',
      type: IsarType.double,
    ),
    r'totalOrdersCost': PropertySchema(
      id: 2,
      name: r'totalOrdersCost',
      type: IsarType.double,
    ),
    r'totalOrdersIncome': PropertySchema(
      id: 3,
      name: r'totalOrdersIncome',
      type: IsarType.double,
    ),
    r'totalProfit': PropertySchema(
      id: 4,
      name: r'totalProfit',
      type: IsarType.double,
    ),
    r'totalSessions': PropertySchema(
      id: 5,
      name: r'totalSessions',
      type: IsarType.long,
    ),
    r'totalTimeIncome': PropertySchema(
      id: 6,
      name: r'totalTimeIncome',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyReportEstimateSize,
  serialize: _dailyReportSerialize,
  deserialize: _dailyReportDeserialize,
  deserializeProp: _dailyReportDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dailyReportGetId,
  getLinks: _dailyReportGetLinks,
  attach: _dailyReportAttach,
  version: '3.1.0+1',
);

int _dailyReportEstimateSize(
  DailyReport object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyReportSerialize(
  DailyReport object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.totalIncome);
  writer.writeDouble(offsets[2], object.totalOrdersCost);
  writer.writeDouble(offsets[3], object.totalOrdersIncome);
  writer.writeDouble(offsets[4], object.totalProfit);
  writer.writeLong(offsets[5], object.totalSessions);
  writer.writeDouble(offsets[6], object.totalTimeIncome);
}

DailyReport _dailyReportDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyReport();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.totalOrdersCost = reader.readDouble(offsets[2]);
  object.totalOrdersIncome = reader.readDouble(offsets[3]);
  object.totalSessions = reader.readLong(offsets[5]);
  object.totalTimeIncome = reader.readDouble(offsets[6]);
  return object;
}

P _dailyReportDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyReportGetId(DailyReport object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyReportGetLinks(DailyReport object) {
  return [];
}

void _dailyReportAttach(
    IsarCollection<dynamic> col, Id id, DailyReport object) {
  object.id = id;
}

extension DailyReportQueryWhereSort
    on QueryBuilder<DailyReport, DailyReport, QWhere> {
  QueryBuilder<DailyReport, DailyReport, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyReportQueryWhere
    on QueryBuilder<DailyReport, DailyReport, QWhereClause> {
  QueryBuilder<DailyReport, DailyReport, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<DailyReport, DailyReport, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterWhereClause> idBetween(
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

extension DailyReportQueryFilter
    on QueryBuilder<DailyReport, DailyReport, QFilterCondition> {
  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalIncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalIncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalIncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalIncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersCostEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOrdersCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersCostGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOrdersCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersCostLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOrdersCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersCostBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOrdersCost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersIncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOrdersIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersIncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOrdersIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersIncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOrdersIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalOrdersIncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOrdersIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalProfitEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalProfitGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalProfitLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalProfitBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProfit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalSessionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalSessionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalSessionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalSessionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalTimeIncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalTimeIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalTimeIncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalTimeIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalTimeIncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalTimeIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterFilterCondition>
      totalTimeIncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalTimeIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyReportQueryObject
    on QueryBuilder<DailyReport, DailyReport, QFilterCondition> {}

extension DailyReportQueryLinks
    on QueryBuilder<DailyReport, DailyReport, QFilterCondition> {}

extension DailyReportQuerySortBy
    on QueryBuilder<DailyReport, DailyReport, QSortBy> {
  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncome', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalOrdersCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersCost', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      sortByTotalOrdersCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersCost', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      sortByTotalOrdersIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      sortByTotalOrdersIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersIncome', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProfit', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalProfitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProfit', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      sortByTotalSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> sortByTotalTimeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimeIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      sortByTotalTimeIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimeIncome', Sort.desc);
    });
  }
}

extension DailyReportQuerySortThenBy
    on QueryBuilder<DailyReport, DailyReport, QSortThenBy> {
  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncome', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalOrdersCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersCost', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      thenByTotalOrdersCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersCost', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      thenByTotalOrdersIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      thenByTotalOrdersIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersIncome', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProfit', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalProfitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProfit', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      thenByTotalSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.desc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy> thenByTotalTimeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimeIncome', Sort.asc);
    });
  }

  QueryBuilder<DailyReport, DailyReport, QAfterSortBy>
      thenByTotalTimeIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimeIncome', Sort.desc);
    });
  }
}

extension DailyReportQueryWhereDistinct
    on QueryBuilder<DailyReport, DailyReport, QDistinct> {
  QueryBuilder<DailyReport, DailyReport, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct> distinctByTotalIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalIncome');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct>
      distinctByTotalOrdersCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOrdersCost');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct>
      distinctByTotalOrdersIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOrdersIncome');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct> distinctByTotalProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalProfit');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct> distinctByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSessions');
    });
  }

  QueryBuilder<DailyReport, DailyReport, QDistinct>
      distinctByTotalTimeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTimeIncome');
    });
  }
}

extension DailyReportQueryProperty
    on QueryBuilder<DailyReport, DailyReport, QQueryProperty> {
  QueryBuilder<DailyReport, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyReport, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyReport, double, QQueryOperations> totalIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalIncome');
    });
  }

  QueryBuilder<DailyReport, double, QQueryOperations>
      totalOrdersCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOrdersCost');
    });
  }

  QueryBuilder<DailyReport, double, QQueryOperations>
      totalOrdersIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOrdersIncome');
    });
  }

  QueryBuilder<DailyReport, double, QQueryOperations> totalProfitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalProfit');
    });
  }

  QueryBuilder<DailyReport, int, QQueryOperations> totalSessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSessions');
    });
  }

  QueryBuilder<DailyReport, double, QQueryOperations>
      totalTimeIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTimeIncome');
    });
  }
}
