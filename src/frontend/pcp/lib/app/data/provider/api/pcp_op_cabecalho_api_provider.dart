import 'dart:convert';
import 'package:pcp/app/data/provider/api/api_provider_base.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpOpCabecalhoApiProvider extends ApiProviderBase {

	Future<List<PcpOpCabecalhoModel>?> getList({Filter? filter}) async {
		List<PcpOpCabecalhoModel> pcpOpCabecalhoModelList = [];

		try {
			handleFilter(filter, '/pcp-op-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpOpCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var pcpOpCabecalhoModel in pcpOpCabecalhoModelJson) {
						pcpOpCabecalhoModelList.add(PcpOpCabecalhoModel.fromJson(pcpOpCabecalhoModel));
					}
					return pcpOpCabecalhoModelList;
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

	Future<PcpOpCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/pcp-op-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpOpCabecalhoModelJson = json.decode(response.body);
					return PcpOpCabecalhoModel.fromJson(pcpOpCabecalhoModelJson);		 
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

	Future<PcpOpCabecalhoModel?>? insert(PcpOpCabecalhoModel pcpOpCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/pcp-op-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpOpCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpOpCabecalhoModelJson = json.decode(response.body);
					return PcpOpCabecalhoModel.fromJson(pcpOpCabecalhoModelJson);
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

	Future<PcpOpCabecalhoModel?>? update(PcpOpCabecalhoModel pcpOpCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/pcp-op-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpOpCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpOpCabecalhoModelJson = json.decode(response.body);
					return PcpOpCabecalhoModel.fromJson(pcpOpCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/pcp-op-cabecalho/$pk')!,
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
