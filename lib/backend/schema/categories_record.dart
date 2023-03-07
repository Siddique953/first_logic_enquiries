import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'categories_record.g.dart';

abstract class CategoriesRecord
    implements Built<CategoriesRecord, CategoriesRecordBuilder> {
  static Serializer<CategoriesRecord> get serializer =>
      _$categoriesRecordSerializer;

  @nullable
  String get categoryId;

  @nullable
  String get imageUrl;

  @nullable
  String get name;

  @nullable
  BuiltList<String> get search;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
    ..categoryId = ''
    ..imageUrl = ''
    ..name = ''
    ..search = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('category');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CategoriesRecord._();
  factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
      _$CategoriesRecord;
}

Map<String, dynamic> createCategoriesRecordData({
  String categoryId,
  String imageUrl,
  String name,
  ListBuilder<String> search,
}) =>
    serializers.serializeWith(
        CategoriesRecord.serializer,
        CategoriesRecord((c) => c
          ..categoryId = categoryId
          ..imageUrl = imageUrl
          ..name = name
          ..search = search));


