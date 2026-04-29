import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsRecebimentoCabecalhoApiProvider extends ApiProviderBase {

	Future<List<WmsRecebimentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<WmsRecebimentoCabecalhoModel> wmsRecebimentoCabecalhoModelList = [];

		try {
			handleFilter(filter, '/wms-recebimento-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRecebimentoCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsRecebimentoCabecalhoModel in wmsRecebimentoCabecalhoModelJson) {
						wmsRecebimentoCabecalhoModelList.add(WmsRecebimentoCabecalhoModel.fromJson(wmsRecebimentoCabecalhoModel));
					}
					return wmsRecebimentoCabecalhoModelList;
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

	Future<WmsRecebimentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-recebimento-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRecebimentoCabecalhoModelJson = json.decode(response.body);
					return WmsRecebimentoCabecalhoModel.fromJson(wmsRecebimentoCabecalhoModelJson);		 
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

	Future<WmsRecebimentoCabecalhoModel?>? insert(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-recebimento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsRecebimentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRecebimentoCabecalhoModelJson = json.decode(response.body);
					return WmsRecebimentoCabecalhoModel.fromJson(wmsRecebimentoCabecalhoModelJson);
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

	Future<WmsRecebimentoCabecalhoModel?>? update(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-recebimento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsRecebimentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsRecebimentoCabecalhoModelJson = json.decode(response.body);
					return WmsRecebimentoCabecalhoModel.fromJson(wmsRecebimentoCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/wms-recebimento-cabecalho/$pk')!,
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
