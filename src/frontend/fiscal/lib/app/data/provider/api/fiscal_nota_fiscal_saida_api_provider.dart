import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalSaidaApiProvider extends ApiProviderBase {

	Future<List<FiscalNotaFiscalSaidaModel>?> getList({Filter? filter}) async {
		List<FiscalNotaFiscalSaidaModel> fiscalNotaFiscalSaidaModelList = [];

		try {
			handleFilter(filter, '/fiscal-nota-fiscal-saida/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalSaidaModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalNotaFiscalSaidaModel in fiscalNotaFiscalSaidaModelJson) {
						fiscalNotaFiscalSaidaModelList.add(FiscalNotaFiscalSaidaModel.fromJson(fiscalNotaFiscalSaidaModel));
					}
					return fiscalNotaFiscalSaidaModelList;
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

	Future<FiscalNotaFiscalSaidaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-nota-fiscal-saida/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalSaidaModelJson = json.decode(response.body);
					return FiscalNotaFiscalSaidaModel.fromJson(fiscalNotaFiscalSaidaModelJson);		 
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

	Future<FiscalNotaFiscalSaidaModel?>? insert(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-saida')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalNotaFiscalSaidaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalSaidaModelJson = json.decode(response.body);
					return FiscalNotaFiscalSaidaModel.fromJson(fiscalNotaFiscalSaidaModelJson);
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

	Future<FiscalNotaFiscalSaidaModel?>? update(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-saida')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalNotaFiscalSaidaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalSaidaModelJson = json.decode(response.body);
					return FiscalNotaFiscalSaidaModel.fromJson(fiscalNotaFiscalSaidaModelJson);
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
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-saida/$pk')!,
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
