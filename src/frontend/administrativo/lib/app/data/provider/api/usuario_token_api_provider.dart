import 'dart:convert';
import 'package:administrativo/app/data/provider/api/api_provider_base.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class UsuarioTokenApiProvider extends ApiProviderBase {

	Future<List<UsuarioTokenModel>?> getList({Filter? filter}) async {
		List<UsuarioTokenModel> usuarioTokenModelList = [];

		try {
			handleFilter(filter, '/usuario-token/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var usuarioTokenModelJson = json.decode(response.body) as List<dynamic>;
					for (var usuarioTokenModel in usuarioTokenModelJson) {
						usuarioTokenModelList.add(UsuarioTokenModel.fromJson(usuarioTokenModel));
					}
					return usuarioTokenModelList;
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

	Future<UsuarioTokenModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/usuario-token/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var usuarioTokenModelJson = json.decode(response.body);
					return UsuarioTokenModel.fromJson(usuarioTokenModelJson);		 
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

	Future<UsuarioTokenModel?>? insert(UsuarioTokenModel usuarioTokenModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/usuario-token')!,
				headers: ApiProviderBase.headerRequisition(),
				body: usuarioTokenModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var usuarioTokenModelJson = json.decode(response.body);
					return UsuarioTokenModel.fromJson(usuarioTokenModelJson);
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

	Future<UsuarioTokenModel?>? update(UsuarioTokenModel usuarioTokenModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/usuario-token')!,
				headers: ApiProviderBase.headerRequisition(),
				body: usuarioTokenModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var usuarioTokenModelJson = json.decode(response.body);
					return UsuarioTokenModel.fromJson(usuarioTokenModelJson);
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
				Uri.tryParse('$endpoint/usuario-token/$pk')!,
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
