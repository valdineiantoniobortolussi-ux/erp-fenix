import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TributIcmsCustomCabApiProvider extends ApiProviderBase {

	Future<List<TributIcmsCustomCabModel>?> getList({Filter? filter}) async {
		List<TributIcmsCustomCabModel> tributIcmsCustomCabModelList = [];

		try {
			handleFilter(filter, '/tribut-icms-custom-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIcmsCustomCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var tributIcmsCustomCabModel in tributIcmsCustomCabModelJson) {
						tributIcmsCustomCabModelList.add(TributIcmsCustomCabModel.fromJson(tributIcmsCustomCabModel));
					}
					return tributIcmsCustomCabModelList;
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

	Future<TributIcmsCustomCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tribut-icms-custom-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIcmsCustomCabModelJson = json.decode(response.body);
					return TributIcmsCustomCabModel.fromJson(tributIcmsCustomCabModelJson);		 
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

	Future<TributIcmsCustomCabModel?>? insert(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tribut-icms-custom-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributIcmsCustomCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIcmsCustomCabModelJson = json.decode(response.body);
					return TributIcmsCustomCabModel.fromJson(tributIcmsCustomCabModelJson);
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

	Future<TributIcmsCustomCabModel?>? update(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tribut-icms-custom-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributIcmsCustomCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributIcmsCustomCabModelJson = json.decode(response.body);
					return TributIcmsCustomCabModel.fromJson(tributIcmsCustomCabModelJson);
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
				Uri.tryParse('$endpoint/tribut-icms-custom-cab/$pk')!,
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
