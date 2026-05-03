import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueSaborApiProvider extends ApiProviderBase {

	Future<List<EstoqueSaborModel>?> getList({Filter? filter}) async {
		List<EstoqueSaborModel> estoqueSaborModelList = [];

		try {
			handleFilter(filter, '/estoque-sabor/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueSaborModelJson = json.decode(response.body) as List<dynamic>;
					for (var estoqueSaborModel in estoqueSaborModelJson) {
						estoqueSaborModelList.add(EstoqueSaborModel.fromJson(estoqueSaborModel));
					}
					return estoqueSaborModelList;
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

	Future<EstoqueSaborModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/estoque-sabor/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueSaborModelJson = json.decode(response.body);
					return EstoqueSaborModel.fromJson(estoqueSaborModelJson);		 
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

	Future<EstoqueSaborModel?>? insert(EstoqueSaborModel estoqueSaborModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/estoque-sabor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueSaborModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueSaborModelJson = json.decode(response.body);
					return EstoqueSaborModel.fromJson(estoqueSaborModelJson);
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

	Future<EstoqueSaborModel?>? update(EstoqueSaborModel estoqueSaborModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/estoque-sabor')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueSaborModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueSaborModelJson = json.decode(response.body);
					return EstoqueSaborModel.fromJson(estoqueSaborModelJson);
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
				Uri.tryParse('$endpoint/estoque-sabor/$pk')!,
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
