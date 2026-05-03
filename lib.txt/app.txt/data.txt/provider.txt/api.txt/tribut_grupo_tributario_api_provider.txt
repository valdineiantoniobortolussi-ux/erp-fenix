import 'dart:convert';
import 'package:tributacao/app/data/provider/api/api_provider_base.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributGrupoTributarioApiProvider extends ApiProviderBase {

	Future<List<TributGrupoTributarioModel>?> getList({Filter? filter}) async {
		List<TributGrupoTributarioModel> tributGrupoTributarioModelList = [];

		try {
			handleFilter(filter, '/tribut-grupo-tributario/');                                    
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributGrupoTributarioModelJson = json.decode(response.body) as List<dynamic>;
					for (var tributGrupoTributarioModel in tributGrupoTributarioModelJson) {
						tributGrupoTributarioModelList.add(TributGrupoTributarioModel.fromJson(tributGrupoTributarioModel));
					}
					return tributGrupoTributarioModelList;
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

	Future<TributGrupoTributarioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tribut-grupo-tributario/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributGrupoTributarioModelJson = json.decode(response.body);
					return TributGrupoTributarioModel.fromJson(tributGrupoTributarioModelJson);		 
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

	Future<TributGrupoTributarioModel?>? insert(TributGrupoTributarioModel tributGrupoTributarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tribut-grupo-tributario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributGrupoTributarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributGrupoTributarioModelJson = json.decode(response.body);
					return TributGrupoTributarioModel.fromJson(tributGrupoTributarioModelJson);
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

	Future<TributGrupoTributarioModel?>? update(TributGrupoTributarioModel tributGrupoTributarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tribut-grupo-tributario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributGrupoTributarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributGrupoTributarioModelJson = json.decode(response.body);
					return TributGrupoTributarioModel.fromJson(tributGrupoTributarioModelJson);
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
				Uri.tryParse('$endpoint/tribut-grupo-tributario/$pk')!,
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
