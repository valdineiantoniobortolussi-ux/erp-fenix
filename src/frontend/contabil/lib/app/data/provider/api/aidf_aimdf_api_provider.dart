import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class AidfAimdfApiProvider extends ApiProviderBase {

	Future<List<AidfAimdfModel>?> getList({Filter? filter}) async {
		List<AidfAimdfModel> aidfAimdfModelList = [];

		try {
			handleFilter(filter, '/aidf-aimdf/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var aidfAimdfModelJson = json.decode(response.body) as List<dynamic>;
					for (var aidfAimdfModel in aidfAimdfModelJson) {
						aidfAimdfModelList.add(AidfAimdfModel.fromJson(aidfAimdfModel));
					}
					return aidfAimdfModelList;
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

	Future<AidfAimdfModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/aidf-aimdf/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var aidfAimdfModelJson = json.decode(response.body);
					return AidfAimdfModel.fromJson(aidfAimdfModelJson);		 
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

	Future<AidfAimdfModel?>? insert(AidfAimdfModel aidfAimdfModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/aidf-aimdf')!,
				headers: ApiProviderBase.headerRequisition(),
				body: aidfAimdfModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var aidfAimdfModelJson = json.decode(response.body);
					return AidfAimdfModel.fromJson(aidfAimdfModelJson);
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

	Future<AidfAimdfModel?>? update(AidfAimdfModel aidfAimdfModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/aidf-aimdf')!,
				headers: ApiProviderBase.headerRequisition(),
				body: aidfAimdfModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var aidfAimdfModelJson = json.decode(response.body);
					return AidfAimdfModel.fromJson(aidfAimdfModelJson);
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
				Uri.tryParse('$endpoint/aidf-aimdf/$pk')!,
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
