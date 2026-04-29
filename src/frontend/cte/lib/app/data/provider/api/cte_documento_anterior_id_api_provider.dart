import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteDocumentoAnteriorIdApiProvider extends ApiProviderBase {

	Future<List<CteDocumentoAnteriorIdModel>?> getList({Filter? filter}) async {
		List<CteDocumentoAnteriorIdModel> cteDocumentoAnteriorIdModelList = [];

		try {
			handleFilter(filter, '/cte-documento-anterior-id/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteDocumentoAnteriorIdModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteDocumentoAnteriorIdModel in cteDocumentoAnteriorIdModelJson) {
						cteDocumentoAnteriorIdModelList.add(CteDocumentoAnteriorIdModel.fromJson(cteDocumentoAnteriorIdModel));
					}
					return cteDocumentoAnteriorIdModelList;
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

	Future<CteDocumentoAnteriorIdModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-documento-anterior-id/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteDocumentoAnteriorIdModelJson = json.decode(response.body);
					return CteDocumentoAnteriorIdModel.fromJson(cteDocumentoAnteriorIdModelJson);		 
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

	Future<CteDocumentoAnteriorIdModel?>? insert(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-documento-anterior-id')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteDocumentoAnteriorIdModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteDocumentoAnteriorIdModelJson = json.decode(response.body);
					return CteDocumentoAnteriorIdModel.fromJson(cteDocumentoAnteriorIdModelJson);
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

	Future<CteDocumentoAnteriorIdModel?>? update(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-documento-anterior-id')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteDocumentoAnteriorIdModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteDocumentoAnteriorIdModelJson = json.decode(response.body);
					return CteDocumentoAnteriorIdModel.fromJson(cteDocumentoAnteriorIdModelJson);
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
				Uri.tryParse('$endpoint/cte-documento-anterior-id/$pk')!,
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
