import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoRelogioApiProvider extends ApiProviderBase {

	Future<List<PontoRelogioModel>?> getList({Filter? filter}) async {
		List<PontoRelogioModel> pontoRelogioModelList = [];

		try {
			handleFilter(filter, '/ponto-relogio/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoRelogioModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoRelogioModel in pontoRelogioModelJson) {
						pontoRelogioModelList.add(PontoRelogioModel.fromJson(pontoRelogioModel));
					}
					return pontoRelogioModelList;
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

	Future<PontoRelogioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-relogio/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoRelogioModelJson = json.decode(response.body);
					return PontoRelogioModel.fromJson(pontoRelogioModelJson);		 
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

	Future<PontoRelogioModel?>? insert(PontoRelogioModel pontoRelogioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-relogio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoRelogioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoRelogioModelJson = json.decode(response.body);
					return PontoRelogioModel.fromJson(pontoRelogioModelJson);
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

	Future<PontoRelogioModel?>? update(PontoRelogioModel pontoRelogioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-relogio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoRelogioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoRelogioModelJson = json.decode(response.body);
					return PontoRelogioModel.fromJson(pontoRelogioModelJson);
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
				Uri.tryParse('$endpoint/ponto-relogio/$pk')!,
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
