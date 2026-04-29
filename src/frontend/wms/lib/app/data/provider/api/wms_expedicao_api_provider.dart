import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsExpedicaoApiProvider extends ApiProviderBase {

	Future<List<WmsExpedicaoModel>?> getList({Filter? filter}) async {
		List<WmsExpedicaoModel> wmsExpedicaoModelList = [];

		try {
			handleFilter(filter, '/wms-expedicao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsExpedicaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsExpedicaoModel in wmsExpedicaoModelJson) {
						wmsExpedicaoModelList.add(WmsExpedicaoModel.fromJson(wmsExpedicaoModel));
					}
					return wmsExpedicaoModelList;
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

	Future<WmsExpedicaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-expedicao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsExpedicaoModelJson = json.decode(response.body);
					return WmsExpedicaoModel.fromJson(wmsExpedicaoModelJson);		 
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

	Future<WmsExpedicaoModel?>? insert(WmsExpedicaoModel wmsExpedicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-expedicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsExpedicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsExpedicaoModelJson = json.decode(response.body);
					return WmsExpedicaoModel.fromJson(wmsExpedicaoModelJson);
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

	Future<WmsExpedicaoModel?>? update(WmsExpedicaoModel wmsExpedicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-expedicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsExpedicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsExpedicaoModelJson = json.decode(response.body);
					return WmsExpedicaoModel.fromJson(wmsExpedicaoModelJson);
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
				Uri.tryParse('$endpoint/wms-expedicao/$pk')!,
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
