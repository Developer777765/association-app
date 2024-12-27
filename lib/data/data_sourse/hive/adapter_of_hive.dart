import 'package:hive/hive.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final String? name = reader.readString();
    final String? sex = reader.readString();
    final String? dob = reader.readString();
    final String? address = reader.readString();
    final String? phno = reader.readString();
    final String? spousePhNo = reader.readString();
    final String? fatherPhNo = reader.readString();
    final String? email = reader.readString();
    final bool? maritalStatus = reader.readBool();

    return UserProfile(
        name: name,
        sex: sex,
        dob: dob,
        address: address,
        phno: phno,
        spousePhNo: spousePhNo,
        fatherPhNo: fatherPhNo,
        email: email,
        maritalStatus: maritalStatus);
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeString(obj.name!);
    writer.writeString(obj.sex!);
    writer.writeString(obj.dob!);
    writer.writeString(obj.address!);
    writer.writeString(obj.phno!);
    writer.writeString(obj.spousePhNo!);
    writer.writeString(obj.fatherPhNo!);
    writer.writeString(obj.email!);
    writer.writeBool(obj.maritalStatus!);
  }
}
