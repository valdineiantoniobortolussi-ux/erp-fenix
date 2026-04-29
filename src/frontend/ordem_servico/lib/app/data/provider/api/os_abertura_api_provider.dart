import 'dart:convert';
import 'package:ordem_servico/app/data/provider/api/api_provider_base.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsAberturaApiProvider extends ApiProviderBase {

	Future<List<OsAberturaModel>?> getList({Filter? filter}) async {
		List<OsAberturaModel> osAberturaModelList = [];

		try {
			handleFilter(filter, '/os-abertura/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osAberturaModelJson = json.decode(response.body) as List<dynamic>;
					for (var osAberturaModel in osAberturaModelJson) {
						osAberturaModelList.add(OsAberturaModel.fromJson(osAberturaModel));
					}
					return osAberturaModelList;
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

	Future<OsAberturaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/os-abertura/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osAberturaModelJson = json.decode(response.body);
					return OsAberturaModel.fromJson(osAberturaModelJson);		 
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

	Future<OsAberturaModel?>? insert(OsAberturaModel osAberturaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/os-abertura')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osAberturaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osAberturaModelJson = json.decode(response.body);
					return OsAberturaModel.fromJson(osAberturaModelJson);
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

	Future<OsAberturaModel?>? update(OsAberturaModel osAberturaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/os-abertura')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osAberturaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osAberturaModelJson = json.decode(response.body);
					return OsAberturaModel.fromJson(osAberturaModelJson);
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
				Uri.tryParse('$endpoint/os-abertura/$pk')!,
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
