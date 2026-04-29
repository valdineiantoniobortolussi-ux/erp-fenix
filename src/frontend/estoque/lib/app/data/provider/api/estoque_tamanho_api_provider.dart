import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueTamanhoApiProvider extends ApiProviderBase {

	Future<List<EstoqueTamanhoModel>?> getList({Filter? filter}) async {
		List<EstoqueTamanhoModel> estoqueTamanhoModelList = [];

		try {
			handleFilter(filter, '/estoque-tamanho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueTamanhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var estoqueTamanhoModel in estoqueTamanhoModelJson) {
						estoqueTamanhoModelList.add(EstoqueTamanhoModel.fromJson(estoqueTamanhoModel));
					}
					return estoqueTamanhoModelList;
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

	Future<EstoqueTamanhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/estoque-tamanho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueTamanhoModelJson = json.decode(response.body);
					return EstoqueTamanhoModel.fromJson(estoqueTamanhoModelJson);		 
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

	Future<EstoqueTamanhoModel?>? insert(EstoqueTamanhoModel estoqueTamanhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/estoque-tamanho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueTamanhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueTamanhoModelJson = json.decode(response.body);
					return EstoqueTamanhoModel.fromJson(estoqueTamanhoModelJson);
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

	Future<EstoqueTamanhoModel?>? update(EstoqueTamanhoModel estoqueTamanhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/estoque-tamanho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: estoqueTamanhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var estoqueTamanhoModelJson = json.decode(response.body);
					return EstoqueTamanhoModel.fromJson(estoqueTamanhoModelJson);
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
				Uri.tryParse('$endpoint/estoque-tamanho/$pk')!,
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
