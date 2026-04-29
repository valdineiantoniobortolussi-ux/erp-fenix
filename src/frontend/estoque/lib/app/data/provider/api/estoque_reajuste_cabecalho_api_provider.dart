import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueReajusteCabecalhoApiProvider extends ApiProviderBase {

	Future<List<EstoqueReajusteCabecalhoModel>?> getList({Filter? filter}) async {
		List<EstoqueReajusteCabecalhoModel> estoqueReajusteCabecalhoModelList = [];

		try {
			handleFilter(filter, '/estoque-reajuste-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueReajusteCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var estoqueReajusteCabecalhoModel in estoqueReajusteCabecalhoModelJson) {
						estoqueReajusteCabecalhoModelList.add(EstoqueReajusteCabecalhoModel.fromJson(estoqueReajusteCabecalhoModel));
					}
					return estoqueReajusteCabecalhoModelList;
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

	Future<EstoqueReajusteCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/estoque-reajuste-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueReajusteCabecalhoModelJson = json.decode(response.body);
					return EstoqueReajusteCabecalhoModel.fromJson(estoqueReajusteCabecalhoModelJson);		 
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

	Future<EstoqueReajusteCabecalhoModel?>? insert(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/estoque-reajuste-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueReajusteCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueReajusteCabecalhoModelJson = json.decode(response.body);
					return EstoqueReajusteCabecalhoModel.fromJson(estoqueReajusteCabecalhoModelJson);
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

	Future<EstoqueReajusteCabecalhoModel?>? update(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/estoque-reajuste-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueReajusteCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueReajusteCabecalhoModelJson = json.decode(response.body);
					return EstoqueReajusteCabecalhoModel.fromJson(estoqueReajusteCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/estoque-reajuste-cabecalho/$pk')!,
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
