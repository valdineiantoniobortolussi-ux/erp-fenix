import 'dart:convert';
import 'package:gondolas/app/data/provider/api/api_provider_base.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaRuaApiProvider extends ApiProviderBase {

	Future<List<GondolaRuaModel>?> getList({Filter? filter}) async {
		List<GondolaRuaModel> gondolaRuaModelList = [];

		try {
			handleFilter(filter, '/gondola-rua/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaRuaModelJson = json.decode(response.body) as List<dynamic>;
					for (var gondolaRuaModel in gondolaRuaModelJson) {
						gondolaRuaModelList.add(GondolaRuaModel.fromJson(gondolaRuaModel));
					}
					return gondolaRuaModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GondolaRuaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/gondola-rua/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaRuaModelJson = json.decode(response.body);
					return GondolaRuaModel.fromJson(gondolaRuaModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaRuaModel?>? insert(GondolaRuaModel gondolaRuaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/gondola-rua')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaRuaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaRuaModelJson = json.decode(response.body);
					return GondolaRuaModel.fromJson(gondolaRuaModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaRuaModel?>? update(GondolaRuaModel gondolaRuaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/gondola-rua')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaRuaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaRuaModelJson = json.decode(response.body);
					return GondolaRuaModel.fromJson(gondolaRuaModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.delete(
				Uri.tryParse('$endpoint/gondola-rua/$pk')!,
				headers: ApiProviderBase.headerRequisition(),
			);

			if (response.statusCode == 200) {
				return true;
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	
}
