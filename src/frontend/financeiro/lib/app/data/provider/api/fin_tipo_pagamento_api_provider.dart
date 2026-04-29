import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinTipoPagamentoApiProvider extends ApiProviderBase {

	Future<List<FinTipoPagamentoModel>?> getList({Filter? filter}) async {
		List<FinTipoPagamentoModel> finTipoPagamentoModelList = [];

		try {
			handleFilter(filter, '/fin-tipo-pagamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finTipoPagamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finTipoPagamentoModel in finTipoPagamentoModelJson) {
						finTipoPagamentoModelList.add(FinTipoPagamentoModel.fromJson(finTipoPagamentoModel));
					}
					return finTipoPagamentoModelList;
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

	Future<FinTipoPagamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-tipo-pagamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finTipoPagamentoModelJson = json.decode(response.body);
					return FinTipoPagamentoModel.fromJson(finTipoPagamentoModelJson);		 
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

	Future<FinTipoPagamentoModel?>? insert(FinTipoPagamentoModel finTipoPagamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-tipo-pagamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finTipoPagamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finTipoPagamentoModelJson = json.decode(response.body);
					return FinTipoPagamentoModel.fromJson(finTipoPagamentoModelJson);
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

	Future<FinTipoPagamentoModel?>? update(FinTipoPagamentoModel finTipoPagamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-tipo-pagamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finTipoPagamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finTipoPagamentoModelJson = json.decode(response.body);
					return FinTipoPagamentoModel.fromJson(finTipoPagamentoModelJson);
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
				Uri.tryParse('$endpoint/fin-tipo-pagamento/$pk')!,
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
