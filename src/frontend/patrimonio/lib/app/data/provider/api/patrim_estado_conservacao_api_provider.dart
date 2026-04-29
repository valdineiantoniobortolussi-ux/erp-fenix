import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimEstadoConservacaoApiProvider extends ApiProviderBase {

	Future<List<PatrimEstadoConservacaoModel>?> getList({Filter? filter}) async {
		List<PatrimEstadoConservacaoModel> patrimEstadoConservacaoModelList = [];

		try {
			handleFilter(filter, '/patrim-estado-conservacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimEstadoConservacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimEstadoConservacaoModel in patrimEstadoConservacaoModelJson) {
						patrimEstadoConservacaoModelList.add(PatrimEstadoConservacaoModel.fromJson(patrimEstadoConservacaoModel));
					}
					return patrimEstadoConservacaoModelList;
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

	Future<PatrimEstadoConservacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-estado-conservacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimEstadoConservacaoModelJson = json.decode(response.body);
					return PatrimEstadoConservacaoModel.fromJson(patrimEstadoConservacaoModelJson);		 
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

	Future<PatrimEstadoConservacaoModel?>? insert(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-estado-conservacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimEstadoConservacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimEstadoConservacaoModelJson = json.decode(response.body);
					return PatrimEstadoConservacaoModel.fromJson(patrimEstadoConservacaoModelJson);
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

	Future<PatrimEstadoConservacaoModel?>? update(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-estado-conservacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimEstadoConservacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimEstadoConservacaoModelJson = json.decode(response.body);
					return PatrimEstadoConservacaoModel.fromJson(patrimEstadoConservacaoModelJson);
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
				Uri.tryParse('$endpoint/patrim-estado-conservacao/$pk')!,
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
