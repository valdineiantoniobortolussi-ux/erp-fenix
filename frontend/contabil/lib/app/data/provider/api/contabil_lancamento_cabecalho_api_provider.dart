import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoCabecalhoApiProvider extends ApiProviderBase {

	Future<List<ContabilLancamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoCabecalhoModel> contabilLancamentoCabecalhoModelList = [];

		try {
			handleFilter(filter, '/contabil-lancamento-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilLancamentoCabecalhoModel in contabilLancamentoCabecalhoModelJson) {
						contabilLancamentoCabecalhoModelList.add(ContabilLancamentoCabecalhoModel.fromJson(contabilLancamentoCabecalhoModel));
					}
					return contabilLancamentoCabecalhoModelList;
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

	Future<ContabilLancamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-lancamento-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoCabecalhoModelJson = json.decode(response.body);
					return ContabilLancamentoCabecalhoModel.fromJson(contabilLancamentoCabecalhoModelJson);		 
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

	Future<ContabilLancamentoCabecalhoModel?>? insert(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-lancamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoCabecalhoModelJson = json.decode(response.body);
					return ContabilLancamentoCabecalhoModel.fromJson(contabilLancamentoCabecalhoModelJson);
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

	Future<ContabilLancamentoCabecalhoModel?>? update(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-lancamento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoCabecalhoModelJson = json.decode(response.body);
					return ContabilLancamentoCabecalhoModel.fromJson(contabilLancamentoCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/contabil-lancamento-cabecalho/$pk')!,
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
