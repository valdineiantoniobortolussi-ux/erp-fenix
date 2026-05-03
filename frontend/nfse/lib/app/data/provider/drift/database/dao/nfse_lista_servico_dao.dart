import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/provider/drift/database/database_imports.dart';

part 'nfse_lista_servico_dao.g.dart';

@DriftAccessor(tables: [
	NfseListaServicos,
])
class NfseListaServicoDao extends DatabaseAccessor<AppDatabase> with _$NfseListaServicoDaoMixin {
	final AppDatabase db;

	List<NfseListaServico> nfseListaServicoList = []; 
	List<NfseListaServicoGrouped> nfseListaServicoGroupedList = []; 

	NfseListaServicoDao(this.db) : super(db);

	Future<List<NfseListaServico>> getList() async {
		nfseListaServicoList = await select(nfseListaServicos).get();
		return nfseListaServicoList;
	}

	Future<List<NfseListaServico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfseListaServicoList = await (select(nfseListaServicos)..where((t) => expression)).get();
		return nfseListaServicoList;	 
	}

	Future<List<NfseListaServicoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfseListaServicos)
			.join([]);

		if (field != null && field != '') { 
			final column = nfseListaServicos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfseListaServicoGroupedList = await query.map((row) {
			final nfseListaServico = row.readTableOrNull(nfseListaServicos); 

			return NfseListaServicoGrouped(
				nfseListaServico: nfseListaServico, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfseListaServicoGrouped in nfseListaServicoGroupedList) {
		//}		

		return nfseListaServicoGroupedList;	
	}

	Future<NfseListaServico?> getObject(dynamic pk) async {
		return await (select(nfseListaServicos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfseListaServico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfse_lista_servico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfseListaServico;		 
	} 

	Future<NfseListaServicoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfseListaServicoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfseListaServico = object.nfseListaServico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfseListaServicos).insert(object.nfseListaServico!);
			object.nfseListaServico = object.nfseListaServico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfseListaServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfseListaServicos).replace(object.nfseListaServico!);
		});	 
	} 

	Future<int> deleteObject(NfseListaServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfseListaServicos).delete(object.nfseListaServico!);
		});		
	}

	Future<void> insertChildren(NfseListaServicoGrouped object) async {
	}
	
	Future<void> deleteChildren(NfseListaServicoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfse_lista_servico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}