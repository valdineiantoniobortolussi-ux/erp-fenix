import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoHorarioApiProvider extends ApiProviderBase {

	Future<List<PontoHorarioModel>?> getList({Filter? filter}) async {
		List<PontoHorarioModel> pontoHorarioModelList = [];

		try {
			handleFilter(filter, '/ponto-horario/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoHorarioModel in pontoHorarioModelJson) {
						pontoHorarioModelList.add(PontoHorarioModel.fromJson(pontoHorarioModel));
					}
					return pontoHorarioModelList;
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

	Future<PontoHorarioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-horario/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioModelJson = json.decode(response.body);
					return PontoHorarioModel.fromJson(pontoHorarioModelJson);		 
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

	Future<PontoHorarioModel?>? insert(PontoHorarioModel pontoHorarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-horario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoHorarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioModelJson = json.decode(response.body);
					return PontoHorarioModel.fromJson(pontoHorarioModelJson);
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

	Future<PontoHorarioModel?>? update(PontoHorarioModel pontoHorarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-horario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoHorarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoHorarioModelJson = json.decode(response.body);
					return PontoHorarioModel.fromJson(pontoHorarioModelJson);
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
				Uri.tryParse('$endpoint/ponto-horario/$pk')!,
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
