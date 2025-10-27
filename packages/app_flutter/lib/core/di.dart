import 'dart:io';
import 'package:domain/data/repo.dart';
import 'package:domain/data/storage_service.dart';
import 'package:path_provider/path_provider.dart';

class Locator {
  static Future<VehicleRepository> makeRepo() async {
    final dir = await getApplicationDocumentsDirectory();
    final root = Directory('${dir.path}${Platform.pathSeparator}vehicle_data');
    final storage = StorageService(root);
    final repo = VehicleRepository(storage);
    await repo.load(); 
    return repo;
  }
}
