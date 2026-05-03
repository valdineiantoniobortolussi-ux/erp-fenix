import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteAquaviarioBalsaApiProvider extends ApiProviderBase {

	Future<List<CteAquaviarioBalsaModel>?> getList({Filter? filter}) async {
		List<CteAquaviarioBalsaModel> cteAquaviarioBalsaModelList = [];

		try {
			handleFilter(filter, '/cte-aquaviario-balsa/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteAquaviarioBalsaModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteAquaviarioBalsaModel in cteAquaviarioBalsaModelJson) {
						cteAquaviarioBalsaModelList.add(CteAquaviarioBalsaModel.fromJson(cteAquaviarioBalsaModel));
					}
					return cteAquaviarioBalsaModelList;
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

	Future<CteAquaviarioBalsaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-aquaviario-balsa/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteAquaviarioBalsaModelJson = json.decode(response.body);
					return CteAquaviarioBalsaModel.fromJson(cteAquaviarioBalsaModelJson);		 
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

	Future<CteAquaviarioBalsaModel?>? insert(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-aquaviario-balsa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteAquaviarioBalsaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteAquaviarioBalsaModelJson = json.decode(response.body);
					return CteAquaviarioBalsaModel.fromJson(cteAquaviarioBalsaModelJson);
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

	Future<CteAquaviarioBalsaModel?>? update(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-aquaviario-balsa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteAquaviarioBalsaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteAquaviarioBalsaModelJson = json.decode(response.body);
					return CteAquaviarioBalsaModel.fromJson(cteAquaviarioBalsaModelJson);
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
				Uri.tryParse('$endpoint/cte-aquaviario-balsa/$pk')!,
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
