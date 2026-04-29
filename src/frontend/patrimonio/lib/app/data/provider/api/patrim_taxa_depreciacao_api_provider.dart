import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTaxaDepreciacaoApiProvider extends ApiProviderBase {

	Future<List<PatrimTaxaDepreciacaoModel>?> getList({Filter? filter}) async {
		List<PatrimTaxaDepreciacaoModel> patrimTaxaDepreciacaoModelList = [];

		try {
			handleFilter(filter, '/patrim-taxa-depreciacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTaxaDepreciacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimTaxaDepreciacaoModel in patrimTaxaDepreciacaoModelJson) {
						patrimTaxaDepreciacaoModelList.add(PatrimTaxaDepreciacaoModel.fromJson(patrimTaxaDepreciacaoModel));
					}
					return patrimTaxaDepreciacaoModelList;
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

	Future<PatrimTaxaDepreciacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-taxa-depreciacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTaxaDepreciacaoModelJson = json.decode(response.body);
					return PatrimTaxaDepreciacaoModel.fromJson(patrimTaxaDepreciacaoModelJson);		 
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

	Future<PatrimTaxaDepreciacaoModel?>? insert(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-taxa-depreciacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTaxaDepreciacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTaxaDepreciacaoModelJson = json.decode(response.body);
					return PatrimTaxaDepreciacaoModel.fromJson(patrimTaxaDepreciacaoModelJson);
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

	Future<PatrimTaxaDepreciacaoModel?>? update(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-taxa-depreciacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTaxaDepreciacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTaxaDepreciacaoModelJson = json.decode(response.body);
					return PatrimTaxaDepreciacaoModel.fromJson(patrimTaxaDepreciacaoModelJson);
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
				Uri.tryParse('$endpoint/patrim-taxa-depreciacao/$pk')!,
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
