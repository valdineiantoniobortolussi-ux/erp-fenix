import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoClassificacaoJornadaApiProvider extends ApiProviderBase {

	Future<List<PontoClassificacaoJornadaModel>?> getList({Filter? filter}) async {
		List<PontoClassificacaoJornadaModel> pontoClassificacaoJornadaModelList = [];

		try {
			handleFilter(filter, '/ponto-classificacao-jornada/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoClassificacaoJornadaModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoClassificacaoJornadaModel in pontoClassificacaoJornadaModelJson) {
						pontoClassificacaoJornadaModelList.add(PontoClassificacaoJornadaModel.fromJson(pontoClassificacaoJornadaModel));
					}
					return pontoClassificacaoJornadaModelList;
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

	Future<PontoClassificacaoJornadaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-classificacao-jornada/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoClassificacaoJornadaModelJson = json.decode(response.body);
					return PontoClassificacaoJornadaModel.fromJson(pontoClassificacaoJornadaModelJson);		 
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

	Future<PontoClassificacaoJornadaModel?>? insert(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-classificacao-jornada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoClassificacaoJornadaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoClassificacaoJornadaModelJson = json.decode(response.body);
					return PontoClassificacaoJornadaModel.fromJson(pontoClassificacaoJornadaModelJson);
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

	Future<PontoClassificacaoJornadaModel?>? update(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-classificacao-jornada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoClassificacaoJornadaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoClassificacaoJornadaModelJson = json.decode(response.body);
					return PontoClassificacaoJornadaModel.fromJson(pontoClassificacaoJornadaModelJson);
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
				Uri.tryParse('$endpoint/ponto-classificacao-jornada/$pk')!,
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
