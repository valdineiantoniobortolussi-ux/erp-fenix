import 'dart:convert';
import 'package:compras/app/data/provider/api/api_provider_base.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoRequisicaoApiProvider extends ApiProviderBase {

	Future<List<CompraTipoRequisicaoModel>?> getList({Filter? filter}) async {
		List<CompraTipoRequisicaoModel> compraTipoRequisicaoModelList = [];

		try {
			handleFilter(filter, '/compra-tipo-requisicao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoRequisicaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var compraTipoRequisicaoModel in compraTipoRequisicaoModelJson) {
						compraTipoRequisicaoModelList.add(CompraTipoRequisicaoModel.fromJson(compraTipoRequisicaoModel));
					}
					return compraTipoRequisicaoModelList;
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

	Future<CompraTipoRequisicaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/compra-tipo-requisicao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoRequisicaoModelJson = json.decode(response.body);
					return CompraTipoRequisicaoModel.fromJson(compraTipoRequisicaoModelJson);		 
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

	Future<CompraTipoRequisicaoModel?>? insert(CompraTipoRequisicaoModel compraTipoRequisicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/compra-tipo-requisicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraTipoRequisicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoRequisicaoModelJson = json.decode(response.body);
					return CompraTipoRequisicaoModel.fromJson(compraTipoRequisicaoModelJson);
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

	Future<CompraTipoRequisicaoModel?>? update(CompraTipoRequisicaoModel compraTipoRequisicaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/compra-tipo-requisicao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: compraTipoRequisicaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var compraTipoRequisicaoModelJson = json.decode(response.body);
					return CompraTipoRequisicaoModel.fromJson(compraTipoRequisicaoModelJson);
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
				Uri.tryParse('$endpoint/compra-tipo-requisicao/$pk')!,
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
