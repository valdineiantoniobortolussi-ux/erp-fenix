import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeRecebidoApiProvider extends ApiProviderBase {

	Future<List<FinChequeRecebidoModel>?> getList({Filter? filter}) async {
		List<FinChequeRecebidoModel> finChequeRecebidoModelList = [];

		try {
			handleFilter(filter, '/fin-cheque-recebido/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeRecebidoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finChequeRecebidoModel in finChequeRecebidoModelJson) {
						finChequeRecebidoModelList.add(FinChequeRecebidoModel.fromJson(finChequeRecebidoModel));
					}
					return finChequeRecebidoModelList;
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

	Future<FinChequeRecebidoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-cheque-recebido/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeRecebidoModelJson = json.decode(response.body);
					return FinChequeRecebidoModel.fromJson(finChequeRecebidoModelJson);		 
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

	Future<FinChequeRecebidoModel?>? insert(FinChequeRecebidoModel finChequeRecebidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-cheque-recebido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finChequeRecebidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeRecebidoModelJson = json.decode(response.body);
					return FinChequeRecebidoModel.fromJson(finChequeRecebidoModelJson);
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

	Future<FinChequeRecebidoModel?>? update(FinChequeRecebidoModel finChequeRecebidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-cheque-recebido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finChequeRecebidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeRecebidoModelJson = json.decode(response.body);
					return FinChequeRecebidoModel.fromJson(finChequeRecebidoModelJson);
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
				Uri.tryParse('$endpoint/fin-cheque-recebido/$pk')!,
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
