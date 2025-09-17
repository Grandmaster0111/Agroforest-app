import '../models/crop.dart';

class CropService {
  static List<Crop> getCrops() {
    return [
      Crop(name: 'Wheat', minMoisture: 40, maxMoisture: 60),
      Crop(name: 'Corn', minMoisture: 50, maxMoisture: 70),
      Crop(name: 'Rice', minMoisture: 60, maxMoisture: 80),
      Crop(name: 'Soybean', minMoisture: 45, maxMoisture: 65),
    ];
  }
}
