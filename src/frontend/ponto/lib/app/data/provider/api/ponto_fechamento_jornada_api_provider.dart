import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoFechamentoJornadaApiProvider extends ApiProviderBase {

	Future<List<PontoFechamentoJornadaModel>?> getList({Filter? filter}) async {
		List<PontoFechamentoJornadaModel> pontoFechamentoJornadaModelList = [];

		try {
			handleFilter(filter, '/ponto-fechamento-jornada/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoFechamentoJornadaModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoFechamentoJornadaModel in pontoFechamentoJornadaModelJson) {
						pontoFechamentoJornadaModelList.add(PontoFechamentoJornadaModel.fromJson(pontoFechamentoJornadaModel));
					}
					return pontoFechamentoJornadaModelList;
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

	Future<PontoFechamentoJornadaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-fechamento-jornada/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoFechamentoJornadaModelJson = json.decode(response.body);
					return PontoFechamentoJornadaModel.fromJson(pontoFechamentoJornadaModelJson);		 
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

	Future<PontoFechamentoJornadaModel?>? insert(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-fechamento-jornada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoFechamentoJornadaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoFechamentoJornadaModelJson = json.decode(response.body);
					return PontoFechamentoJornadaModel.fromJson(pontoFechamentoJornadaModelJson);
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

	Future<PontoFechamentoJornadaModel?>? update(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-fechamento-jornada')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoFechamentoJornadaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoFechamentoJornadaModelJson = json.decode(response.body);
					return PontoFechamentoJornadaModel.fromJson(pontoFechamentoJornadaModelJson);
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
				Uri.tryParse('$endpoint/ponto-fechamento-jornada/$pk')!,
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
