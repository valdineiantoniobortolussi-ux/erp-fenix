import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaHistoricoSalarialApiProvider extends ApiProviderBase {

	Future<List<FolhaHistoricoSalarialModel>?> getList({Filter? filter}) async {
		List<FolhaHistoricoSalarialModel> folhaHistoricoSalarialModelList = [];

		try {
			handleFilter(filter, '/folha-historico-salarial/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaHistoricoSalarialModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaHistoricoSalarialModel in folhaHistoricoSalarialModelJson) {
						folhaHistoricoSalarialModelList.add(FolhaHistoricoSalarialModel.fromJson(folhaHistoricoSalarialModel));
					}
					return folhaHistoricoSalarialModelList;
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

	Future<FolhaHistoricoSalarialModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-historico-salarial/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaHistoricoSalarialModelJson = json.decode(response.body);
					return FolhaHistoricoSalarialModel.fromJson(folhaHistoricoSalarialModelJson);		 
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

	Future<FolhaHistoricoSalarialModel?>? insert(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-historico-salarial')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaHistoricoSalarialModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaHistoricoSalarialModelJson = json.decode(response.body);
					return FolhaHistoricoSalarialModel.fromJson(folhaHistoricoSalarialModelJson);
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

	Future<FolhaHistoricoSalarialModel?>? update(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-historico-salarial')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaHistoricoSalarialModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaHistoricoSalarialModelJson = json.decode(response.body);
					return FolhaHistoricoSalarialModel.fromJson(folhaHistoricoSalarialModelJson);
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
				Uri.tryParse('$endpoint/folha-historico-salarial/$pk')!,
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
