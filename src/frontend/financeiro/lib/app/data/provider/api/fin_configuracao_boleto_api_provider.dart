import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinConfiguracaoBoletoApiProvider extends ApiProviderBase {

	Future<List<FinConfiguracaoBoletoModel>?> getList({Filter? filter}) async {
		List<FinConfiguracaoBoletoModel> finConfiguracaoBoletoModelList = [];

		try {
			handleFilter(filter, '/fin-configuracao-boleto/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finConfiguracaoBoletoModelJson = json.decode(response.body) as List<dynamic>;
					for (var finConfiguracaoBoletoModel in finConfiguracaoBoletoModelJson) {
						finConfiguracaoBoletoModelList.add(FinConfiguracaoBoletoModel.fromJson(finConfiguracaoBoletoModel));
					}
					return finConfiguracaoBoletoModelList;
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

	Future<FinConfiguracaoBoletoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-configuracao-boleto/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finConfiguracaoBoletoModelJson = json.decode(response.body);
					return FinConfiguracaoBoletoModel.fromJson(finConfiguracaoBoletoModelJson);		 
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

	Future<FinConfiguracaoBoletoModel?>? insert(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-configuracao-boleto')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finConfiguracaoBoletoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finConfiguracaoBoletoModelJson = json.decode(response.body);
					return FinConfiguracaoBoletoModel.fromJson(finConfiguracaoBoletoModelJson);
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

	Future<FinConfiguracaoBoletoModel?>? update(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-configuracao-boleto')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finConfiguracaoBoletoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finConfiguracaoBoletoModelJson = json.decode(response.body);
					return FinConfiguracaoBoletoModel.fromJson(finConfiguracaoBoletoModelJson);
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
				Uri.tryParse('$endpoint/fin-configuracao-boleto/$pk')!,
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
