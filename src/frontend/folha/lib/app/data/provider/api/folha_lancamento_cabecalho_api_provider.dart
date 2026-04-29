import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoCabecalhoApiProvider extends ApiProviderBase {

	Future<List<FolhaLancamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<FolhaLancamentoCabecalhoModel> folhaLancamentoCabecalhoModelList = [];

		try {
			handleFilter(filter, '/folha-lancamento-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaLancamentoCabecalhoModel in folhaLancamentoCabecalhoModelJson) {
						folhaLancamentoCabecalhoModelList.add(FolhaLancamentoCabecalhoModel.fromJson(folhaLancamentoCabecalhoModel));
					}
					return folhaLancamentoCabecalhoModelList;
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

	Future<FolhaLancamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-lancamento-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoCabecalhoModelJson = json.decode(response.body);
					return FolhaLancamentoCabecalhoModel.fromJson(folhaLancamentoCabecalhoModelJson);		 
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

	Future<FolhaLancamentoCabecalhoModel?>? insert(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-lancamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaLancamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoCabecalhoModelJson = json.decode(response.body);
					return FolhaLancamentoCabecalhoModel.fromJson(folhaLancamentoCabecalhoModelJson);
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

	Future<FolhaLancamentoCabecalhoModel?>? update(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-lancamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaLancamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoCabecalhoModelJson = json.decode(response.body);
					return FolhaLancamentoCabecalhoModel.fromJson(folhaLancamentoCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/folha-lancamento-cabecalho/$pk')!,
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
