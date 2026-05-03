import 'dart:convert';
import 'package:administrativo/app/data/provider/api/api_provider_base.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaApiProvider extends ApiProviderBase {

	Future<List<EmpresaModel>?> getList({Filter? filter}) async {
		List<EmpresaModel> empresaModelList = [];

		try {
			handleFilter(filter, '/empresa/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaModelJson = json.decode(response.body) as List<dynamic>;
					for (var empresaModel in empresaModelJson) {
						empresaModelList.add(EmpresaModel.fromJson(empresaModel));
					}
					return empresaModelList;
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

	Future<EmpresaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/empresa/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaModelJson = json.decode(response.body);
					return EmpresaModel.fromJson(empresaModelJson);		 
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

	Future<EmpresaModel?>? insert(EmpresaModel empresaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/empresa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: empresaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaModelJson = json.decode(response.body);
					return EmpresaModel.fromJson(empresaModelJson);
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

	Future<EmpresaModel?>? update(EmpresaModel empresaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/empresa')!,
				headers: ApiProviderBase.headerRequisition(),
				body: empresaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaModelJson = json.decode(response.body);
					return EmpresaModel.fromJson(empresaModelJson);
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
				Uri.tryParse('$endpoint/empresa/$pk')!,
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

	Future<EmpresaModel?> getEmpresaPorCnpj(dynamic cnpj) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpointSh/empresa/cnpj/$cnpj')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaModelJson = json.decode(response.body);
					return EmpresaModel.fromJson(empresaModelJson);		 
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
}
