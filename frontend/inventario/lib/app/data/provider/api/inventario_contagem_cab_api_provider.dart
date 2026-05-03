import 'dart:convert';
import 'package:inventario/app/data/provider/api/api_provider_base.dart';
import 'package:inventario/app/data/model/model_imports.dart';

class InventarioContagemCabApiProvider extends ApiProviderBase {

	Future<List<InventarioContagemCabModel>?> getList({Filter? filter}) async {
		List<InventarioContagemCabModel> inventarioContagemCabModelList = [];

		try {
			handleFilter(filter, '/inventario-contagem-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioContagemCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var inventarioContagemCabModel in inventarioContagemCabModelJson) {
						inventarioContagemCabModelList.add(InventarioContagemCabModel.fromJson(inventarioContagemCabModel));
					}
					return inventarioContagemCabModelList;
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

	Future<InventarioContagemCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/inventario-contagem-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioContagemCabModelJson = json.decode(response.body);
					return InventarioContagemCabModel.fromJson(inventarioContagemCabModelJson);		 
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

	Future<InventarioContagemCabModel?>? insert(InventarioContagemCabModel inventarioContagemCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/inventario-contagem-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: inventarioContagemCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioContagemCabModelJson = json.decode(response.body);
					return InventarioContagemCabModel.fromJson(inventarioContagemCabModelJson);
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

	Future<InventarioContagemCabModel?>? update(InventarioContagemCabModel inventarioContagemCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/inventario-contagem-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: inventarioContagemCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioContagemCabModelJson = json.decode(response.body);
					return InventarioContagemCabModel.fromJson(inventarioContagemCabModelJson);
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
				Uri.tryParse('$endpoint/inventario-contagem-cab/$pk')!,
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
