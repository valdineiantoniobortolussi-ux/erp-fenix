import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoPadraoApiProvider extends ApiProviderBase {

	Future<List<ContabilLancamentoPadraoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoPadraoModel> contabilLancamentoPadraoModelList = [];

		try {
			handleFilter(filter, '/contabil-lancamento-padrao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoPadraoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilLancamentoPadraoModel in contabilLancamentoPadraoModelJson) {
						contabilLancamentoPadraoModelList.add(ContabilLancamentoPadraoModel.fromJson(contabilLancamentoPadraoModel));
					}
					return contabilLancamentoPadraoModelList;
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

	Future<ContabilLancamentoPadraoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-lancamento-padrao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoPadraoModelJson = json.decode(response.body);
					return ContabilLancamentoPadraoModel.fromJson(contabilLancamentoPadraoModelJson);		 
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

	Future<ContabilLancamentoPadraoModel?>? insert(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-lancamento-padrao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoPadraoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoPadraoModelJson = json.decode(response.body);
					return ContabilLancamentoPadraoModel.fromJson(contabilLancamentoPadraoModelJson);
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

	Future<ContabilLancamentoPadraoModel?>? update(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-lancamento-padrao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoPadraoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoPadraoModelJson = json.decode(response.body);
					return ContabilLancamentoPadraoModel.fromJson(contabilLancamentoPadraoModelJson);
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
				Uri.tryParse('$endpoint/contabil-lancamento-padrao/$pk')!,
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
