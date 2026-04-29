import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaApiProvider extends ApiProviderBase {

	Future<List<OrcamentoFluxoCaixaModel>?> getList({Filter? filter}) async {
		List<OrcamentoFluxoCaixaModel> orcamentoFluxoCaixaModelList = [];

		try {
			handleFilter(filter, '/orcamento-fluxo-caixa/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaModelJson = json.decode(response.body) as List<dynamic>;
					for (var orcamentoFluxoCaixaModel in orcamentoFluxoCaixaModelJson) {
						orcamentoFluxoCaixaModelList.add(OrcamentoFluxoCaixaModel.fromJson(orcamentoFluxoCaixaModel));
					}
					return orcamentoFluxoCaixaModelList;
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

	Future<OrcamentoFluxoCaixaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/orcamento-fluxo-caixa/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaModel.fromJson(orcamentoFluxoCaixaModelJson);		 
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

	Future<OrcamentoFluxoCaixaModel?>? insert(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoFluxoCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaModel.fromJson(orcamentoFluxoCaixaModelJson);
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

	Future<OrcamentoFluxoCaixaModel?>? update(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoFluxoCaixaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaModel.fromJson(orcamentoFluxoCaixaModelJson);
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
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa/$pk')!,
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
