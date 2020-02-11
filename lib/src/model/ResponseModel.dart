import 'package:flutter_app/src/model/ErrorViewModel.dart';

class ResponseModel {
  dynamic successData;
  bool success;
  ErrorViewModel errorViewModel;
  ResponseModel({this.successData, this.success, this.errorViewModel});
}
