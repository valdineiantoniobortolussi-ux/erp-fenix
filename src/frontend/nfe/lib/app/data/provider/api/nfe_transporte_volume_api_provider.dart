import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeApiProvider extends ApiProviderBase {

	Future<List<NfeTransporteVolumeModel>?> getList({Filter? filter}) async {
		List<NfeTransporteVolumeModel> nfeTransporteVolumeModelList = [];

		try {
			handleFilter(filter, '/nfe-transporte-volume/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeTransporteVolumeModel in nfeTransporteVolumeModelJson) {
						nfeTransporteVolumeModelList.add(NfeTransporteVolumeModel.fromJson(nfeTransporteVolumeModel));
					}
					return nfeTransporteVolumeModelList;
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

	Future<NfeTransporteVolumeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-transporte-volume/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeModelJson = json.decode(response.body);
					return NfeTransporteVolumeModel.fromJson(nfeTransporteVolumeModelJson);		 
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

	Future<NfeTransporteVolumeModel?>? insert(NfeTransporteVolumeModel nfeTransporteVolumeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-transporte-volume')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteVolumeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeModelJson = json.decode(response.body);
					return NfeTransporteVolumeModel.fromJson(nfeTransporteVolumeModelJson);
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

	Future<NfeTransporteVolumeModel?>? update(NfeTransporteVolumeModel nfeTransporteVolumeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-transporte-volume')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteVolumeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteVolumeModelJson = json.decode(response.body);
					return NfeTransporteVolumeModel.fromJson(nfeTransporteVolumeModelJson);
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
				Uri.tryParse('$endpoint/nfe-transporte-volume/$pk')!,
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
