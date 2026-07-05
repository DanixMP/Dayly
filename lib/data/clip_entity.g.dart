// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clip_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClipEntityCollection on Isar {
  IsarCollection<ClipEntity> get clipEntitys => this.collection();
}

const ClipEntitySchema = CollectionSchema(
  name: r'ClipEntity',
  id: -7166257342617997838,
  properties: {
    r'dateKey': PropertySchema(id: 0, name: r'dateKey', type: IsarType.string),
    r'durationMs': PropertySchema(
      id: 1,
      name: r'durationMs',
      type: IsarType.long,
    ),
    r'isDeleted': PropertySchema(
      id: 2,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'mood': PropertySchema(id: 3, name: r'mood', type: IsarType.string),
    r'note': PropertySchema(id: 4, name: r'note', type: IsarType.string),
    r'recordedAt': PropertySchema(
      id: 5,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'thumbnailPath': PropertySchema(
      id: 6,
      name: r'thumbnailPath',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(id: 7, name: r'uid', type: IsarType.string),
    r'videoPath': PropertySchema(
      id: 8,
      name: r'videoPath',
      type: IsarType.string,
    ),
  },

  estimateSize: _clipEntityEstimateSize,
  serialize: _clipEntitySerialize,
  deserialize: _clipEntityDeserialize,
  deserializeProp: _clipEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'uid': IndexSchema(
      id: 8193695471701937315,
      name: r'uid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'dateKey': IndexSchema(
      id: 7975223786082927131,
      name: r'dateKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _clipEntityGetId,
  getLinks: _clipEntityGetLinks,
  attach: _clipEntityAttach,
  version: '3.3.2',
);

int _clipEntityEstimateSize(
  ClipEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dateKey.length * 3;
  {
    final value = object.mood;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uid.length * 3;
  {
    final value = object.videoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _clipEntitySerialize(
  ClipEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dateKey);
  writer.writeLong(offsets[1], object.durationMs);
  writer.writeBool(offsets[2], object.isDeleted);
  writer.writeString(offsets[3], object.mood);
  writer.writeString(offsets[4], object.note);
  writer.writeDateTime(offsets[5], object.recordedAt);
  writer.writeString(offsets[6], object.thumbnailPath);
  writer.writeString(offsets[7], object.uid);
  writer.writeString(offsets[8], object.videoPath);
}

ClipEntity _clipEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ClipEntity();
  object.dateKey = reader.readString(offsets[0]);
  object.durationMs = reader.readLong(offsets[1]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[2]);
  object.mood = reader.readStringOrNull(offsets[3]);
  object.note = reader.readStringOrNull(offsets[4]);
  object.recordedAt = reader.readDateTime(offsets[5]);
  object.thumbnailPath = reader.readStringOrNull(offsets[6]);
  object.uid = reader.readString(offsets[7]);
  object.videoPath = reader.readStringOrNull(offsets[8]);
  return object;
}

P _clipEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clipEntityGetId(ClipEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clipEntityGetLinks(ClipEntity object) {
  return [];
}

void _clipEntityAttach(IsarCollection<dynamic> col, Id id, ClipEntity object) {
  object.id = id;
}

extension ClipEntityByIndex on IsarCollection<ClipEntity> {
  Future<ClipEntity?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  ClipEntity? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<ClipEntity?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<ClipEntity?> getAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uid', values);
  }

  Future<int> deleteAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uid', values);
  }

  int deleteAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uid', values);
  }

  Future<Id> putByUid(ClipEntity object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(ClipEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<ClipEntity> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<ClipEntity> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension ClipEntityQueryWhereSort
    on QueryBuilder<ClipEntity, ClipEntity, QWhere> {
  QueryBuilder<ClipEntity, ClipEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClipEntityQueryWhere
    on QueryBuilder<ClipEntity, ClipEntity, QWhereClause> {
  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> uidEqualTo(
    String uid,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [uid]),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> uidNotEqualTo(
    String uid,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [],
                upper: [uid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [uid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [uid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [],
                upper: [uid],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> dateKeyEqualTo(
    String dateKey,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'dateKey', value: [dateKey]),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterWhereClause> dateKeyNotEqualTo(
    String dateKey,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dateKey',
                lower: [],
                upper: [dateKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dateKey',
                lower: [dateKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dateKey',
                lower: [dateKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dateKey',
                lower: [],
                upper: [dateKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ClipEntityQueryFilter
    on QueryBuilder<ClipEntity, ClipEntity, QFilterCondition> {
  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  dateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dateKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dateKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dateKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> dateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateKey', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  dateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dateKey', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> durationMsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'durationMs', value: value),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  durationMsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'durationMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  durationMsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'durationMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> durationMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'durationMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> isDeletedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDeleted', value: value),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mood'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mood'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mood',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mood',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mood',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mood', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> moodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mood', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'note'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'note'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'note',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'note',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> recordedAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recordedAt', value: value),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  recordedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  recordedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recordedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'thumbnailPath'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'thumbnailPath'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'thumbnailPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'thumbnailPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'thumbnailPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'thumbnailPath', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  thumbnailPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'thumbnailPath', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'videoPath'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'videoPath'),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'videoPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'videoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition> videoPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'videoPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'videoPath', value: ''),
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterFilterCondition>
  videoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'videoPath', value: ''),
      );
    });
  }
}

extension ClipEntityQueryObject
    on QueryBuilder<ClipEntity, ClipEntity, QFilterCondition> {}

extension ClipEntityQueryLinks
    on QueryBuilder<ClipEntity, ClipEntity, QFilterCondition> {}

extension ClipEntityQuerySortBy
    on QueryBuilder<ClipEntity, ClipEntity, QSortBy> {
  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByThumbnailPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailPath', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByThumbnailPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailPath', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByVideoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoPath', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> sortByVideoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoPath', Sort.desc);
    });
  }
}

extension ClipEntityQuerySortThenBy
    on QueryBuilder<ClipEntity, ClipEntity, QSortThenBy> {
  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByThumbnailPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailPath', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByThumbnailPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailPath', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByVideoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoPath', Sort.asc);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QAfterSortBy> thenByVideoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoPath', Sort.desc);
    });
  }
}

extension ClipEntityQueryWhereDistinct
    on QueryBuilder<ClipEntity, ClipEntity, QDistinct> {
  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByDateKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMs');
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByMood({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mood', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByNote({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByThumbnailPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'thumbnailPath',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClipEntity, ClipEntity, QDistinct> distinctByVideoPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'videoPath', caseSensitive: caseSensitive);
    });
  }
}

extension ClipEntityQueryProperty
    on QueryBuilder<ClipEntity, ClipEntity, QQueryProperty> {
  QueryBuilder<ClipEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ClipEntity, String, QQueryOperations> dateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateKey');
    });
  }

  QueryBuilder<ClipEntity, int, QQueryOperations> durationMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMs');
    });
  }

  QueryBuilder<ClipEntity, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<ClipEntity, String?, QQueryOperations> moodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mood');
    });
  }

  QueryBuilder<ClipEntity, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<ClipEntity, DateTime, QQueryOperations> recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<ClipEntity, String?, QQueryOperations> thumbnailPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailPath');
    });
  }

  QueryBuilder<ClipEntity, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<ClipEntity, String?, QQueryOperations> videoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videoPath');
    });
  }
}
