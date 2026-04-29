import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeLacreApiProvider extends ApiProviderBase {

	Future<List<NfeTransporteVolumeLacreModel>?> getList({Filter? filter}) async {
		List<NfeTransporteVolumeLacreModel> nfeTransporteVolumeLacreModelList = [];

		try {
			handleFilter(filter, '/nfe-transporte-volume-lacre/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeLacreModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeTransporteVolumeLacreModel in nfeTransporteVolumeLacreModelJson) {
						nfeTransporteVolumeLacreModelList.add(NfeTransporteVolumeLacreModel.fromJson(nfeTransporteVolumeLacreModel));
					}
					return nfeTransporteVolumeLacreModelList;
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

	Future<NfeTransporteVolumeLacreModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-transporte-volume-lacre/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeLacreModelJson = json.decode(response.body);
					return NfeTransporteVolumeLacreModel.fromJson(nfeTransporteVolumeLacreModelJson);		 
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

	Future<NfeTransporteVolumeLacreModel?>? insert(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-transporte-volume-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteVolumeLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeLacreModelJson = json.decode(response.body);
					return NfeTransporteVolumeLacreModel.fromJson(nfeTransporteVolumeLacreModelJson);
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

	Future<NfeTransporteVolumeLacreModel?>? update(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-transporte-volume-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteVolumeLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeLacreModelJson = json.decode(response.body);
					return NfeTransporteVolumeLacreModel.fromJson(nfeTransporteVolumeLacreModelJson);
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
				Uri.tryParse('$endpoint/nfe-transporte-volume-lacre/$pk')!,
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
