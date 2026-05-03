import 'dart:convert';
import 'package:comissoes/app/data/provider/api/api_provider_base.dart';
import 'package:comissoes/app/data/model/model_imports.dart';

class ComissaoPerfilApiProvider extends ApiProviderBase {

	Future<List<ComissaoPerfilModel>?> getList({Filter? filter}) async {
		List<ComissaoPerfilModel> comissaoPerfilModelList = [];

		try {
			handleFilter(filter, '/comissao-perfil/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoPerfilModelJson = json.decode(response.body) as List<dynamic>;
					for (var comissaoPerfilModel in comissaoPerfilModelJson) {
						comissaoPerfilModelList.add(ComissaoPerfilModel.fromJson(comissaoPerfilModel));
					}
					return comissaoPerfilModelList;
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

	Future<ComissaoPerfilModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/comissao-perfil/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoPerfilModelJson = json.decode(response.body);
					return ComissaoPerfilModel.fromJson(comissaoPerfilModelJson);		 
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

	Future<ComissaoPerfilModel?>? insert(ComissaoPerfilModel comissaoPerfilModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/comissao-perfil')!,
				headers: ApiProviderBase.headerRequisition(),
				body: comissaoPerfilModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoPerfilModelJson = json.decode(response.body);
					return ComissaoPerfilModel.fromJson(comissaoPerfilModelJson);
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

	Future<ComissaoPerfilModel?>? update(ComissaoPerfilModel comissaoPerfilModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/comissao-perfil')!,
				headers: ApiProviderBase.headerRequisition(),
				body: comissaoPerfilModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var comissaoPerfilModelJson = json.decode(response.body);
					return ComissaoPerfilModel.fromJson(comissaoPerfilModelJson);
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
				Uri.tryParse('$endpoint/comissao-perfil/$pk')!,
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
