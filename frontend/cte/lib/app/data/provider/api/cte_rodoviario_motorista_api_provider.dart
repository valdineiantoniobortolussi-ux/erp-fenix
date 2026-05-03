import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioMotoristaApiProvider extends ApiProviderBase {

	Future<List<CteRodoviarioMotoristaModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioMotoristaModel> cteRodoviarioMotoristaModelList = [];

		try {
			handleFilter(filter, '/cte-rodoviario-motorista/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioMotoristaModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteRodoviarioMotoristaModel in cteRodoviarioMotoristaModelJson) {
						cteRodoviarioMotoristaModelList.add(CteRodoviarioMotoristaModel.fromJson(cteRodoviarioMotoristaModel));
					}
					return cteRodoviarioMotoristaModelList;
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

	Future<CteRodoviarioMotoristaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-rodoviario-motorista/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioMotoristaModelJson = json.decode(response.body);
					return CteRodoviarioMotoristaModel.fromJson(cteRodoviarioMotoristaModelJson);		 
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

	Future<CteRodoviarioMotoristaModel?>? insert(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-rodoviario-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioMotoristaModelJson = json.decode(response.body);
					return CteRodoviarioMotoristaModel.fromJson(cteRodoviarioMotoristaModelJson);
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

	Future<CteRodoviarioMotoristaModel?>? update(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-rodoviario-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioMotoristaModelJson = json.decode(response.body);
					return CteRodoviarioMotoristaModel.fromJson(cteRodoviarioMotoristaModelJson);
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
				Uri.tryParse('$endpoint/cte-rodoviario-motorista/$pk')!,
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
