import 'dart:convert';
import 'package:compras/app/data/provider/api/api_provider_base.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoPedidoApiProvider extends ApiProviderBase {

	Future<List<CompraTipoPedidoModel>?> getList({Filter? filter}) async {
		List<CompraTipoPedidoModel> compraTipoPedidoModelList = [];

		try {
			handleFilter(filter, '/compra-tipo-pedido/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoPedidoModelJson = json.decode(response.body) as List<dynamic>;
					for (var compraTipoPedidoModel in compraTipoPedidoModelJson) {
						compraTipoPedidoModelList.add(CompraTipoPedidoModel.fromJson(compraTipoPedidoModel));
					}
					return compraTipoPedidoModelList;
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

	Future<CompraTipoPedidoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/compra-tipo-pedido/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoPedidoModelJson = json.decode(response.body);
					return CompraTipoPedidoModel.fromJson(compraTipoPedidoModelJson);		 
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

	Future<CompraTipoPedidoModel?>? insert(CompraTipoPedidoModel compraTipoPedidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/compra-tipo-pedido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraTipoPedidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoPedidoModelJson = json.decode(response.body);
					return CompraTipoPedidoModel.fromJson(compraTipoPedidoModelJson);
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

	Future<CompraTipoPedidoModel?>? update(CompraTipoPedidoModel compraTipoPedidoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/compra-tipo-pedido')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraTipoPedidoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoPedidoModelJson = json.decode(response.body);
					return CompraTipoPedidoModel.fromJson(compraTipoPedidoModelJson);
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
				Uri.tryParse('$endpoint/compra-tipo-pedido/$pk')!,
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
