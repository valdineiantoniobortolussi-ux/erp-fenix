import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeEmitidoApiProvider extends ApiProviderBase {

	Future<List<FinChequeEmitidoModel>?> getList({Filter? filter}) async {
		List<FinChequeEmitidoModel> finChequeEmitidoModelList = [];

		try {
			handleFilter(filter, '/fin-cheque-emitido/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeEmitidoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finChequeEmitidoModel in finChequeEmitidoModelJson) {
						finChequeEmitidoModelList.add(FinChequeEmitidoModel.fromJson(finChequeEmitidoModel));
					}
					return finChequeEmitidoModelList;
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

	Future<FinChequeEmitidoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-cheque-emitido/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeEmitidoModelJson = json.decode(response.body);
					return FinChequeEmitidoModel.fromJson(finChequeEmitidoModelJson);		 
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

	Future<FinChequeEmitidoModel?>? insert(FinChequeEmitidoModel finChequeEmitidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-cheque-emitido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finChequeEmitidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeEmitidoModelJson = json.decode(response.body);
					return FinChequeEmitidoModel.fromJson(finChequeEmitidoModelJson);
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

	Future<FinChequeEmitidoModel?>? update(FinChequeEmitidoModel finChequeEmitidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-cheque-emitido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finChequeEmitidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finChequeEmitidoModelJson = json.decode(response.body);
					return FinChequeEmitidoModel.fromJson(finChequeEmitidoModelJson);
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
				Uri.tryParse('$endpoint/fin-cheque-emitido/$pk')!,
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
