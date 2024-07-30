import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class NewsProvider with ChangeNotifier {
  static const String apiKey = '41170309382f41c8963e29168b45dd2a';
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines';

  Album? _albumBusiness;
  bool _isLoading = false;
  String? _errorMessage;

  Album? get albumBusiness => _albumBusiness;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBusiness(String countryCode) async {
    _isLoading = true;
    notifyListeners();

    final url = '$baseUrl?country=$countryCode&category=business&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    try{
      if (response.statusCode == 200) {
        _albumBusiness = Album.fromJson(jsonDecode(response.body));
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load Business News';
      }
    }on FormatException catch (_) {
      _errorMessage = 'Data conversion error';
    } on SocketException catch (_) {
      _errorMessage = 'Please check your internet connection';

    } on PlatformException catch (e) {
      _errorMessage = '${e.message}';

    }
    catch (e) {
      _errorMessage = '$e';
    }finally{
      _isLoading = false;
      notifyListeners();
    }


  }
}
