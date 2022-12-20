
import 'package:hive/hive.dart';
part 'assets_type.g.dart';

@HiveType(typeId: 1)
class Asset {
  @HiveField(0)
  String httpUrl;
  @HiveField(1)
  String localUrl;
  @HiveField(2)
  bool isDownloaded;
  @HiveField(3)
  String filename;

  Asset({required this.httpUrl, required this.localUrl, required this.isDownloaded,required this.filename});
}