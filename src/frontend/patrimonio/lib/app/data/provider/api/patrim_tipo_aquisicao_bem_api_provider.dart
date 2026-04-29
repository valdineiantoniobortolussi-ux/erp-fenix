import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTipoAquisicaoBemApiProvider extends ApiProviderBase {

	Future<List<PatrimTipoAquisicaoBemModel>?> getList({Filter? filter}) async {
		List<PatrimTipoAquisicaoBemModel> patrimTipoAquisicaoBemModelList = [];

		try {
			handleFilter(filter, '/patrim-tipo-aquisicao-bem/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoAquisicaoBemModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimTipoAquisicaoBemModel in patrimTipoAquisicaoBemModelJson) {
						patrimTipoAquisicaoBemModelList.add(PatrimTipoAquisicaoBemModel.fromJson(patrimTipoAquisicaoBemModel));
					}
					return patrimTipoAquisicaoBemModelList;
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

	Future<PatrimTipoAquisicaoBemModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-tipo-aquisicao-bem/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoAquisicaoBemModelJson = json.decode(response.body);
					return PatrimTipoAquisicaoBemModel.fromJson(patrimTipoAquisicaoBemModelJson);		 
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

	Future<PatrimTipoAquisicaoBemModel?>? insert(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-tipo-aquisicao-bem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTipoAquisicaoBemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoAquisicaoBemModelJson = json.decode(response.body);
					return PatrimTipoAquisicaoBemModel.fromJson(patrimTipoAquisicaoBemModelJson);
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

	Future<PatrimTipoAquisicaoBemModel?>? update(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-tipo-aquisicao-bem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTipoAquisicaoBemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoAquisicaoBemModelJson = json.decode(response.body);
					return PatrimTipoAquisicaoBemModel.fromJson(patrimTipoAquisicaoBemModelJson);
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
				Uri.tryParse('$endpoint/patrim-tipo-aquisicao-bem/$pk')!,
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
