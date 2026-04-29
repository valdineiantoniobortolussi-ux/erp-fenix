import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoHorarioAutorizadoApiProvider extends ApiProviderBase {

	Future<List<PontoHorarioAutorizadoModel>?> getList({Filter? filter}) async {
		List<PontoHorarioAutorizadoModel> pontoHorarioAutorizadoModelList = [];

		try {
			handleFilter(filter, '/ponto-horario-autorizado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioAutorizadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoHorarioAutorizadoModel in pontoHorarioAutorizadoModelJson) {
						pontoHorarioAutorizadoModelList.add(PontoHorarioAutorizadoModel.fromJson(pontoHorarioAutorizadoModel));
					}
					return pontoHorarioAutorizadoModelList;
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

	Future<PontoHorarioAutorizadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-horario-autorizado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioAutorizadoModelJson = json.decode(response.body);
					return PontoHorarioAutorizadoModel.fromJson(pontoHorarioAutorizadoModelJson);		 
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

	Future<PontoHorarioAutorizadoModel?>? insert(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-horario-autorizado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoHorarioAutorizadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioAutorizadoModelJson = json.decode(response.body);
					return PontoHorarioAutorizadoModel.fromJson(pontoHorarioAutorizadoModelJson);
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

	Future<PontoHorarioAutorizadoModel?>? update(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-horario-autorizado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoHorarioAutorizadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioAutorizadoModelJson = json.decode(response.body);
					return PontoHorarioAutorizadoModel.fromJson(pontoHorarioAutorizadoModelJson);
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
				Uri.tryParse('$endpoint/ponto-horario-autorizado/$pk')!,
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
