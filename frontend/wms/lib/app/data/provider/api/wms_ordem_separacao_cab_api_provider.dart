import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsOrdemSeparacaoCabApiProvider extends ApiProviderBase {

	Future<List<WmsOrdemSeparacaoCabModel>?> getList({Filter? filter}) async {
		List<WmsOrdemSeparacaoCabModel> wmsOrdemSeparacaoCabModelList = [];

		try {
			handleFilter(filter, '/wms-ordem-separacao-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsOrdemSeparacaoCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsOrdemSeparacaoCabModel in wmsOrdemSeparacaoCabModelJson) {
						wmsOrdemSeparacaoCabModelList.add(WmsOrdemSeparacaoCabModel.fromJson(wmsOrdemSeparacaoCabModel));
					}
					return wmsOrdemSeparacaoCabModelList;
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

	Future<WmsOrdemSeparacaoCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-ordem-separacao-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsOrdemSeparacaoCabModelJson = json.decode(response.body);
					return WmsOrdemSeparacaoCabModel.fromJson(wmsOrdemSeparacaoCabModelJson);		 
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

	Future<WmsOrdemSeparacaoCabModel?>? insert(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-ordem-separacao-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsOrdemSeparacaoCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsOrdemSeparacaoCabModelJson = json.decode(response.body);
					return WmsOrdemSeparacaoCabModel.fromJson(wmsOrdemSeparacaoCabModelJson);
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

	Future<WmsOrdemSeparacaoCabModel?>? update(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-ordem-separacao-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsOrdemSeparacaoCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsOrdemSeparacaoCabModelJson = json.decode(response.body);
					return WmsOrdemSeparacaoCabModel.fromJson(wmsOrdemSeparacaoCabModelJson);
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
				Uri.tryParse('$endpoint/wms-ordem-separacao-cab/$pk')!,
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
