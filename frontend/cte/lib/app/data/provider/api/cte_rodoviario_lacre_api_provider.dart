import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioLacreApiProvider extends ApiProviderBase {

	Future<List<CteRodoviarioLacreModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioLacreModel> cteRodoviarioLacreModelList = [];

		try {
			handleFilter(filter, '/cte-rodoviario-lacre/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioLacreModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteRodoviarioLacreModel in cteRodoviarioLacreModelJson) {
						cteRodoviarioLacreModelList.add(CteRodoviarioLacreModel.fromJson(cteRodoviarioLacreModel));
					}
					return cteRodoviarioLacreModelList;
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

	Future<CteRodoviarioLacreModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-rodoviario-lacre/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioLacreModelJson = json.decode(response.body);
					return CteRodoviarioLacreModel.fromJson(cteRodoviarioLacreModelJson);		 
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

	Future<CteRodoviarioLacreModel?>? insert(CteRodoviarioLacreModel cteRodoviarioLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-rodoviario-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioLacreModelJson = json.decode(response.body);
					return CteRodoviarioLacreModel.fromJson(cteRodoviarioLacreModelJson);
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

	Future<CteRodoviarioLacreModel?>? update(CteRodoviarioLacreModel cteRodoviarioLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-rodoviario-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioLacreModelJson = json.decode(response.body);
					return CteRodoviarioLacreModel.fromJson(cteRodoviarioLacreModelJson);
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
				Uri.tryParse('$endpoint/cte-rodoviario-lacre/$pk')!,
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
