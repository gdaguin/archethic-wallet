// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_informations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenInformationsAdapter extends TypeAdapter<TokenInformations> {
  @override
  final int typeId = 9;

  @override
  TokenInformations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenInformations(
      address: fields[0] as String?,
      name: fields[1] as String?,
      supply: fields[2] as int?,
      type: fields[3] as String?,
      symbol: fields[4] as String?,
      tokenId: fields[5] as int?,
      tokenInformationsProperties:
          (fields[6] as List?)?.cast<TokenInformationsProperty>(),
    );
  }

  @override
  void write(BinaryWriter writer, TokenInformations obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.supply)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.symbol)
      ..writeByte(5)
      ..write(obj.tokenId)
      ..writeByte(6)
      ..write(obj.tokenInformationsProperties);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInformationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}