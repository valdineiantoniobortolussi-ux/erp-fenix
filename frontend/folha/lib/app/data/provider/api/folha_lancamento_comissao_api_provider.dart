import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoComissaoApiProvider extends ApiProviderBase {

	Future<List<FolhaLancamentoComissaoModel>?> getList({Filter? filter}) async {
		List<FolhaLancamentoComissaoModel> folhaLancamentoComissaoModelList = [];

		try {
			handleFilter(filter, '/folha-lancamento-comissao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoComissaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaLancamentoComissaoModel in folhaLancamentoComissaoModelJson) {
						folhaLancamentoComissaoModelList.add(FolhaLancamentoComissaoModel.fromJson(folhaLancamentoComissaoModel));
					}
					return folhaLancamentoComissaoModelList;
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

	Future<FolhaLancamentoComissaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-lancamento-comissao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoComissaoModelJson = json.decode(response.body);
					return FolhaLancamentoComissaoModel.fromJson(folhaLancamentoComissaoModelJson);		 
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

	Future<FolhaLancamentoComissaoModel?>? insert(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-lancamento-comissao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaLancamentoComissaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoComissaoModelJson = json.decode(response.body);
					return FolhaLancamentoComissaoModel.fromJson(folhaLancamentoComissaoModelJson);
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

	Future<FolhaLancamentoComissaoModel?>? update(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-lancamento-comissao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaLancamentoComissaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaLancamentoComissaoModelJson = json.decode(response.body);
					return FolhaLancamentoComissaoModel.fromJson(folhaLancamentoComissaoModelJson);
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
				Uri.tryParse('$endpoint/folha-lancamento-comissao/$pk')!,
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
