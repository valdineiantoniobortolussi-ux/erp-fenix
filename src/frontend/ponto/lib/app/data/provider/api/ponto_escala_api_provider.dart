import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoEscalaApiProvider extends ApiProviderBase {

	Future<List<PontoEscalaModel>?> getList({Filter? filter}) async {
		List<PontoEscalaModel> pontoEscalaModelList = [];

		try {
			handleFilter(filter, '/ponto-escala/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoEscalaModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoEscalaModel in pontoEscalaModelJson) {
						pontoEscalaModelList.add(PontoEscalaModel.fromJson(pontoEscalaModel));
					}
					return pontoEscalaModelList;
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

	Future<PontoEscalaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-escala/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoEscalaModelJson = json.decode(response.body);
					return PontoEscalaModel.fromJson(pontoEscalaModelJson);		 
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

	Future<PontoEscalaModel?>? insert(PontoEscalaModel pontoEscalaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-escala')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoEscalaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoEscalaModelJson = json.decode(response.body);
					return PontoEscalaModel.fromJson(pontoEscalaModelJson);
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

	Future<PontoEscalaModel?>? update(PontoEscalaModel pontoEscalaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-escala')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoEscalaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoEscalaModelJson = json.decode(response.body);
					return PontoEscalaModel.fromJson(pontoEscalaModelJson);
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
				Uri.tryParse('$endpoint/ponto-escala/$pk')!,
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
