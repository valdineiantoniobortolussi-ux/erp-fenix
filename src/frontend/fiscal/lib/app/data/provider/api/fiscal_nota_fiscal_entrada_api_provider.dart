import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalEntradaApiProvider extends ApiProviderBase {

	Future<List<FiscalNotaFiscalEntradaModel>?> getList({Filter? filter}) async {
		List<FiscalNotaFiscalEntradaModel> fiscalNotaFiscalEntradaModelList = [];

		try {
			handleFilter(filter, '/fiscal-nota-fiscal-entrada/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalEntradaModelJson = json.decode(response.body) as List<dynamic>;
					for (var fiscalNotaFiscalEntradaModel in fiscalNotaFiscalEntradaModelJson) {
						fiscalNotaFiscalEntradaModelList.add(FiscalNotaFiscalEntradaModel.fromJson(fiscalNotaFiscalEntradaModel));
					}
					return fiscalNotaFiscalEntradaModelList;
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

	Future<FiscalNotaFiscalEntradaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fiscal-nota-fiscal-entrada/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalEntradaModelJson = json.decode(response.body);
					return FiscalNotaFiscalEntradaModel.fromJson(fiscalNotaFiscalEntradaModelJson);		 
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

	Future<FiscalNotaFiscalEntradaModel?>? insert(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-entrada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalNotaFiscalEntradaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalEntradaModelJson = json.decode(response.body);
					return FiscalNotaFiscalEntradaModel.fromJson(fiscalNotaFiscalEntradaModelJson);
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

	Future<FiscalNotaFiscalEntradaModel?>? update(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-entrada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: fiscalNotaFiscalEntradaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var fiscalNotaFiscalEntradaModelJson = json.decode(response.body);
					return FiscalNotaFiscalEntradaModel.fromJson(fiscalNotaFiscalEntradaModelJson);
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
				Uri.tryParse('$endpoint/fiscal-nota-fiscal-entrada/$pk')!,
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
