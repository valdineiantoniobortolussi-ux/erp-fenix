import 'dart:convert';
import 'package:nfse/app/data/provider/api/api_provider_base.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class OsStatusApiProvider extends ApiProviderBase {

	Future<List<OsStatusModel>?> getList({Filter? filter}) async {
		List<OsStatusModel> osStatusModelList = [];

		try {
			handleFilter(filter, '/os-status/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osStatusModelJson = json.decode(response.body) as List<dynamic>;
					for (var osStatusModel in osStatusModelJson) {
						osStatusModelList.add(OsStatusModel.fromJson(osStatusModel));
					}
					return osStatusModelList;
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

	Future<OsStatusModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/os-status/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osStatusModelJson = json.decode(response.body);
					return OsStatusModel.fromJson(osStatusModelJson);		 
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

	Future<OsStatusModel?>? insert(OsStatusModel osStatusModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/os-status')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osStatusModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osStatusModelJson = json.decode(response.body);
					return OsStatusModel.fromJson(osStatusModelJson);
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

	Future<OsStatusModel?>? update(OsStatusModel osStatusModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/os-status')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osStatusModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osStatusModelJson = json.decode(response.body);
					return OsStatusModel.fromJson(osStatusModelJson);
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
				Uri.tryParse('$endpoint/os-status/$pk')!,
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
