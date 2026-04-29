import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoAdmissaoApiProvider extends ApiProviderBase {

	Future<List<TipoAdmissaoModel>?> getList({Filter? filter}) async {
		List<TipoAdmissaoModel> tipoAdmissaoModelList = [];

		try {
			handleFilter(filter, '/tipo-admissao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoAdmissaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var tipoAdmissaoModel in tipoAdmissaoModelJson) {
						tipoAdmissaoModelList.add(TipoAdmissaoModel.fromJson(tipoAdmissaoModel));
					}
					return tipoAdmissaoModelList;
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

	Future<TipoAdmissaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tipo-admissao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoAdmissaoModelJson = json.decode(response.body);
					return TipoAdmissaoModel.fromJson(tipoAdmissaoModelJson);		 
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

	Future<TipoAdmissaoModel?>? insert(TipoAdmissaoModel tipoAdmissaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tipo-admissao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tipoAdmissaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoAdmissaoModelJson = json.decode(response.body);
					return TipoAdmissaoModel.fromJson(tipoAdmissaoModelJson);
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

	Future<TipoAdmissaoModel?>? update(TipoAdmissaoModel tipoAdmissaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tipo-admissao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tipoAdmissaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoAdmissaoModelJson = json.decode(response.body);
					return TipoAdmissaoModel.fromJson(tipoAdmissaoModelJson);
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
				Uri.tryParse('$endpoint/tipo-admissao/$pk')!,
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
