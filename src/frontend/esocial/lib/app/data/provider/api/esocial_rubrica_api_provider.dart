import 'dart:convert';
import 'package:esocial/app/data/provider/api/api_provider_base.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialRubricaApiProvider extends ApiProviderBase {

	Future<List<EsocialRubricaModel>?> getList({Filter? filter}) async {
		List<EsocialRubricaModel> esocialRubricaModelList = [];

		try {
			handleFilter(filter, '/esocial-rubrica/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialRubricaModelJson = json.decode(response.body) as List<dynamic>;
					for (var esocialRubricaModel in esocialRubricaModelJson) {
						esocialRubricaModelList.add(EsocialRubricaModel.fromJson(esocialRubricaModel));
					}
					return esocialRubricaModelList;
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

	Future<EsocialRubricaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/esocial-rubrica/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialRubricaModelJson = json.decode(response.body);
					return EsocialRubricaModel.fromJson(esocialRubricaModelJson);		 
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

	Future<EsocialRubricaModel?>? insert(EsocialRubricaModel esocialRubricaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/esocial-rubrica')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialRubricaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialRubricaModelJson = json.decode(response.body);
					return EsocialRubricaModel.fromJson(esocialRubricaModelJson);
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

	Future<EsocialRubricaModel?>? update(EsocialRubricaModel esocialRubricaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/esocial-rubrica')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialRubricaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialRubricaModelJson = json.decode(response.body);
					return EsocialRubricaModel.fromJson(esocialRubricaModelJson);
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
				Uri.tryParse('$endpoint/esocial-rubrica/$pk')!,
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
