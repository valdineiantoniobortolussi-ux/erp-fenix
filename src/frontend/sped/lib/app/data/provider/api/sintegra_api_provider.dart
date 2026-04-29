import 'dart:convert';
import 'package:sped/app/data/provider/api/api_provider_base.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SintegraApiProvider extends ApiProviderBase {

	Future<List<SintegraModel>?> getList({Filter? filter}) async {
		List<SintegraModel> sintegraModelList = [];

		try {
			handleFilter(filter, '/sintegra/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sintegraModelJson = json.decode(response.body) as List<dynamic>;
					for (var sintegraModel in sintegraModelJson) {
						sintegraModelList.add(SintegraModel.fromJson(sintegraModel));
					}
					return sintegraModelList;
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

	Future<SintegraModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/sintegra/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sintegraModelJson = json.decode(response.body);
					return SintegraModel.fromJson(sintegraModelJson);		 
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

	Future<SintegraModel?>? insert(SintegraModel sintegraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/sintegra')!,
				headers: ApiProviderBase.headerRequisition(),
				body: sintegraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sintegraModelJson = json.decode(response.body);
					return SintegraModel.fromJson(sintegraModelJson);
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

	Future<SintegraModel?>? update(SintegraModel sintegraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/sintegra')!,
				headers: ApiProviderBase.headerRequisition(),
				body: sintegraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var sintegraModelJson = json.decode(response.body);
					return SintegraModel.fromJson(sintegraModelJson);
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
				Uri.tryParse('$endpoint/sintegra/$pk')!,
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
