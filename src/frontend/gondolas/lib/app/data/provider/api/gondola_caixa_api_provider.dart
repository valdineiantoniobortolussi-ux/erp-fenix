import 'dart:convert';
import 'package:gondolas/app/data/provider/api/api_provider_base.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaCaixaApiProvider extends ApiProviderBase {

	Future<List<GondolaCaixaModel>?> getList({Filter? filter}) async {
		List<GondolaCaixaModel> gondolaCaixaModelList = [];

		try {
			handleFilter(filter, '/gondola-caixa/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaCaixaModelJson = json.decode(response.body) as List<dynamic>;
					for (var gondolaCaixaModel in gondolaCaixaModelJson) {
						gondolaCaixaModelList.add(GondolaCaixaModel.fromJson(gondolaCaixaModel));
					}
					return gondolaCaixaModelList;
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

	Future<GondolaCaixaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/gondola-caixa/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaCaixaModelJson = json.decode(response.body);
					return GondolaCaixaModel.fromJson(gondolaCaixaModelJson);		 
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

	Future<GondolaCaixaModel?>? insert(GondolaCaixaModel gondolaCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/gondola-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaCaixaModelJson = json.decode(response.body);
					return GondolaCaixaModel.fromJson(gondolaCaixaModelJson);
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

	Future<GondolaCaixaModel?>? update(GondolaCaixaModel gondolaCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/gondola-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaCaixaModelJson = json.decode(response.body);
					return GondolaCaixaModel.fromJson(gondolaCaixaModelJson);
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
				Uri.tryParse('$endpoint/gondola-caixa/$pk')!,
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
