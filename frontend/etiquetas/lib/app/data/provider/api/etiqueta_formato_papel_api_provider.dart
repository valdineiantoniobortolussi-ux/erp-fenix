import 'dart:convert';
import 'package:etiquetas/app/data/provider/api/api_provider_base.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaFormatoPapelApiProvider extends ApiProviderBase {

	Future<List<EtiquetaFormatoPapelModel>?> getList({Filter? filter}) async {
		List<EtiquetaFormatoPapelModel> etiquetaFormatoPapelModelList = [];

		try {
			handleFilter(filter, '/etiqueta-formato-papel/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaFormatoPapelModelJson = json.decode(response.body) as List<dynamic>;
					for (var etiquetaFormatoPapelModel in etiquetaFormatoPapelModelJson) {
						etiquetaFormatoPapelModelList.add(EtiquetaFormatoPapelModel.fromJson(etiquetaFormatoPapelModel));
					}
					return etiquetaFormatoPapelModelList;
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

	Future<EtiquetaFormatoPapelModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/etiqueta-formato-papel/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaFormatoPapelModelJson = json.decode(response.body);
					return EtiquetaFormatoPapelModel.fromJson(etiquetaFormatoPapelModelJson);		 
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

	Future<EtiquetaFormatoPapelModel?>? insert(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/etiqueta-formato-papel')!,
				headers: ApiProviderBase.headerRequisition(),
				body: etiquetaFormatoPapelModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaFormatoPapelModelJson = json.decode(response.body);
					return EtiquetaFormatoPapelModel.fromJson(etiquetaFormatoPapelModelJson);
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

	Future<EtiquetaFormatoPapelModel?>? update(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/etiqueta-formato-papel')!,
				headers: ApiProviderBase.headerRequisition(),
				body: etiquetaFormatoPapelModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var etiquetaFormatoPapelModelJson = json.decode(response.body);
					return EtiquetaFormatoPapelModel.fromJson(etiquetaFormatoPapelModelJson);
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
				Uri.tryParse('$endpoint/etiqueta-formato-papel/$pk')!,
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
