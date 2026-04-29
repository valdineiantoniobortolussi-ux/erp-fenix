import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CsosnApiProvider extends ApiProviderBase {

	Future<List<CsosnModel>?> getList({Filter? filter}) async {
		List<CsosnModel> csosnModelList = [];

		try {
			handleFilter(filter, '/csosn/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var csosnModelJson = json.decode(response.body) as List<dynamic>;
					for (var csosnModel in csosnModelJson) {
						csosnModelList.add(CsosnModel.fromJson(csosnModel));
					}
					return csosnModelList;
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

	Future<CsosnModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/csosn/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var csosnModelJson = json.decode(response.body);
					return CsosnModel.fromJson(csosnModelJson);		 
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

	Future<CsosnModel?>? insert(CsosnModel csosnModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/csosn')!,
				headers: ApiProviderBase.headerRequisition(),
				body: csosnModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var csosnModelJson = json.decode(response.body);
					return CsosnModel.fromJson(csosnModelJson);
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

	Future<CsosnModel?>? update(CsosnModel csosnModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/csosn')!,
				headers: ApiProviderBase.headerRequisition(),
				body: csosnModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var csosnModelJson = json.decode(response.body);
					return CsosnModel.fromJson(csosnModelJson);
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
				Uri.tryParse('$endpoint/csosn/$pk')!,
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
