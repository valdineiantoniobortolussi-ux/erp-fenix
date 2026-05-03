import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class BancoContaCaixaApiProvider extends ApiProviderBase {

	Future<List<BancoContaCaixaModel>?> getList({Filter? filter}) async {
		List<BancoContaCaixaModel> bancoContaCaixaModelList = [];

		try {
			handleFilter(filter, '/banco-conta-caixa/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoContaCaixaModelJson = json.decode(response.body) as List<dynamic>;
					for (var bancoContaCaixaModel in bancoContaCaixaModelJson) {
						bancoContaCaixaModelList.add(BancoContaCaixaModel.fromJson(bancoContaCaixaModel));
					}
					return bancoContaCaixaModelList;
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

	Future<BancoContaCaixaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/banco-conta-caixa/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoContaCaixaModelJson = json.decode(response.body);
					return BancoContaCaixaModel.fromJson(bancoContaCaixaModelJson);		 
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

	Future<BancoContaCaixaModel?>? insert(BancoContaCaixaModel bancoContaCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/banco-conta-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: bancoContaCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoContaCaixaModelJson = json.decode(response.body);
					return BancoContaCaixaModel.fromJson(bancoContaCaixaModelJson);
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

	Future<BancoContaCaixaModel?>? update(BancoContaCaixaModel bancoContaCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/banco-conta-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: bancoContaCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoContaCaixaModelJson = json.decode(response.body);
					return BancoContaCaixaModel.fromJson(bancoContaCaixaModelJson);
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
				Uri.tryParse('$endpoint/banco-conta-caixa/$pk')!,
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
