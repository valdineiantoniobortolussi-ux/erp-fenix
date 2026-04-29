import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsParametroApiProvider extends ApiProviderBase {

	Future<List<WmsParametroModel>?> getList({Filter? filter}) async {
		List<WmsParametroModel> wmsParametroModelList = [];

		try {
			handleFilter(filter, '/wms-parametro/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsParametroModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsParametroModel in wmsParametroModelJson) {
						wmsParametroModelList.add(WmsParametroModel.fromJson(wmsParametroModel));
					}
					return wmsParametroModelList;
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

	Future<WmsParametroModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-parametro/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsParametroModelJson = json.decode(response.body);
					return WmsParametroModel.fromJson(wmsParametroModelJson);		 
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

	Future<WmsParametroModel?>? insert(WmsParametroModel wmsParametroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-parametro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsParametroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsParametroModelJson = json.decode(response.body);
					return WmsParametroModel.fromJson(wmsParametroModelJson);
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

	Future<WmsParametroModel?>? update(WmsParametroModel wmsParametroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-parametro')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsParametroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsParametroModelJson = json.decode(response.body);
					return WmsParametroModel.fromJson(wmsParametroModelJson);
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
				Uri.tryParse('$endpoint/wms-parametro/$pk')!,
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
