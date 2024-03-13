import 'package:furniture_shopping/core/class/crud.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';

class HomeData {
  final Crud crud;

  HomeData(this.crud);

  Future<dynamic> getCategory() async {
    try {
      var response = await crud.getData(AppLink.getCategory);

      return response.fold(
            (error) {
          print("Error: $error");
          throw HomeDataException("Error fetching category data");
        },
            (data) => data,
      );
    } catch (e) {
      print("Exception: $e");
      throw HomeDataException("Exception fetching category data");
    }
  }
  Future<dynamic> getProduct() async {
    try {
      var response = await crud.getData(AppLink.getProducts);

      return response.fold(
            (error) {
          print("Error: $error");
          throw HomeDataException("Error fetching category data");
        },
            (data) => data,
      );
    } catch (e) {
      print("Exception: $e");
      throw HomeDataException("Exception fetching category data");
    }
  }


  Future<dynamic> getSlider() async {
    try {
      var response = await crud.getData(AppLink.getSliders);

      return response.fold(
            (error) {
          print("Error: $error");
          throw HomeDataException("Error fetching slider data");
        },
            (data) => data,
      );
    } catch (e) {
      print("Exception: $e");
      throw HomeDataException("Exception fetching slider data");
    }
  }
}

class HomeDataException implements Exception {
  final String message;

  HomeDataException(this.message);
}
