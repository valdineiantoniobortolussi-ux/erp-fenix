import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class EmpresaTransporteApiProvider extends ApiProviderBase {

	Future<List<EmpresaTransporteModel>?> getList({Filter? filter}) async {
		List<EmpresaTransporteModel> empresaTransporteModelList = [];

		try {
			handleFilter(filter, '/empresa-transporte/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaTransporteModelJson = json.decode(response.body) as List<dynamic>;
					for (var empresaTransporteModel in empresaTransporteModelJson) {
						empresaTransporteModelList.add(EmpresaTransporteModel.fromJson(empresaTransporteModel));
					}
					return empresaTransporteModelList;
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

	Future<EmpresaTransporteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/empresa-transporte/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaTransporteModelJson = json.decode(response.body);
					return EmpresaTransporteModel.fromJson(empresaTransporteModelJson);		 
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

	Future<EmpresaTransporteModel?>? insert(EmpresaTransporteModel empresaTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/empresa-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: empresaTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaTransporteModelJson = json.decode(response.body);
					return EmpresaTransporteModel.fromJson(empresaTransporteModelJson);
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

	Future<EmpresaTransporteModel?>? update(EmpresaTransporteModel empresaTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/empresa-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: empresaTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var empresaTransporteModelJson = json.decode(response.body);
					return EmpresaTransporteModel.fromJson(empresaTransporteModelJson);
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
				Uri.tryParse('$endpoint/empresa-transporte/$pk')!,
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
