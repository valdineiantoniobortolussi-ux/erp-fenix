import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInformacaoNfCargaApiProvider extends ApiProviderBase {

	Future<List<CteInformacaoNfCargaModel>?> getList({Filter? filter}) async {
		List<CteInformacaoNfCargaModel> cteInformacaoNfCargaModelList = [];

		try {
			handleFilter(filter, '/cte-informacao-nf-carga/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfCargaModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteInformacaoNfCargaModel in cteInformacaoNfCargaModelJson) {
						cteInformacaoNfCargaModelList.add(CteInformacaoNfCargaModel.fromJson(cteInformacaoNfCargaModel));
					}
					return cteInformacaoNfCargaModelList;
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

	Future<CteInformacaoNfCargaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-informacao-nf-carga/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfCargaModelJson = json.decode(response.body);
					return CteInformacaoNfCargaModel.fromJson(cteInformacaoNfCargaModelJson);		 
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

	Future<CteInformacaoNfCargaModel?>? insert(CteInformacaoNfCargaModel cteInformacaoNfCargaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-informacao-nf-carga')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInformacaoNfCargaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfCargaModelJson = json.decode(response.body);
					return CteInformacaoNfCargaModel.fromJson(cteInformacaoNfCargaModelJson);
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

	Future<CteInformacaoNfCargaModel?>? update(CteInformacaoNfCargaModel cteInformacaoNfCargaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-informacao-nf-carga')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInformacaoNfCargaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfCargaModelJson = json.decode(response.body);
					return CteInformacaoNfCargaModel.fromJson(cteInformacaoNfCargaModelJson);
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
				Uri.tryParse('$endpoint/cte-informacao-nf-carga/$pk')!,
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
