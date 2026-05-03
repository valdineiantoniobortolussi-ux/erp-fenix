import 'dart:convert';
import 'package:tributacao/app/data/provider/api/api_provider_base.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributIssApiProvider extends ApiProviderBase {

	Future<List<TributIssModel>?> getList({Filter? filter}) async {
		List<TributIssModel> tributIssModelList = [];

		try {
			handleFilter(filter, '/tribut-iss/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIssModelJson = json.decode(response.body) as List<dynamic>;
					for (var tributIssModel in tributIssModelJson) {
						tributIssModelList.add(TributIssModel.fromJson(tributIssModel));
					}
					return tributIssModelList;
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

	Future<TributIssModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tribut-iss/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIssModelJson = json.decode(response.body);
					return TributIssModel.fromJson(tributIssModelJson);		 
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

	Future<TributIssModel?>? insert(TributIssModel tributIssModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tribut-iss')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributIssModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIssModelJson = json.decode(response.body);
					return TributIssModel.fromJson(tributIssModelJson);
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

	Future<TributIssModel?>? update(TributIssModel tributIssModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tribut-iss')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributIssModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIssModelJson = json.decode(response.body);
					return TributIssModel.fromJson(tributIssModelJson);
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
				Uri.tryParse('$endpoint/tribut-iss/$pk')!,
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
