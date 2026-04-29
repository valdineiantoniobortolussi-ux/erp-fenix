import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimGrupoBemApiProvider extends ApiProviderBase {

	Future<List<PatrimGrupoBemModel>?> getList({Filter? filter}) async {
		List<PatrimGrupoBemModel> patrimGrupoBemModelList = [];

		try {
			handleFilter(filter, '/patrim-grupo-bem/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimGrupoBemModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimGrupoBemModel in patrimGrupoBemModelJson) {
						patrimGrupoBemModelList.add(PatrimGrupoBemModel.fromJson(patrimGrupoBemModel));
					}
					return patrimGrupoBemModelList;
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

	Future<PatrimGrupoBemModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-grupo-bem/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimGrupoBemModelJson = json.decode(response.body);
					return PatrimGrupoBemModel.fromJson(patrimGrupoBemModelJson);		 
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

	Future<PatrimGrupoBemModel?>? insert(PatrimGrupoBemModel patrimGrupoBemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-grupo-bem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimGrupoBemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimGrupoBemModelJson = json.decode(response.body);
					return PatrimGrupoBemModel.fromJson(patrimGrupoBemModelJson);
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

	Future<PatrimGrupoBemModel?>? update(PatrimGrupoBemModel patrimGrupoBemModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-grupo-bem')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimGrupoBemModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimGrupoBemModelJson = json.decode(response.body);
					return PatrimGrupoBemModel.fromJson(patrimGrupoBemModelJson);
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
				Uri.tryParse('$endpoint/patrim-grupo-bem/$pk')!,
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
