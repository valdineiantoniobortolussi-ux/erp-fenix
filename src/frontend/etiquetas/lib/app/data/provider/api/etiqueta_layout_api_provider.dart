import 'dart:convert';
import 'package:etiquetas/app/data/provider/api/api_provider_base.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaLayoutApiProvider extends ApiProviderBase {

	Future<List<EtiquetaLayoutModel>?> getList({Filter? filter}) async {
		List<EtiquetaLayoutModel> etiquetaLayoutModelList = [];

		try {
			handleFilter(filter, '/etiqueta-layout/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaLayoutModelJson = json.decode(response.body) as List<dynamic>;
					for (var etiquetaLayoutModel in etiquetaLayoutModelJson) {
						etiquetaLayoutModelList.add(EtiquetaLayoutModel.fromJson(etiquetaLayoutModel));
					}
					return etiquetaLayoutModelList;
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

	Future<EtiquetaLayoutModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/etiqueta-layout/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaLayoutModelJson = json.decode(response.body);
					return EtiquetaLayoutModel.fromJson(etiquetaLayoutModelJson);		 
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

	Future<EtiquetaLayoutModel?>? insert(EtiquetaLayoutModel etiquetaLayoutModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/etiqueta-layout')!,
				headers: ApiProviderBase.headerRequisition(),
				body: etiquetaLayoutModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaLayoutModelJson = json.decode(response.body);
					return EtiquetaLayoutModel.fromJson(etiquetaLayoutModelJson);
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

	Future<EtiquetaLayoutModel?>? update(EtiquetaLayoutModel etiquetaLayoutModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/etiqueta-layout')!,
				headers: ApiProviderBase.headerRequisition(),
				body: etiquetaLayoutModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaLayoutModelJson = json.decode(response.body);
					return EtiquetaLayoutModel.fromJson(etiquetaLayoutModelJson);
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
				Uri.tryParse('$endpoint/etiqueta-layout/$pk')!,
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
