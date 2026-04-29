import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalEstadualPorteApiProvider extends ApiProviderBase {

	Future<List<FiscalEstadualPorteModel>?> getList({Filter? filter}) async {
		List<FiscalEstadualPorteModel> fiscalEstadualPorteModelList = [];

		try {
			handleFilter(filter, '/fiscal-estadual-porte/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualPorteModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalEstadualPorteModel in fiscalEstadualPorteModelJson) {
						fiscalEstadualPorteModelList.add(FiscalEstadualPorteModel.fromJson(fiscalEstadualPorteModel));
					}
					return fiscalEstadualPorteModelList;
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

	Future<FiscalEstadualPorteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-estadual-porte/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualPorteModelJson = json.decode(response.body);
					return FiscalEstadualPorteModel.fromJson(fiscalEstadualPorteModelJson);		 
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

	Future<FiscalEstadualPorteModel?>? insert(FiscalEstadualPorteModel fiscalEstadualPorteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-estadual-porte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalEstadualPorteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualPorteModelJson = json.decode(response.body);
					return FiscalEstadualPorteModel.fromJson(fiscalEstadualPorteModelJson);
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

	Future<FiscalEstadualPorteModel?>? update(FiscalEstadualPorteModel fiscalEstadualPorteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-estadual-porte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalEstadualPorteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualPorteModelJson = json.decode(response.body);
					return FiscalEstadualPorteModel.fromJson(fiscalEstadualPorteModelJson);
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
				Uri.tryParse('$endpoint/fiscal-estadual-porte/$pk')!,
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
