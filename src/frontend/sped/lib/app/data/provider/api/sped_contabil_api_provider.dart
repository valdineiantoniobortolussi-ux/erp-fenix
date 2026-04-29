import 'dart:convert';
import 'package:sped/app/data/provider/api/api_provider_base.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SpedContabilApiProvider extends ApiProviderBase {

	Future<List<SpedContabilModel>?> getList({Filter? filter}) async {
		List<SpedContabilModel> spedContabilModelList = [];

		try {
			handleFilter(filter, '/sped-contabil/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedContabilModelJson = json.decode(response.body) as List<dynamic>;
					for (var spedContabilModel in spedContabilModelJson) {
						spedContabilModelList.add(SpedContabilModel.fromJson(spedContabilModel));
					}
					return spedContabilModelList;
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

	Future<SpedContabilModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/sped-contabil/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedContabilModelJson = json.decode(response.body);
					return SpedContabilModel.fromJson(spedContabilModelJson);		 
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

	Future<SpedContabilModel?>? insert(SpedContabilModel spedContabilModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/sped-contabil')!,
				headers: ApiProviderBase.headerRequisition(),
				body: spedContabilModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedContabilModelJson = json.decode(response.body);
					return SpedContabilModel.fromJson(spedContabilModelJson);
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

	Future<SpedContabilModel?>? update(SpedContabilModel spedContabilModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/sped-contabil')!,
				headers: ApiProviderBase.headerRequisition(),
				body: spedContabilModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedContabilModelJson = json.decode(response.body);
					return SpedContabilModel.fromJson(spedContabilModelJson);
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
				Uri.tryParse('$endpoint/sped-contabil/$pk')!,
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
