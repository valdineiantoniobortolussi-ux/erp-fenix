import 'dart:convert';
import 'package:administrativo/app/data/provider/api/api_provider_base.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class AuditoriaApiProvider extends ApiProviderBase {

	Future<List<AuditoriaModel>?> getList({Filter? filter}) async {
		List<AuditoriaModel> auditoriaModelList = [];

		try {
			handleFilter(filter, '/auditoria/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var auditoriaModelJson = json.decode(response.body) as List<dynamic>;
					for (var auditoriaModel in auditoriaModelJson) {
						auditoriaModelList.add(AuditoriaModel.fromJson(auditoriaModel));
					}
					return auditoriaModelList;
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

	Future<AuditoriaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/auditoria/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var auditoriaModelJson = json.decode(response.body);
					return AuditoriaModel.fromJson(auditoriaModelJson);		 
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

	Future<AuditoriaModel?>? insert(AuditoriaModel auditoriaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/auditoria')!,
				headers: ApiProviderBase.headerRequisition(),
				body: auditoriaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var auditoriaModelJson = json.decode(response.body);
					return AuditoriaModel.fromJson(auditoriaModelJson);
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

	Future<AuditoriaModel?>? update(AuditoriaModel auditoriaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/auditoria')!,
				headers: ApiProviderBase.headerRequisition(),
				body: auditoriaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var auditoriaModelJson = json.decode(response.body);
					return AuditoriaModel.fromJson(auditoriaModelJson);
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
				Uri.tryParse('$endpoint/auditoria/$pk')!,
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
