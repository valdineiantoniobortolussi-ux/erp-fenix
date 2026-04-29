import 'dart:convert';
import 'package:sped/app/data/provider/api/api_provider_base.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdReinfApiProvider extends ApiProviderBase {

	Future<List<EfdReinfModel>?> getList({Filter? filter}) async {
		List<EfdReinfModel> efdReinfModelList = [];

		try {
			handleFilter(filter, '/efd-reinf/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdReinfModelJson = json.decode(response.body) as List<dynamic>;
					for (var efdReinfModel in efdReinfModelJson) {
						efdReinfModelList.add(EfdReinfModel.fromJson(efdReinfModel));
					}
					return efdReinfModelList;
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

	Future<EfdReinfModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/efd-reinf/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdReinfModelJson = json.decode(response.body);
					return EfdReinfModel.fromJson(efdReinfModelJson);		 
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

	Future<EfdReinfModel?>? insert(EfdReinfModel efdReinfModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/efd-reinf')!,
				headers: ApiProviderBase.headerRequisition(),
				body: efdReinfModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdReinfModelJson = json.decode(response.body);
					return EfdReinfModel.fromJson(efdReinfModelJson);
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

	Future<EfdReinfModel?>? update(EfdReinfModel efdReinfModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/efd-reinf')!,
				headers: ApiProviderBase.headerRequisition(),
				body: efdReinfModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var efdReinfModelJson = json.decode(response.body);
					return EfdReinfModel.fromJson(efdReinfModelJson);
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
				Uri.tryParse('$endpoint/efd-reinf/$pk')!,
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
