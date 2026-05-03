import 'dart:convert';
import 'package:projetos/app/data/provider/api/api_provider_base.dart';
import 'package:projetos/app/data/model/model_imports.dart';

class ProjetoPrincipalApiProvider extends ApiProviderBase {

	Future<List<ProjetoPrincipalModel>?> getList({Filter? filter}) async {
		List<ProjetoPrincipalModel> projetoPrincipalModelList = [];

		try {
			handleFilter(filter, '/projeto-principal/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var projetoPrincipalModelJson = json.decode(response.body) as List<dynamic>;
					for (var projetoPrincipalModel in projetoPrincipalModelJson) {
						projetoPrincipalModelList.add(ProjetoPrincipalModel.fromJson(projetoPrincipalModel));
					}
					return projetoPrincipalModelList;
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

	Future<ProjetoPrincipalModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/projeto-principal/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var projetoPrincipalModelJson = json.decode(response.body);
					return ProjetoPrincipalModel.fromJson(projetoPrincipalModelJson);		 
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

	Future<ProjetoPrincipalModel?>? insert(ProjetoPrincipalModel projetoPrincipalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/projeto-principal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: projetoPrincipalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var projetoPrincipalModelJson = json.decode(response.body);
					return ProjetoPrincipalModel.fromJson(projetoPrincipalModelJson);
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

	Future<ProjetoPrincipalModel?>? update(ProjetoPrincipalModel projetoPrincipalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/projeto-principal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: projetoPrincipalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var projetoPrincipalModelJson = json.decode(response.body);
					return ProjetoPrincipalModel.fromJson(projetoPrincipalModelJson);
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
				Uri.tryParse('$endpoint/projeto-principal/$pk')!,
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
