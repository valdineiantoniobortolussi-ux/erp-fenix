import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoOrcadoApiProvider extends ApiProviderBase {

	Future<List<ContabilLancamentoOrcadoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoOrcadoModel> contabilLancamentoOrcadoModelList = [];

		try {
			handleFilter(filter, '/contabil-lancamento-orcado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoOrcadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilLancamentoOrcadoModel in contabilLancamentoOrcadoModelJson) {
						contabilLancamentoOrcadoModelList.add(ContabilLancamentoOrcadoModel.fromJson(contabilLancamentoOrcadoModel));
					}
					return contabilLancamentoOrcadoModelList;
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

	Future<ContabilLancamentoOrcadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-lancamento-orcado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoOrcadoModelJson = json.decode(response.body);
					return ContabilLancamentoOrcadoModel.fromJson(contabilLancamentoOrcadoModelJson);		 
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

	Future<ContabilLancamentoOrcadoModel?>? insert(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-lancamento-orcado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoOrcadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoOrcadoModelJson = json.decode(response.body);
					return ContabilLancamentoOrcadoModel.fromJson(contabilLancamentoOrcadoModelJson);
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

	Future<ContabilLancamentoOrcadoModel?>? update(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-lancamento-orcado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilLancamentoOrcadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilLancamentoOrcadoModelJson = json.decode(response.body);
					return ContabilLancamentoOrcadoModel.fromJson(contabilLancamentoOrcadoModelJson);
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
				Uri.tryParse('$endpoint/contabil-lancamento-orcado/$pk')!,
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
