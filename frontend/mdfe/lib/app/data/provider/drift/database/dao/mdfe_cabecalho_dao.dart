import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	MdfeCabecalhos,
	MdfeLacres,
	MdfeMunicipioDescarregas,
	MdfeEmitentes,
	MdfePercursos,
	MdfeMunicipioCarregamentos,
	MdfeRodoviarios,
	MdfeInformacaoSeguros,
])
class MdfeCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$MdfeCabecalhoDaoMixin {
	final AppDatabase db;

	List<MdfeCabecalho> mdfeCabecalhoList = []; 
	List<MdfeCabecalhoGrouped> mdfeCabecalhoGroupedList = []; 

	MdfeCabecalhoDao(this.db) : super(db);

	Future<List<MdfeCabecalho>> getList() async {
		mdfeCabecalhoList = await select(mdfeCabecalhos).get();
		return mdfeCabecalhoList;
	}

	Future<List<MdfeCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeCabecalhoList = await (select(mdfeCabecalhos)..where((t) => expression)).get();
		return mdfeCabecalhoList;	 
	}

	Future<List<MdfeCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = mdfeCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeCabecalhoGroupedList = await query.map((row) {
			final mdfeCabecalho = row.readTableOrNull(mdfeCabecalhos); 

			return MdfeCabecalhoGrouped(
				mdfeCabecalho: mdfeCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var mdfeCabecalhoGrouped in mdfeCabecalhoGroupedList) {
			mdfeCabecalhoGrouped.mdfeLacreGroupedList = [];
			final queryMdfeLacre = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeLacre);
			final mdfeLacreList = await (select(mdfeLacres)..where((t) => expression)).get();
			for (var mdfeLacre in mdfeLacreList) {
				MdfeLacreGrouped mdfeLacreGrouped = MdfeLacreGrouped(
					mdfeLacre: mdfeLacre,
				);
				mdfeCabecalhoGrouped.mdfeLacreGroupedList!.add(mdfeLacreGrouped);
			}

			mdfeCabecalhoGrouped.mdfeMunicipioDescarregaGroupedList = [];
			final queryMdfeMunicipioDescarrega = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeMunicipioDescarrega);
			final mdfeMunicipioDescarregaList = await (select(mdfeMunicipioDescarregas)..where((t) => expression)).get();
			for (var mdfeMunicipioDescarrega in mdfeMunicipioDescarregaList) {
				MdfeMunicipioDescarregaGrouped mdfeMunicipioDescarregaGrouped = MdfeMunicipioDescarregaGrouped(
					mdfeMunicipioDescarrega: mdfeMunicipioDescarrega,
				);
				mdfeCabecalhoGrouped.mdfeMunicipioDescarregaGroupedList!.add(mdfeMunicipioDescarregaGrouped);
			}

			mdfeCabecalhoGrouped.mdfeEmitenteGroupedList = [];
			final queryMdfeEmitente = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeEmitente);
			final mdfeEmitenteList = await (select(mdfeEmitentes)..where((t) => expression)).get();
			for (var mdfeEmitente in mdfeEmitenteList) {
				MdfeEmitenteGrouped mdfeEmitenteGrouped = MdfeEmitenteGrouped(
					mdfeEmitente: mdfeEmitente,
				);
				mdfeCabecalhoGrouped.mdfeEmitenteGroupedList!.add(mdfeEmitenteGrouped);
			}

			mdfeCabecalhoGrouped.mdfePercursoGroupedList = [];
			final queryMdfePercurso = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfePercurso);
			final mdfePercursoList = await (select(mdfePercursos)..where((t) => expression)).get();
			for (var mdfePercurso in mdfePercursoList) {
				MdfePercursoGrouped mdfePercursoGrouped = MdfePercursoGrouped(
					mdfePercurso: mdfePercurso,
				);
				mdfeCabecalhoGrouped.mdfePercursoGroupedList!.add(mdfePercursoGrouped);
			}

			mdfeCabecalhoGrouped.mdfeMunicipioCarregamentoGroupedList = [];
			final queryMdfeMunicipioCarregamento = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeMunicipioCarregamento);
			final mdfeMunicipioCarregamentoList = await (select(mdfeMunicipioCarregamentos)..where((t) => expression)).get();
			for (var mdfeMunicipioCarregamento in mdfeMunicipioCarregamentoList) {
				MdfeMunicipioCarregamentoGrouped mdfeMunicipioCarregamentoGrouped = MdfeMunicipioCarregamentoGrouped(
					mdfeMunicipioCarregamento: mdfeMunicipioCarregamento,
				);
				mdfeCabecalhoGrouped.mdfeMunicipioCarregamentoGroupedList!.add(mdfeMunicipioCarregamentoGrouped);
			}

			mdfeCabecalhoGrouped.mdfeRodoviarioGroupedList = [];
			final queryMdfeRodoviario = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeRodoviario);
			final mdfeRodoviarioList = await (select(mdfeRodoviarios)..where((t) => expression)).get();
			for (var mdfeRodoviario in mdfeRodoviarioList) {
				MdfeRodoviarioGrouped mdfeRodoviarioGrouped = MdfeRodoviarioGrouped(
					mdfeRodoviario: mdfeRodoviario,
				);
				mdfeCabecalhoGrouped.mdfeRodoviarioGroupedList!.add(mdfeRodoviarioGrouped);
			}

			mdfeCabecalhoGrouped.mdfeInformacaoSeguroGroupedList = [];
			final queryMdfeInformacaoSeguro = ' id_mdfe_cabecalho = ${mdfeCabecalhoGrouped.mdfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryMdfeInformacaoSeguro);
			final mdfeInformacaoSeguroList = await (select(mdfeInformacaoSeguros)..where((t) => expression)).get();
			for (var mdfeInformacaoSeguro in mdfeInformacaoSeguroList) {
				MdfeInformacaoSeguroGrouped mdfeInformacaoSeguroGrouped = MdfeInformacaoSeguroGrouped(
					mdfeInformacaoSeguro: mdfeInformacaoSeguro,
				);
				mdfeCabecalhoGrouped.mdfeInformacaoSeguroGroupedList!.add(mdfeInformacaoSeguroGrouped);
			}

		}		

		return mdfeCabecalhoGroupedList;	
	}

	Future<MdfeCabecalho?> getObject(dynamic pk) async {
		return await (select(mdfeCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeCabecalho;		 
	} 

	Future<MdfeCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeCabecalho = object.mdfeCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeCabecalhos).insert(object.mdfeCabecalho!);
			object.mdfeCabecalho = object.mdfeCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeCabecalhos).replace(object.mdfeCabecalho!);
		});	 
	} 

	Future<int> deleteObject(MdfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeCabecalhos).delete(object.mdfeCabecalho!);
		});		
	}

	Future<void> insertChildren(MdfeCabecalhoGrouped object) async {
		for (var mdfeLacreGrouped in object.mdfeLacreGroupedList!) {
			mdfeLacreGrouped.mdfeLacre = mdfeLacreGrouped.mdfeLacre?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeLacres).insert(mdfeLacreGrouped.mdfeLacre!);
		}
		for (var mdfeMunicipioDescarregaGrouped in object.mdfeMunicipioDescarregaGroupedList!) {
			mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega = mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeMunicipioDescarregas).insert(mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega!);
		}
		for (var mdfeEmitenteGrouped in object.mdfeEmitenteGroupedList!) {
			mdfeEmitenteGrouped.mdfeEmitente = mdfeEmitenteGrouped.mdfeEmitente?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeEmitentes).insert(mdfeEmitenteGrouped.mdfeEmitente!);
		}
		for (var mdfePercursoGrouped in object.mdfePercursoGroupedList!) {
			mdfePercursoGrouped.mdfePercurso = mdfePercursoGrouped.mdfePercurso?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfePercursos).insert(mdfePercursoGrouped.mdfePercurso!);
		}
		for (var mdfeMunicipioCarregamentoGrouped in object.mdfeMunicipioCarregamentoGroupedList!) {
			mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento = mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeMunicipioCarregamentos).insert(mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento!);
		}
		for (var mdfeRodoviarioGrouped in object.mdfeRodoviarioGroupedList!) {
			mdfeRodoviarioGrouped.mdfeRodoviario = mdfeRodoviarioGrouped.mdfeRodoviario?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeRodoviarios).insert(mdfeRodoviarioGrouped.mdfeRodoviario!);
		}
		for (var mdfeInformacaoSeguroGrouped in object.mdfeInformacaoSeguroGroupedList!) {
			mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro = mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.copyWith(
				id: const Value(null),
				idMdfeCabecalho: Value(object.mdfeCabecalho!.id),
			);
			await into(mdfeInformacaoSeguros).insert(mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro!);
		}
	}
	
	Future<void> deleteChildren(MdfeCabecalhoGrouped object) async {
		await (delete(mdfeLacres)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfeMunicipioDescarregas)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfeEmitentes)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfePercursos)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfeMunicipioCarregamentos)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfeRodoviarios)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
		await (delete(mdfeInformacaoSeguros)..where((t) => t.idMdfeCabecalho.equals(object.mdfeCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}