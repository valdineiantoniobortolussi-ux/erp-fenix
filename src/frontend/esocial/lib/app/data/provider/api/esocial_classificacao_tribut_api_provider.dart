import 'dart:convert';
import 'package:esocial/app/data/provider/api/api_provider_base.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialClassificacaoTributApiProvider extends ApiProviderBase {

	Future<List<EsocialClassificacaoTributModel>?> getList({Filter? filter}) async {
		List<EsocialClassificacaoTributModel> esocialClassificacaoTributModelList = [];

		try {
			handleFilter(filter, '/esocial-classificacao-tribut/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialClassificacaoTributModelJson = json.decode(response.body) as List<dynamic>;
					for (var esocialClassificacaoTributModel in esocialClassificacaoTributModelJson) {
						esocialClassificacaoTributModelList.add(EsocialClassificacaoTributModel.fromJson(esocialClassificacaoTributModel));
					}
					return esocialClassificacaoTributModelList;
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

	Future<EsocialClassificacaoTributModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/esocial-classificacao-tribut/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialClassificacaoTributModelJson = json.decode(response.body);
					return EsocialClassificacaoTributModel.fromJson(esocialClassificacaoTributModelJson);		 
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

	Future<EsocialClassificacaoTributModel?>? insert(EsocialClassificacaoTributModel esocialClassificacaoTributModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/esocial-classificacao-tribut')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialClassificacaoTributModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialClassificacaoTributModelJson = json.decode(response.body);
					return EsocialClassificacaoTributModel.fromJson(esocialClassificacaoTributModelJson);
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

	Future<EsocialClassificacaoTributModel?>? update(EsocialClassificacaoTributModel esocialClassificacaoTributModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/esocial-classificacao-tribut')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialClassificacaoTributModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialClassificacaoTributModelJson = json.decode(response.body);
					return EsocialClassificacaoTributModel.fromJson(esocialClassificacaoTributModelJson);
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
				Uri.tryParse('$endpoint/esocial-classificacao-tribut/$pk')!,
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
