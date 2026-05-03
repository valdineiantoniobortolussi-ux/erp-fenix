import 'dart:convert';
import 'package:inventario/app/data/provider/api/api_provider_base.dart';
import 'package:inventario/app/data/model/model_imports.dart';

class InventarioAjusteCabApiProvider extends ApiProviderBase {

	Future<List<InventarioAjusteCabModel>?> getList({Filter? filter}) async {
		List<InventarioAjusteCabModel> inventarioAjusteCabModelList = [];

		try {
			handleFilter(filter, '/inventario-ajuste-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioAjusteCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var inventarioAjusteCabModel in inventarioAjusteCabModelJson) {
						inventarioAjusteCabModelList.add(InventarioAjusteCabModel.fromJson(inventarioAjusteCabModel));
					}
					return inventarioAjusteCabModelList;
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

	Future<InventarioAjusteCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/inventario-ajuste-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioAjusteCabModelJson = json.decode(response.body);
					return InventarioAjusteCabModel.fromJson(inventarioAjusteCabModelJson);		 
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

	Future<InventarioAjusteCabModel?>? insert(InventarioAjusteCabModel inventarioAjusteCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/inventario-ajuste-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: inventarioAjusteCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioAjusteCabModelJson = json.decode(response.body);
					return InventarioAjusteCabModel.fromJson(inventarioAjusteCabModelJson);
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

	Future<InventarioAjusteCabModel?>? update(InventarioAjusteCabModel inventarioAjusteCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/inventario-ajuste-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: inventarioAjusteCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var inventarioAjusteCabModelJson = json.decode(response.body);
					return InventarioAjusteCabModel.fromJson(inventarioAjusteCabModelJson);
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
				Uri.tryParse('$endpoint/inventario-ajuste-cab/$pk')!,
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
