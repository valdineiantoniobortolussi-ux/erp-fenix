import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class EncerraCentroResultadoApiProvider extends ApiProviderBase {

	Future<List<EncerraCentroResultadoModel>?> getList({Filter? filter}) async {
		List<EncerraCentroResultadoModel> encerraCentroResultadoModelList = [];

		try {
			handleFilter(filter, '/encerra-centro-resultado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var encerraCentroResultadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var encerraCentroResultadoModel in encerraCentroResultadoModelJson) {
						encerraCentroResultadoModelList.add(EncerraCentroResultadoModel.fromJson(encerraCentroResultadoModel));
					}
					return encerraCentroResultadoModelList;
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

	Future<EncerraCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/encerra-centro-resultado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var encerraCentroResultadoModelJson = json.decode(response.body);
					return EncerraCentroResultadoModel.fromJson(encerraCentroResultadoModelJson);		 
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

	Future<EncerraCentroResultadoModel?>? insert(EncerraCentroResultadoModel encerraCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/encerra-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: encerraCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var encerraCentroResultadoModelJson = json.decode(response.body);
					return EncerraCentroResultadoModel.fromJson(encerraCentroResultadoModelJson);
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

	Future<EncerraCentroResultadoModel?>? update(EncerraCentroResultadoModel encerraCentroResultadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/encerra-centro-resultado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: encerraCentroResultadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var encerraCentroResultadoModelJson = json.decode(response.body);
					return EncerraCentroResultadoModel.fromJson(encerraCentroResultadoModelJson);
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
				Uri.tryParse('$endpoint/encerra-centro-resultado/$pk')!,
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
