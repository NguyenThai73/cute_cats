// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:cat_lover/model/image.model.dart';
import 'package:http/http.dart' as http;

import '../model/breeds.model.dart';

String host = "https://api.thecatapi.com/v1";
String key = "live_LbCYCHWeYqN62bjDWfJwIjjLpnJByHFHrp17AeuiRopBGIaGwjOY5OV3NCtUw9hq";

class CatController {
  Future<List<ImageModel>> getListImage({required int page, String? breedIds}) async {
    var responseGet = await getList<List<ImageModel>>(
      headers: {"x-api-key": key},
      route: breedIds == null
          ? "images/search?page=$page&limit=30&has_breeds=true&include_breeds=true&include_categories=true"
          : "images/search?page=$page&limit=30&breed_ids=$breedIds&has_breeds=true&include_breeds=true&include_categories=true",
      onConvert: (json) {
        List<ImageModel> list = [];
        for (var element in json) {
          ImageModel imageModelItem = ImageModel.fromMap(element);
          list.add(imageModelItem);
        }
        return list;
      },
    );

    return responseGet ?? [];
  }

  Future<ImageModel?> getImage({required String imageId}) async {
    var responseGet = await get<ImageModel>(
      headers: {"x-api-key": key},
      route: "images/$imageId",
      onConvert: (json) {
        return ImageModel.fromMap(json ?? {});
      },
    );
    return responseGet;
  }

  Future<List<BreedsModel>> getListBreeds({required int page, String? breedName}) async {
    var responseGet = await getList<List<BreedsModel>>(
      headers: {"x-api-key": key},
      route: breedName == null ? "breeds?limit=18&page=$page" : "breeds/search?q=$breedName",
      onConvert: (json) {
        List<BreedsModel> list = [];
        for (var element in json) {
          BreedsModel imageModelItem = BreedsModel.fromMap(element);
          list.add(imageModelItem);
        }
        return list;
      },
    );

    return responseGet ?? [];
  }

  Future<BreedsModel?> getBreeds({required String breedId}) async {
    var responseGet = await get<BreedsModel>(
      headers: {"x-api-key": key},
      route: "breeds/$breedId",
      onConvert: (json) {
        return BreedsModel.fromMap(json ?? {});
      },
    );

    return responseGet;
  }
}

Future<T?> get<T>({required String route, T Function(Map<String, dynamic>?)? onConvert, Map<String, String>? headers}) async {
  var client = http.Client();
  print("url get: $host/$route");
  print("headers get: $headers");
  try {
    var response = await client.get(Uri.parse('$host/$route'), headers: headers).timeout(const Duration(seconds: 99));
    print("response: ${response.statusCode}");
    print("response: ${response.body}");
    if (onConvert == null) return response.statusCode as T;
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return onConvert(decodedResponse);
  } catch (e) {
    print('Error ${route} $e');
  } finally {
    client.close();
  }
  return null;
}

Future<T?> getList<T>({required String route, T Function(List<dynamic>)? onConvert, Map<String, String>? headers}) async {
  var client = http.Client();
  print("url get: $host/$route");
  print("headers get: $headers");
  try {
    var response = await client.get(Uri.parse('$host/$route'), headers: headers).timeout(const Duration(seconds: 99));
    print("response: ${response.statusCode}");
    print("response: ${response.body}");
    if (onConvert == null) return response.statusCode as T;
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return onConvert(decodedResponse);
  } catch (e) {
    print('Error ${route} $e');
  } finally {
    client.close();
  }
  return null;
}
