import 'dart:convert';
import 'package:esocial/app/data/provider/api/api_provider_base.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialNaturezaJuridicaApiProvider extends ApiProviderBase {

	Future<List<EsocialNaturezaJuridicaModel>?> getList({Filter? filter}) async {
		List<EsocialNaturezaJuridicaModel> esocialNaturezaJuridicaModelList = [];

		try {
			handleFilter(filter, '/esocial-natureza-juridica/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialNaturezaJuridicaModelJson = json.decode(response.body) as List<dynamic>;
					for (var esocialNaturezaJuridicaModel in esocialNaturezaJuridicaModelJson) {
						esocialNaturezaJuridicaModelList.add(EsocialNaturezaJuridicaModel.fromJson(esocialNaturezaJuridicaModel));
					}
					return esocialNaturezaJuridicaModelList;
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

	Future<EsocialNaturezaJuridicaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/esocial-natureza-juridica/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialNaturezaJuridicaModelJson = json.decode(response.body);
					return EsocialNaturezaJuridicaModel.fromJson(esocialNaturezaJuridicaModelJson);		 
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

	Future<EsocialNaturezaJuridicaModel?>? insert(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/esocial-natureza-juridica')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialNaturezaJuridicaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialNaturezaJuridicaModelJson = json.decode(response.body);
					return EsocialNaturezaJuridicaModel.fromJson(esocialNaturezaJuridicaModelJson);
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

	Future<EsocialNaturezaJuridicaModel?>? update(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/esocial-natureza-juridica')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialNaturezaJuridicaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialNaturezaJuridicaModelJson = json.decode(response.body);
					return EsocialNaturezaJuridicaModel.fromJson(esocialNaturezaJuridicaModelJson);
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
				Uri.tryParse('$endpoint/esocial-natureza-juridica/$pk')!,
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
