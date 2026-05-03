import 'dart:convert';
import 'package:tributacao/app/data/provider/api/api_provider_base.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributConfiguraOfGtApiProvider extends ApiProviderBase {

	Future<List<TributConfiguraOfGtModel>?> getList({Filter? filter}) async {
		List<TributConfiguraOfGtModel> tributConfiguraOfGtModelList = [];

		try {
			handleFilter(filter, '/tribut-configura-of-gt/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributConfiguraOfGtModelJson = json.decode(response.body) as List<dynamic>;
					for (var tributConfiguraOfGtModel in tributConfiguraOfGtModelJson) {
						tributConfiguraOfGtModelList.add(TributConfiguraOfGtModel.fromJson(tributConfiguraOfGtModel));
					}
					return tributConfiguraOfGtModelList;
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

	Future<TributConfiguraOfGtModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tribut-configura-of-gt/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributConfiguraOfGtModelJson = json.decode(response.body);
					return TributConfiguraOfGtModel.fromJson(tributConfiguraOfGtModelJson);		 
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

	Future<TributConfiguraOfGtModel?>? insert(TributConfiguraOfGtModel tributConfiguraOfGtModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tribut-configura-of-gt')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributConfiguraOfGtModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributConfiguraOfGtModelJson = json.decode(response.body);
					return TributConfiguraOfGtModel.fromJson(tributConfiguraOfGtModelJson);
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

	Future<TributConfiguraOfGtModel?>? update(TributConfiguraOfGtModel tributConfiguraOfGtModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tribut-configura-of-gt')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributConfiguraOfGtModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributConfiguraOfGtModelJson = json.decode(response.body);
					return TributConfiguraOfGtModel.fromJson(tributConfiguraOfGtModelJson);
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
				Uri.tryParse('$endpoint/tribut-configura-of-gt/$pk')!,
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
