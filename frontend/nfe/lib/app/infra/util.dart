import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:nfe/app/infra/constants.dart';

class Util {
  Util._();

  /// remove mask from a string
  static String? removeMask(dynamic value) {
    if (value != null) {
      return value.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// sets the distance between columns in case there is a line break
	static EdgeInsets? distanceBetweenColumnsLineBreak(BuildContext context) { 
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": EdgeInsets.zero,
        "lg": EdgeInsets.zero,
        "md": EdgeInsets.zero,
        "sm": EdgeInsets.zero,
        "": const EdgeInsets.only(top: 5.0, bottom: 10.0),
      },
      context: context,
    );
  }  

  static String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      String dataFormatada = formatter.format(date);
      return dataFormatada;
    }
  }
 
  static DateTime? stringToDate(String? date) {
    if (date == null || date == '') {
      return null;
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      return formatter.parseStrict(date);
    }
  }

  static String moneyFormat(dynamic value) {
    final formatter = NumberFormat.simpleCurrency(locale: Get.locale.toString());
    final result = formatter.format(value);
    return result;
  }

  static String decimalFormat(dynamic value) {
    final formatter = NumberFormat.decimalPattern(Get.locale.toString());
    final result = formatter.format(value);
    return result;
  }

  static String stringFormat(dynamic value) {
    return value ?? "";
  }

  static num stringToNumberWithLocale(String value) {
    final formatter = NumberFormat.simpleCurrency(locale: Get.locale.toString());
    value = value.isEmpty ? '0' : value;
    final result = formatter.parse(value);
    return result;    
  }

  static String crypt(String value) {
      // return "\"${Constants.encrypter.encrypt(value, iv: Constants.iv).base64}\""; // TODO: para o servidor C# utilize essa linha e comente a outra
      return Constants.encrypter.encrypt(value, iv: Constants.iv).base64;
  }

  static String decrypt(String value) {
    if (value.substring(0, 1) == "\"") {
      value = value.substring(1, value.length - 1);  
    }
    return Constants.encrypter.decrypt64(value, iv: Constants.iv);
  }    

  static String toJsonString(List<dynamic> driftList) {	 
		String jsonString = "[";
		for (var i = 0; i < driftList.length; i++) {
			jsonString += "{";
			for (var j = 0; j < driftList[i].data.length; j++) {
				String fieldName = driftList[i].data.keys.toList()[j];
				final value = driftList[i].data.values.toList()[j];
				jsonString += '"${fieldName.camelCase}": "$value",';
			}		
			jsonString = jsonString.substring(0, jsonString.length - 1);
			jsonString += "},";
		}
		if (driftList.isNotEmpty) {
			jsonString = jsonString.substring(0, jsonString.length - 1);
		}
		jsonString += "]";
		return jsonString;
	}
}