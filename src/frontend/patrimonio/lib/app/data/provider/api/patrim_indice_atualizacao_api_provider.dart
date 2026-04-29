import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimIndiceAtualizacaoApiProvider extends ApiProviderBase {

	Future<List<PatrimIndiceAtualizacaoModel>?> getList({Filter? filter}) async {
		List<PatrimIndiceAtualizacaoModel> patrimIndiceAtualizacaoModelList = [];

		try {
			handleFilter(filter, '/patrim-indice-atualizacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimIndiceAtualizacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimIndiceAtualizacaoModel in patrimIndiceAtualizacaoModelJson) {
						patrimIndiceAtualizacaoModelList.add(PatrimIndiceAtualizacaoModel.fromJson(patrimIndiceAtualizacaoModel));
					}
					return patrimIndiceAtualizacaoModelList;
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

	Future<PatrimIndiceAtualizacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-indice-atualizacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimIndiceAtualizacaoModelJson = json.decode(response.body);
					return PatrimIndiceAtualizacaoModel.fromJson(patrimIndiceAtualizacaoModelJson);		 
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

	Future<PatrimIndiceAtualizacaoModel?>? insert(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-indice-atualizacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimIndiceAtualizacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimIndiceAtualizacaoModelJson = json.decode(response.body);
					return PatrimIndiceAtualizacaoModel.fromJson(patrimIndiceAtualizacaoModelJson);
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

	Future<PatrimIndiceAtualizacaoModel?>? update(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-indice-atualizacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimIndiceAtualizacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimIndiceAtualizacaoModelJson = json.decode(response.body);
					return PatrimIndiceAtualizacaoModel.fromJson(patrimIndiceAtualizacaoModelJson);
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
				Uri.tryParse('$endpoint/patrim-indice-atualizacao/$pk')!,
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
