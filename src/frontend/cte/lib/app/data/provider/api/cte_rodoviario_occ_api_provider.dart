import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioOccApiProvider extends ApiProviderBase {

	Future<List<CteRodoviarioOccModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioOccModel> cteRodoviarioOccModelList = [];

		try {
			handleFilter(filter, '/cte-rodoviario-occ/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioOccModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteRodoviarioOccModel in cteRodoviarioOccModelJson) {
						cteRodoviarioOccModelList.add(CteRodoviarioOccModel.fromJson(cteRodoviarioOccModel));
					}
					return cteRodoviarioOccModelList;
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

	Future<CteRodoviarioOccModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-rodoviario-occ/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioOccModelJson = json.decode(response.body);
					return CteRodoviarioOccModel.fromJson(cteRodoviarioOccModelJson);		 
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

	Future<CteRodoviarioOccModel?>? insert(CteRodoviarioOccModel cteRodoviarioOccModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-rodoviario-occ')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioOccModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioOccModelJson = json.decode(response.body);
					return CteRodoviarioOccModel.fromJson(cteRodoviarioOccModelJson);
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

	Future<CteRodoviarioOccModel?>? update(CteRodoviarioOccModel cteRodoviarioOccModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-rodoviario-occ')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioOccModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioOccModelJson = json.decode(response.body);
					return CteRodoviarioOccModel.fromJson(cteRodoviarioOccModelJson);
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
				Uri.tryParse('$endpoint/cte-rodoviario-occ/$pk')!,
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
