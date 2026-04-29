import 'dart:convert';
import 'package:sped/app/data/provider/api/api_provider_base.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdContribuicoesApiProvider extends ApiProviderBase {

	Future<List<EfdContribuicoesModel>?> getList({Filter? filter}) async {
		List<EfdContribuicoesModel> efdContribuicoesModelList = [];

		try {
			handleFilter(filter, '/efd-contribuicoes/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdContribuicoesModelJson = json.decode(response.body) as List<dynamic>;
					for (var efdContribuicoesModel in efdContribuicoesModelJson) {
						efdContribuicoesModelList.add(EfdContribuicoesModel.fromJson(efdContribuicoesModel));
					}
					return efdContribuicoesModelList;
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

	Future<EfdContribuicoesModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/efd-contribuicoes/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdContribuicoesModelJson = json.decode(response.body);
					return EfdContribuicoesModel.fromJson(efdContribuicoesModelJson);		 
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

	Future<EfdContribuicoesModel?>? insert(EfdContribuicoesModel efdContribuicoesModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/efd-contribuicoes')!,
				headers: ApiProviderBase.headerRequisition(),
				body: efdContribuicoesModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdContribuicoesModelJson = json.decode(response.body);
					return EfdContribuicoesModel.fromJson(efdContribuicoesModelJson);
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

	Future<EfdContribuicoesModel?>? update(EfdContribuicoesModel efdContribuicoesModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/efd-contribuicoes')!,
				headers: ApiProviderBase.headerRequisition(),
				body: efdContribuicoesModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdContribuicoesModelJson = json.decode(response.body);
					return EfdContribuicoesModel.fromJson(efdContribuicoesModelJson);
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
				Uri.tryParse('$endpoint/efd-contribuicoes/$pk')!,
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
