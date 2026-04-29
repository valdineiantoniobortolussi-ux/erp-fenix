import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class LancaCentroResultadoApiProvider extends ApiProviderBase {

	Future<List<LancaCentroResultadoModel>?> getList({Filter? filter}) async {
		List<LancaCentroResultadoModel> lancaCentroResultadoModelList = [];

		try {
			handleFilter(filter, '/lanca-centro-resultado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var lancaCentroResultadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var lancaCentroResultadoModel in lancaCentroResultadoModelJson) {
						lancaCentroResultadoModelList.add(LancaCentroResultadoModel.fromJson(lancaCentroResultadoModel));
					}
					return lancaCentroResultadoModelList;
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

	Future<LancaCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/lanca-centro-resultado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var lancaCentroResultadoModelJson = json.decode(response.body);
					return LancaCentroResultadoModel.fromJson(lancaCentroResultadoModelJson);		 
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

	Future<LancaCentroResultadoModel?>? insert(LancaCentroResultadoModel lancaCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/lanca-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: lancaCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var lancaCentroResultadoModelJson = json.decode(response.body);
					return LancaCentroResultadoModel.fromJson(lancaCentroResultadoModelJson);
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

	Future<LancaCentroResultadoModel?>? update(LancaCentroResultadoModel lancaCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/lanca-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: lancaCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var lancaCentroResultadoModelJson = json.decode(response.body);
					return LancaCentroResultadoModel.fromJson(lancaCentroResultadoModelJson);
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
				Uri.tryParse('$endpoint/lanca-centro-resultado/$pk')!,
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
