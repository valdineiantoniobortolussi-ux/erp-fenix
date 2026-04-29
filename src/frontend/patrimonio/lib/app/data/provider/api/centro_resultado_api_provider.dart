import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class CentroResultadoApiProvider extends ApiProviderBase {

	Future<List<CentroResultadoModel>?> getList({Filter? filter}) async {
		List<CentroResultadoModel> centroResultadoModelList = [];

		try {
			handleFilter(filter, '/centro-resultado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var centroResultadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var centroResultadoModel in centroResultadoModelJson) {
						centroResultadoModelList.add(CentroResultadoModel.fromJson(centroResultadoModel));
					}
					return centroResultadoModelList;
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

	Future<CentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/centro-resultado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var centroResultadoModelJson = json.decode(response.body);
					return CentroResultadoModel.fromJson(centroResultadoModelJson);		 
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

	Future<CentroResultadoModel?>? insert(CentroResultadoModel centroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: centroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var centroResultadoModelJson = json.decode(response.body);
					return CentroResultadoModel.fromJson(centroResultadoModelJson);
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

	Future<CentroResultadoModel?>? update(CentroResultadoModel centroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: centroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var centroResultadoModelJson = json.decode(response.body);
					return CentroResultadoModel.fromJson(centroResultadoModelJson);
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
				Uri.tryParse('$endpoint/centro-resultado/$pk')!,
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
