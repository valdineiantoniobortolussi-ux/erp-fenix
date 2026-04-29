import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioPedagioApiProvider extends ApiProviderBase {

	Future<List<CteRodoviarioPedagioModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioPedagioModel> cteRodoviarioPedagioModelList = [];

		try {
			handleFilter(filter, '/cte-rodoviario-pedagio/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioPedagioModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteRodoviarioPedagioModel in cteRodoviarioPedagioModelJson) {
						cteRodoviarioPedagioModelList.add(CteRodoviarioPedagioModel.fromJson(cteRodoviarioPedagioModel));
					}
					return cteRodoviarioPedagioModelList;
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

	Future<CteRodoviarioPedagioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-rodoviario-pedagio/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioPedagioModelJson = json.decode(response.body);
					return CteRodoviarioPedagioModel.fromJson(cteRodoviarioPedagioModelJson);		 
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

	Future<CteRodoviarioPedagioModel?>? insert(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-rodoviario-pedagio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioPedagioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioPedagioModelJson = json.decode(response.body);
					return CteRodoviarioPedagioModel.fromJson(cteRodoviarioPedagioModelJson);
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

	Future<CteRodoviarioPedagioModel?>? update(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-rodoviario-pedagio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioPedagioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioPedagioModelJson = json.decode(response.body);
					return CteRodoviarioPedagioModel.fromJson(cteRodoviarioPedagioModelJson);
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
				Uri.tryParse('$endpoint/cte-rodoviario-pedagio/$pk')!,
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
