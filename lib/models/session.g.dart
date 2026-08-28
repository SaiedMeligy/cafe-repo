// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlaySessionCollection on Isar {
  IsarCollection<PlaySession> get playSessions => this.collection();
}

const PlaySessionSchema = CollectionSchema(
  name: r'PlaySession',
  id: 187889808848330,
  properties: {
    r'endTime': PropertySchema(
      id: 0,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'expectedDurationMinutes': PropertySchema(
      id: 1,
      name: r'expectedDurationMinutes',
      type: IsarType.long,
    ),
    r'grandTotal': PropertySchema(
      id: 2,
      name: r'grandTotal',
      type: IsarType.double,
    ),
    r'isCompleted': PropertySchema(
      id: 3,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isMatchMode': PropertySchema(
      id: 4,
      name: r'isMatchMode',
      type: IsarType.bool,
    ),
    r'isMultiplayer': PropertySchema(
      id: 5,
      name: r'isMultiplayer',
      type: IsarType.bool,
    ),
    r'matchesCount': PropertySchema(
      id: 6,
      name: r'matchesCount',
      type: IsarType.long,
    ),
    r'orders': PropertySchema(
      id: 7,
      name: r'orders',
      type: IsarType.objectList,
      target: r'SessionOrder',
    ),
    r'paymentStatus': PropertySchema(
      id: 8,
      name: r'paymentStatus',
      type: IsarType.string,
    ),
    r'startTime': PropertySchema(
      id: 9,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'totalOrdersPrice': PropertySchema(
      id: 10,
      name: r'totalOrdersPrice',
      type: IsarType.double,
    ),
    r'totalTimePrice': PropertySchema(
      id: 11,
      name: r'totalTimePrice',
      type: IsarType.double,
    )
  },
  estimateSize: _playSessionEstimateSize,
  serialize: _playSessionSerialize,
  deserialize: _playSessionDeserialize,
  deserializeProp: _playSessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'device': LinkSchema(
      id: 980062768778685,
      name: r'device',
      target: r'Device',
      single: true,
    )
  },
  embeddedSchemas: {r'SessionOrder': SessionOrderSchema},
  getId: _playSessionGetId,
  getLinks: _playSessionGetLinks,
  attach: _playSessionAttach,
  version: '3.1.0+1',
);

int _playSessionEstimateSize(
  PlaySession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.orders.length * 3;
  {
    final offsets = allOffsets[SessionOrder]!;
    for (var i = 0; i < object.orders.length; i++) {
      final value = object.orders[i];
      bytesCount += SessionOrderSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.paymentStatus.length * 3;
  return bytesCount;
}

void _playSessionSerialize(
  PlaySession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endTime);
  writer.writeLong(offsets[1], object.expectedDurationMinutes);
  writer.writeDouble(offsets[2], object.grandTotal);
  writer.writeBool(offsets[3], object.isCompleted);
  writer.writeBool(offsets[4], object.isMatchMode);
  writer.writeBool(offsets[5], object.isMultiplayer);
  writer.writeLong(offsets[6], object.matchesCount);
  writer.writeObjectList<SessionOrder>(
    offsets[7],
    allOffsets,
    SessionOrderSchema.serialize,
    object.orders,
  );
  writer.writeString(offsets[8], object.paymentStatus);
  writer.writeDateTime(offsets[9], object.startTime);
  writer.writeDouble(offsets[10], object.totalOrdersPrice);
  writer.writeDouble(offsets[11], object.totalTimePrice);
}

PlaySession _playSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlaySession();
  object.endTime = reader.readDateTimeOrNull(offsets[0]);
  object.expectedDurationMinutes = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[3]);
  object.isMatchMode = reader.readBool(offsets[4]);
  object.isMultiplayer = reader.readBool(offsets[5]);
  object.matchesCount = reader.readLong(offsets[6]);
  object.orders = reader.readObjectList<SessionOrder>(
        offsets[7],
        SessionOrderSchema.deserialize,
        allOffsets,
        SessionOrder(),
      ) ??
      [];
  object.paymentStatus = reader.readString(offsets[8]);
  object.startTime = reader.readDateTime(offsets[9]);
  object.totalOrdersPrice = reader.readDouble(offsets[10]);
  object.totalTimePrice = reader.readDouble(offsets[11]);
  return object;
}

P _playSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readObjectList<SessionOrder>(
            offset,
            SessionOrderSchema.deserialize,
            allOffsets,
            SessionOrder(),
          ) ??
          []) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playSessionGetId(PlaySession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playSessionGetLinks(PlaySession object) {
  return [object.device];
}

void _playSessionAttach(
    IsarCollection<dynamic> col, Id id, PlaySession object) {
  object.id = id;
  object.device.attach(col, col.isar.collection<Device>(), r'device', id);
}

extension PlaySessionQueryWhereSort
    on QueryBuilder<PlaySession, PlaySession, QWhere> {
  QueryBuilder<PlaySession, PlaySession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlaySessionQueryWhere
    on QueryBuilder<PlaySession, PlaySession, QWhereClause> {
  QueryBuilder<PlaySession, PlaySession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PlaySession, PlaySession, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterWhereClause> idBetween(
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

extension PlaySessionQueryFilter
    on QueryBuilder<PlaySession, PlaySession, QFilterCondition> {
  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> endTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      endTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedDurationMinutes',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedDurationMinutes',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      expectedDurationMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedDurationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      grandTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grandTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      grandTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grandTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      grandTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grandTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      grandTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grandTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      isMatchModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMatchMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      isMultiplayerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMultiplayer',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      matchesCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      matchesCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      matchesCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      matchesCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchesCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      ordersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      paymentStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalOrdersPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOrdersPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalOrdersPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOrdersPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalOrdersPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOrdersPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalOrdersPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOrdersPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalTimePriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalTimePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalTimePriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalTimePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalTimePriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalTimePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition>
      totalTimePriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalTimePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PlaySessionQueryObject
    on QueryBuilder<PlaySession, PlaySession, QFilterCondition> {
  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> ordersElement(
      FilterQuery<SessionOrder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'orders');
    });
  }
}

extension PlaySessionQueryLinks
    on QueryBuilder<PlaySession, PlaySession, QFilterCondition> {
  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> device(
      FilterQuery<Device> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'device');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterFilterCondition> deviceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'device', 0, true, 0, true);
    });
  }
}

extension PlaySessionQuerySortBy
    on QueryBuilder<PlaySession, PlaySession, QSortBy> {
  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByExpectedDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByExpectedDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByGrandTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grandTotal', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByGrandTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grandTotal', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByIsMatchMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatchMode', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByIsMatchModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatchMode', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByIsMultiplayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMultiplayer', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByIsMultiplayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMultiplayer', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByMatchesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchesCount', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByMatchesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchesCount', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByPaymentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByPaymentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByTotalOrdersPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersPrice', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByTotalOrdersPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersPrice', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> sortByTotalTimePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimePrice', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      sortByTotalTimePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimePrice', Sort.desc);
    });
  }
}

extension PlaySessionQuerySortThenBy
    on QueryBuilder<PlaySession, PlaySession, QSortThenBy> {
  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByExpectedDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByExpectedDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByGrandTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grandTotal', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByGrandTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grandTotal', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIsMatchMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatchMode', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIsMatchModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMatchMode', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByIsMultiplayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMultiplayer', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByIsMultiplayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMultiplayer', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByMatchesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchesCount', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByMatchesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchesCount', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByPaymentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByPaymentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByTotalOrdersPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersPrice', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByTotalOrdersPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrdersPrice', Sort.desc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy> thenByTotalTimePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimePrice', Sort.asc);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QAfterSortBy>
      thenByTotalTimePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTimePrice', Sort.desc);
    });
  }
}

extension PlaySessionQueryWhereDistinct
    on QueryBuilder<PlaySession, PlaySession, QDistinct> {
  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct>
      distinctByExpectedDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedDurationMinutes');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByGrandTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grandTotal');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByIsMatchMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMatchMode');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByIsMultiplayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMultiplayer');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByMatchesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchesCount');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByPaymentStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct>
      distinctByTotalOrdersPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOrdersPrice');
    });
  }

  QueryBuilder<PlaySession, PlaySession, QDistinct> distinctByTotalTimePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTimePrice');
    });
  }
}

extension PlaySessionQueryProperty
    on QueryBuilder<PlaySession, PlaySession, QQueryProperty> {
  QueryBuilder<PlaySession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlaySession, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<PlaySession, int?, QQueryOperations>
      expectedDurationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedDurationMinutes');
    });
  }

  QueryBuilder<PlaySession, double, QQueryOperations> grandTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grandTotal');
    });
  }

  QueryBuilder<PlaySession, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<PlaySession, bool, QQueryOperations> isMatchModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMatchMode');
    });
  }

  QueryBuilder<PlaySession, bool, QQueryOperations> isMultiplayerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMultiplayer');
    });
  }

  QueryBuilder<PlaySession, int, QQueryOperations> matchesCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchesCount');
    });
  }

  QueryBuilder<PlaySession, List<SessionOrder>, QQueryOperations>
      ordersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orders');
    });
  }

  QueryBuilder<PlaySession, String, QQueryOperations> paymentStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentStatus');
    });
  }

  QueryBuilder<PlaySession, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<PlaySession, double, QQueryOperations>
      totalOrdersPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOrdersPrice');
    });
  }

  QueryBuilder<PlaySession, double, QQueryOperations> totalTimePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTimePrice');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SessionOrderSchema = Schema(
  name: r'SessionOrder',
  id: 393008589478785,
  properties: {
    r'costPrice': PropertySchema(
      id: 0,
      name: r'costPrice',
      type: IsarType.double,
    ),
    r'price': PropertySchema(
      id: 1,
      name: r'price',
      type: IsarType.double,
    ),
    r'productId': PropertySchema(
      id: 2,
      name: r'productId',
      type: IsarType.long,
    ),
    r'productName': PropertySchema(
      id: 3,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 4,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'total': PropertySchema(
      id: 5,
      name: r'total',
      type: IsarType.double,
    ),
    r'totalCost': PropertySchema(
      id: 6,
      name: r'totalCost',
      type: IsarType.double,
    )
  },
  estimateSize: _sessionOrderEstimateSize,
  serialize: _sessionOrderSerialize,
  deserialize: _sessionOrderDeserialize,
  deserializeProp: _sessionOrderDeserializeProp,
);

int _sessionOrderEstimateSize(
  SessionOrder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.productName.length * 3;
  return bytesCount;
}

void _sessionOrderSerialize(
  SessionOrder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.costPrice);
  writer.writeDouble(offsets[1], object.price);
  writer.writeLong(offsets[2], object.productId);
  writer.writeString(offsets[3], object.productName);
  writer.writeLong(offsets[4], object.quantity);
  writer.writeDouble(offsets[5], object.total);
  writer.writeDouble(offsets[6], object.totalCost);
}

SessionOrder _sessionOrderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SessionOrder();
  object.costPrice = reader.readDouble(offsets[0]);
  object.price = reader.readDouble(offsets[1]);
  object.productId = reader.readLong(offsets[2]);
  object.productName = reader.readString(offsets[3]);
  object.quantity = reader.readLong(offsets[4]);
  return object;
}

P _sessionOrderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SessionOrderQueryFilter
    on QueryBuilder<SessionOrder, SessionOrder, QFilterCondition> {
  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      costPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      costPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      costPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      costPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> totalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      totalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> totalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition> totalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      totalCostEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      totalCostGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      totalCostLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SessionOrder, SessionOrder, QAfterFilterCondition>
      totalCostBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension SessionOrderQueryObject
    on QueryBuilder<SessionOrder, SessionOrder, QFilterCondition> {}
