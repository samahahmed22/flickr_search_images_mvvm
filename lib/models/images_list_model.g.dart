// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagesListModelAdapter extends TypeAdapter<ImagesListModel> {
  @override
  final int typeId = 0;

  @override
  ImagesListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagesListModel(
      imagesList: (fields[0] as List)?.cast<dynamic>(),
      imagesPerPage: fields[1] as int,
      currentPage: fields[2] as int,
      totalNumberOfPages: fields[3] as int,
      totalNumberOfImages: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ImagesListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imagesList)
      ..writeByte(1)
      ..write(obj.imagesPerPage)
      ..writeByte(2)
      ..write(obj.currentPage)
      ..writeByte(3)
      ..write(obj.totalNumberOfPages)
      ..writeByte(4)
      ..write(obj.totalNumberOfImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
