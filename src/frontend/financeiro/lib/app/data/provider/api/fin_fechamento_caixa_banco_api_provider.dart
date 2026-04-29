import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinFechamentoCaixaBancoApiProvider extends ApiProviderBase {

	Future<List<FinFechamentoCaixaBancoModel>?> getList({Filter? filter}) async {
		List<FinFechamentoCaixaBancoModel> finFechamentoCaixaBancoModelList = [];

		try {
			handleFilter(filter, '/fin-fechamento-caixa-banco/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finFechamentoCaixaBancoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finFechamentoCaixaBancoModel in finFechamentoCaixaBancoModelJson) {
						finFechamentoCaixaBancoModelList.add(FinFechamentoCaixaBancoModel.fromJson(finFechamentoCaixaBancoModel));
					}
					return finFechamentoCaixaBancoModelList;
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

	Future<FinFechamentoCaixaBancoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-fechamento-caixa-banco/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finFechamentoCaixaBancoModelJson = json.decode(response.body);
					return FinFechamentoCaixaBancoModel.fromJson(finFechamentoCaixaBancoModelJson);		 
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

	Future<FinFechamentoCaixaBancoModel?>? insert(FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-fechamento-caixa-banco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finFechamentoCaixaBancoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finFechamentoCaixaBancoModelJson = json.decode(response.body);
					return FinFechamentoCaixaBancoModel.fromJson(finFechamentoCaixaBancoModelJson);
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

	Future<FinFechamentoCaixaBancoModel?>? update(FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-fechamento-caixa-banco')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finFechamentoCaixaBancoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finFechamentoCaixaBancoModelJson = json.decode(response.body);
					return FinFechamentoCaixaBancoModel.fromJson(finFechamentoCaixaBancoModelJson);
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
				Uri.tryParse('$endpoint/fin-fechamento-caixa-banco/$pk')!,
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
