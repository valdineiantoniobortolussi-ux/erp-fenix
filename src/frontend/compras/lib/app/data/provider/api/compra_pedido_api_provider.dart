import 'dart:convert';
import 'package:compras/app/data/provider/api/api_provider_base.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraPedidoApiProvider extends ApiProviderBase {

	Future<List<CompraPedidoModel>?> getList({Filter? filter}) async {
		List<CompraPedidoModel> compraPedidoModelList = [];

		try {
			handleFilter(filter, '/compra-pedido/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraPedidoModelJson = json.decode(response.body) as List<dynamic>;
					for (var compraPedidoModel in compraPedidoModelJson) {
						compraPedidoModelList.add(CompraPedidoModel.fromJson(compraPedidoModel));
					}
					return compraPedidoModelList;
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

	Future<CompraPedidoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/compra-pedido/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraPedidoModelJson = json.decode(response.body);
					return CompraPedidoModel.fromJson(compraPedidoModelJson);		 
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

	Future<CompraPedidoModel?>? insert(CompraPedidoModel compraPedidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/compra-pedido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraPedidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraPedidoModelJson = json.decode(response.body);
					return CompraPedidoModel.fromJson(compraPedidoModelJson);
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

	Future<CompraPedidoModel?>? update(CompraPedidoModel compraPedidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/compra-pedido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraPedidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraPedidoModelJson = json.decode(response.body);
					return CompraPedidoModel.fromJson(compraPedidoModelJson);
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
				Uri.tryParse('$endpoint/compra-pedido/$pk')!,
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
