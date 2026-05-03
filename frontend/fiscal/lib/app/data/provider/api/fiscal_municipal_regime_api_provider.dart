import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalMunicipalRegimeApiProvider extends ApiProviderBase {

	Future<List<FiscalMunicipalRegimeModel>?> getList({Filter? filter}) async {
		List<FiscalMunicipalRegimeModel> fiscalMunicipalRegimeModelList = [];

		try {
			handleFilter(filter, '/fiscal-municipal-regime/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalMunicipalRegimeModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalMunicipalRegimeModel in fiscalMunicipalRegimeModelJson) {
						fiscalMunicipalRegimeModelList.add(FiscalMunicipalRegimeModel.fromJson(fiscalMunicipalRegimeModel));
					}
					return fiscalMunicipalRegimeModelList;
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

	Future<FiscalMunicipalRegimeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-municipal-regime/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalMunicipalRegimeModelJson = json.decode(response.body);
					return FiscalMunicipalRegimeModel.fromJson(fiscalMunicipalRegimeModelJson);		 
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

	Future<FiscalMunicipalRegimeModel?>? insert(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-municipal-regime')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalMunicipalRegimeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalMunicipalRegimeModelJson = json.decode(response.body);
					return FiscalMunicipalRegimeModel.fromJson(fiscalMunicipalRegimeModelJson);
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

	Future<FiscalMunicipalRegimeModel?>? update(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-municipal-regime')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalMunicipalRegimeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalMunicipalRegimeModelJson = json.decode(response.body);
					return FiscalMunicipalRegimeModel.fromJson(fiscalMunicipalRegimeModelJson);
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
				Uri.tryParse('$endpoint/fiscal-municipal-regime/$pk')!,
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
