import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalEstadualRegimeApiProvider extends ApiProviderBase {

	Future<List<FiscalEstadualRegimeModel>?> getList({Filter? filter}) async {
		List<FiscalEstadualRegimeModel> fiscalEstadualRegimeModelList = [];

		try {
			handleFilter(filter, '/fiscal-estadual-regime/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualRegimeModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalEstadualRegimeModel in fiscalEstadualRegimeModelJson) {
						fiscalEstadualRegimeModelList.add(FiscalEstadualRegimeModel.fromJson(fiscalEstadualRegimeModel));
					}
					return fiscalEstadualRegimeModelList;
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

	Future<FiscalEstadualRegimeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-estadual-regime/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualRegimeModelJson = json.decode(response.body);
					return FiscalEstadualRegimeModel.fromJson(fiscalEstadualRegimeModelJson);		 
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

	Future<FiscalEstadualRegimeModel?>? insert(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-estadual-regime')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalEstadualRegimeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualRegimeModelJson = json.decode(response.body);
					return FiscalEstadualRegimeModel.fromJson(fiscalEstadualRegimeModelJson);
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

	Future<FiscalEstadualRegimeModel?>? update(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-estadual-regime')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalEstadualRegimeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalEstadualRegimeModelJson = json.decode(response.body);
					return FiscalEstadualRegimeModel.fromJson(fiscalEstadualRegimeModelJson);
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
				Uri.tryParse('$endpoint/fiscal-estadual-regime/$pk')!,
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
