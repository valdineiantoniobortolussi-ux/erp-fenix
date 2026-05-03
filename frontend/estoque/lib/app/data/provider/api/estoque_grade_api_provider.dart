import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueGradeApiProvider extends ApiProviderBase {

	Future<List<EstoqueGradeModel>?> getList({Filter? filter}) async {
		List<EstoqueGradeModel> estoqueGradeModelList = [];

		try {
			handleFilter(filter, '/estoque-grade/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueGradeModelJson = json.decode(response.body) as List<dynamic>;
					for (var estoqueGradeModel in estoqueGradeModelJson) {
						estoqueGradeModelList.add(EstoqueGradeModel.fromJson(estoqueGradeModel));
					}
					return estoqueGradeModelList;
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

	Future<EstoqueGradeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/estoque-grade/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueGradeModelJson = json.decode(response.body);
					return EstoqueGradeModel.fromJson(estoqueGradeModelJson);		 
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

	Future<EstoqueGradeModel?>? insert(EstoqueGradeModel estoqueGradeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/estoque-grade')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueGradeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueGradeModelJson = json.decode(response.body);
					return EstoqueGradeModel.fromJson(estoqueGradeModelJson);
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

	Future<EstoqueGradeModel?>? update(EstoqueGradeModel estoqueGradeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/estoque-grade')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueGradeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueGradeModelJson = json.decode(response.body);
					return EstoqueGradeModel.fromJson(estoqueGradeModelJson);
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
				Uri.tryParse('$endpoint/estoque-grade/$pk')!,
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
