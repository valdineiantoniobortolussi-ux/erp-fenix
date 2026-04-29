import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinExtratoContaBancoApiProvider extends ApiProviderBase {

	Future<List<FinExtratoContaBancoModel>?> getList({Filter? filter}) async {
		List<FinExtratoContaBancoModel> finExtratoContaBancoModelList = [];

		try {
			handleFilter(filter, '/fin-extrato-conta-banco/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finExtratoContaBancoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finExtratoContaBancoModel in finExtratoContaBancoModelJson) {
						finExtratoContaBancoModelList.add(FinExtratoContaBancoModel.fromJson(finExtratoContaBancoModel));
					}
					return finExtratoContaBancoModelList;
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

	Future<FinExtratoContaBancoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-extrato-conta-banco/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finExtratoContaBancoModelJson = json.decode(response.body);
					return FinExtratoContaBancoModel.fromJson(finExtratoContaBancoModelJson);		 
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

	Future<FinExtratoContaBancoModel?>? insert(FinExtratoContaBancoModel finExtratoContaBancoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-extrato-conta-banco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finExtratoContaBancoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finExtratoContaBancoModelJson = json.decode(response.body);
					return FinExtratoContaBancoModel.fromJson(finExtratoContaBancoModelJson);
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

	Future<FinExtratoContaBancoModel?>? update(FinExtratoContaBancoModel finExtratoContaBancoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-extrato-conta-banco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finExtratoContaBancoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finExtratoContaBancoModelJson = json.decode(response.body);
					return FinExtratoContaBancoModel.fromJson(finExtratoContaBancoModelJson);
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
				Uri.tryParse('$endpoint/fin-extrato-conta-banco/$pk')!,
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
