import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinLancamentoPagarApiProvider extends ApiProviderBase {

	Future<List<FinLancamentoPagarModel>?> getList({Filter? filter}) async {
		List<FinLancamentoPagarModel> finLancamentoPagarModelList = [];

		try {
			handleFilter(filter, '/fin-lancamento-pagar/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoPagarModelJson = json.decode(response.body) as List<dynamic>;
					for (var finLancamentoPagarModel in finLancamentoPagarModelJson) {
						finLancamentoPagarModelList.add(FinLancamentoPagarModel.fromJson(finLancamentoPagarModel));
					}
					return finLancamentoPagarModelList;
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

	Future<FinLancamentoPagarModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-lancamento-pagar/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoPagarModelJson = json.decode(response.body);
					return FinLancamentoPagarModel.fromJson(finLancamentoPagarModelJson);		 
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

	Future<FinLancamentoPagarModel?>? insert(FinLancamentoPagarModel finLancamentoPagarModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-lancamento-pagar')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finLancamentoPagarModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoPagarModelJson = json.decode(response.body);
					return FinLancamentoPagarModel.fromJson(finLancamentoPagarModelJson);
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

	Future<FinLancamentoPagarModel?>? update(FinLancamentoPagarModel finLancamentoPagarModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-lancamento-pagar')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finLancamentoPagarModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoPagarModelJson = json.decode(response.body);
					return FinLancamentoPagarModel.fromJson(finLancamentoPagarModelJson);
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
				Uri.tryParse('$endpoint/fin-lancamento-pagar/$pk')!,
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
