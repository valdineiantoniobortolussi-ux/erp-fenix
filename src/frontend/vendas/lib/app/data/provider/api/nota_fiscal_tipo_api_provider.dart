import 'dart:convert';
import 'package:vendas/app/data/provider/api/api_provider_base.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalTipoApiProvider extends ApiProviderBase {

	Future<List<NotaFiscalTipoModel>?> getList({Filter? filter}) async {
		List<NotaFiscalTipoModel> notaFiscalTipoModelList = [];

		try {
			handleFilter(filter, '/nota-fiscal-tipo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalTipoModelJson = json.decode(response.body) as List<dynamic>;
					for (var notaFiscalTipoModel in notaFiscalTipoModelJson) {
						notaFiscalTipoModelList.add(NotaFiscalTipoModel.fromJson(notaFiscalTipoModel));
					}
					return notaFiscalTipoModelList;
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

	Future<NotaFiscalTipoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nota-fiscal-tipo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalTipoModelJson = json.decode(response.body);
					return NotaFiscalTipoModel.fromJson(notaFiscalTipoModelJson);		 
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

	Future<NotaFiscalTipoModel?>? insert(NotaFiscalTipoModel notaFiscalTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nota-fiscal-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: notaFiscalTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalTipoModelJson = json.decode(response.body);
					return NotaFiscalTipoModel.fromJson(notaFiscalTipoModelJson);
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

	Future<NotaFiscalTipoModel?>? update(NotaFiscalTipoModel notaFiscalTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nota-fiscal-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: notaFiscalTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalTipoModelJson = json.decode(response.body);
					return NotaFiscalTipoModel.fromJson(notaFiscalTipoModelJson);
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
				Uri.tryParse('$endpoint/nota-fiscal-tipo/$pk')!,
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
