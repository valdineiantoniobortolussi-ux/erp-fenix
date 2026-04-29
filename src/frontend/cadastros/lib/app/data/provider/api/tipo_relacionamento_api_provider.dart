import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoRelacionamentoApiProvider extends ApiProviderBase {

	Future<List<TipoRelacionamentoModel>?> getList({Filter? filter}) async {
		List<TipoRelacionamentoModel> tipoRelacionamentoModelList = [];

		try {
			handleFilter(filter, '/tipo-relacionamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoRelacionamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var tipoRelacionamentoModel in tipoRelacionamentoModelJson) {
						tipoRelacionamentoModelList.add(TipoRelacionamentoModel.fromJson(tipoRelacionamentoModel));
					}
					return tipoRelacionamentoModelList;
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

	Future<TipoRelacionamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tipo-relacionamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoRelacionamentoModelJson = json.decode(response.body);
					return TipoRelacionamentoModel.fromJson(tipoRelacionamentoModelJson);		 
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

	Future<TipoRelacionamentoModel?>? insert(TipoRelacionamentoModel tipoRelacionamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tipo-relacionamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tipoRelacionamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoRelacionamentoModelJson = json.decode(response.body);
					return TipoRelacionamentoModel.fromJson(tipoRelacionamentoModelJson);
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

	Future<TipoRelacionamentoModel?>? update(TipoRelacionamentoModel tipoRelacionamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tipo-relacionamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tipoRelacionamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tipoRelacionamentoModelJson = json.decode(response.body);
					return TipoRelacionamentoModel.fromJson(tipoRelacionamentoModelJson);
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
				Uri.tryParse('$endpoint/tipo-relacionamento/$pk')!,
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
