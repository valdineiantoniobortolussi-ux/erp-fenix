import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class TalonarioChequeApiProvider extends ApiProviderBase {

	Future<List<TalonarioChequeModel>?> getList({Filter? filter}) async {
		List<TalonarioChequeModel> talonarioChequeModelList = [];

		try {
			handleFilter(filter, '/talonario-cheque/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var talonarioChequeModelJson = json.decode(response.body) as List<dynamic>;
					for (var talonarioChequeModel in talonarioChequeModelJson) {
						talonarioChequeModelList.add(TalonarioChequeModel.fromJson(talonarioChequeModel));
					}
					return talonarioChequeModelList;
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

	Future<TalonarioChequeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/talonario-cheque/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var talonarioChequeModelJson = json.decode(response.body);
					return TalonarioChequeModel.fromJson(talonarioChequeModelJson);		 
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

	Future<TalonarioChequeModel?>? insert(TalonarioChequeModel talonarioChequeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/talonario-cheque')!,
				headers: ApiProviderBase.headerRequisition(),
				body: talonarioChequeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var talonarioChequeModelJson = json.decode(response.body);
					return TalonarioChequeModel.fromJson(talonarioChequeModelJson);
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

	Future<TalonarioChequeModel?>? update(TalonarioChequeModel talonarioChequeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/talonario-cheque')!,
				headers: ApiProviderBase.headerRequisition(),
				body: talonarioChequeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var talonarioChequeModelJson = json.decode(response.body);
					return TalonarioChequeModel.fromJson(talonarioChequeModelJson);
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
				Uri.tryParse('$endpoint/talonario-cheque/$pk')!,
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
