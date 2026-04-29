import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueCorApiProvider extends ApiProviderBase {

	Future<List<EstoqueCorModel>?> getList({Filter? filter}) async {
		List<EstoqueCorModel> estoqueCorModelList = [];

		try {
			handleFilter(filter, '/estoque-cor/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueCorModelJson = json.decode(response.body) as List<dynamic>;
					for (var estoqueCorModel in estoqueCorModelJson) {
						estoqueCorModelList.add(EstoqueCorModel.fromJson(estoqueCorModel));
					}
					return estoqueCorModelList;
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

	Future<EstoqueCorModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/estoque-cor/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueCorModelJson = json.decode(response.body);
					return EstoqueCorModel.fromJson(estoqueCorModelJson);		 
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

	Future<EstoqueCorModel?>? insert(EstoqueCorModel estoqueCorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/estoque-cor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueCorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueCorModelJson = json.decode(response.body);
					return EstoqueCorModel.fromJson(estoqueCorModelJson);
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

	Future<EstoqueCorModel?>? update(EstoqueCorModel estoqueCorModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/estoque-cor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueCorModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueCorModelJson = json.decode(response.body);
					return EstoqueCorModel.fromJson(estoqueCorModelJson);
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
				Uri.tryParse('$endpoint/estoque-cor/$pk')!,
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
