import 'dart:convert';
import 'package:vendas/app/data/provider/api/api_provider_base.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalModeloApiProvider extends ApiProviderBase {

	Future<List<NotaFiscalModeloModel>?> getList({Filter? filter}) async {
		List<NotaFiscalModeloModel> notaFiscalModeloModelList = [];

		try {
			handleFilter(filter, '/nota-fiscal-modelo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalModeloModelJson = json.decode(response.body) as List<dynamic>;
					for (var notaFiscalModeloModel in notaFiscalModeloModelJson) {
						notaFiscalModeloModelList.add(NotaFiscalModeloModel.fromJson(notaFiscalModeloModel));
					}
					return notaFiscalModeloModelList;
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

	Future<NotaFiscalModeloModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nota-fiscal-modelo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalModeloModelJson = json.decode(response.body);
					return NotaFiscalModeloModel.fromJson(notaFiscalModeloModelJson);		 
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

	Future<NotaFiscalModeloModel?>? insert(NotaFiscalModeloModel notaFiscalModeloModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nota-fiscal-modelo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: notaFiscalModeloModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalModeloModelJson = json.decode(response.body);
					return NotaFiscalModeloModel.fromJson(notaFiscalModeloModelJson);
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

	Future<NotaFiscalModeloModel?>? update(NotaFiscalModeloModel notaFiscalModeloModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nota-fiscal-modelo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: notaFiscalModeloModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var notaFiscalModeloModelJson = json.decode(response.body);
					return NotaFiscalModeloModel.fromJson(notaFiscalModeloModelJson);
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
				Uri.tryParse('$endpoint/nota-fiscal-modelo/$pk')!,
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
