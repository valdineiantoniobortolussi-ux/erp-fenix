import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaPeriodoApiProvider extends ApiProviderBase {

	Future<List<OrcamentoFluxoCaixaPeriodoModel>?> getList({Filter? filter}) async {
		List<OrcamentoFluxoCaixaPeriodoModel> orcamentoFluxoCaixaPeriodoModelList = [];

		try {
			handleFilter(filter, '/orcamento-fluxo-caixa-periodo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaPeriodoModelJson = json.decode(response.body) as List<dynamic>;
					for (var orcamentoFluxoCaixaPeriodoModel in orcamentoFluxoCaixaPeriodoModelJson) {
						orcamentoFluxoCaixaPeriodoModelList.add(OrcamentoFluxoCaixaPeriodoModel.fromJson(orcamentoFluxoCaixaPeriodoModel));
					}
					return orcamentoFluxoCaixaPeriodoModelList;
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

	Future<OrcamentoFluxoCaixaPeriodoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/orcamento-fluxo-caixa-periodo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaPeriodoModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaPeriodoModel.fromJson(orcamentoFluxoCaixaPeriodoModelJson);		 
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

	Future<OrcamentoFluxoCaixaPeriodoModel?>? insert(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa-periodo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoFluxoCaixaPeriodoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaPeriodoModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaPeriodoModel.fromJson(orcamentoFluxoCaixaPeriodoModelJson);
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

	Future<OrcamentoFluxoCaixaPeriodoModel?>? update(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa-periodo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoFluxoCaixaPeriodoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoFluxoCaixaPeriodoModelJson = json.decode(response.body);
					return OrcamentoFluxoCaixaPeriodoModel.fromJson(orcamentoFluxoCaixaPeriodoModelJson);
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
				Uri.tryParse('$endpoint/orcamento-fluxo-caixa-periodo/$pk')!,
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
