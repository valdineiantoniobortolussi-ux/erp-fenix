import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsRuaApiProvider extends ApiProviderBase {

	Future<List<WmsRuaModel>?> getList({Filter? filter}) async {
		List<WmsRuaModel> wmsRuaModelList = [];

		try {
			handleFilter(filter, '/wms-rua/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRuaModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsRuaModel in wmsRuaModelJson) {
						wmsRuaModelList.add(WmsRuaModel.fromJson(wmsRuaModel));
					}
					return wmsRuaModelList;
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

	Future<WmsRuaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-rua/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRuaModelJson = json.decode(response.body);
					return WmsRuaModel.fromJson(wmsRuaModelJson);		 
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

	Future<WmsRuaModel?>? insert(WmsRuaModel wmsRuaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-rua')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsRuaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRuaModelJson = json.decode(response.body);
					return WmsRuaModel.fromJson(wmsRuaModelJson);
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

	Future<WmsRuaModel?>? update(WmsRuaModel wmsRuaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-rua')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsRuaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRuaModelJson = json.decode(response.body);
					return WmsRuaModel.fromJson(wmsRuaModelJson);
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
				Uri.tryParse('$endpoint/wms-rua/$pk')!,
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
