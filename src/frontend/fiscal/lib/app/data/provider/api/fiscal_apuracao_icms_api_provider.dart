import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalApuracaoIcmsApiProvider extends ApiProviderBase {

	Future<List<FiscalApuracaoIcmsModel>?> getList({Filter? filter}) async {
		List<FiscalApuracaoIcmsModel> fiscalApuracaoIcmsModelList = [];

		try {
			handleFilter(filter, '/fiscal-apuracao-icms/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalApuracaoIcmsModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalApuracaoIcmsModel in fiscalApuracaoIcmsModelJson) {
						fiscalApuracaoIcmsModelList.add(FiscalApuracaoIcmsModel.fromJson(fiscalApuracaoIcmsModel));
					}
					return fiscalApuracaoIcmsModelList;
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

	Future<FiscalApuracaoIcmsModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-apuracao-icms/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalApuracaoIcmsModelJson = json.decode(response.body);
					return FiscalApuracaoIcmsModel.fromJson(fiscalApuracaoIcmsModelJson);		 
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

	Future<FiscalApuracaoIcmsModel?>? insert(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-apuracao-icms')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalApuracaoIcmsModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalApuracaoIcmsModelJson = json.decode(response.body);
					return FiscalApuracaoIcmsModel.fromJson(fiscalApuracaoIcmsModelJson);
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

	Future<FiscalApuracaoIcmsModel?>? update(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-apuracao-icms')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalApuracaoIcmsModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalApuracaoIcmsModelJson = json.decode(response.body);
					return FiscalApuracaoIcmsModel.fromJson(fiscalApuracaoIcmsModelJson);
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
				Uri.tryParse('$endpoint/fiscal-apuracao-icms/$pk')!,
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
