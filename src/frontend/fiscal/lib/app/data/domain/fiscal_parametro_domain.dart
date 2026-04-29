class FiscalParametroDomain {
	FiscalParametroDomain._();

	static getCriterioLancamento(String? criterioLancamento) { 
		switch (criterioLancamento) { 
			case '': 
			case 'L': 
				return 'Livre'; 
			case 'A': 
				return 'Avisar'; 
			case 'N': 
				return 'Não Permitir'; 
			default: 
				return null; 
		} 
	} 

	static setCriterioLancamento(String? criterioLancamento) { 
		switch (criterioLancamento) { 
			case 'Livre': 
				return 'L'; 
			case 'Avisar': 
				return 'A'; 
			case 'Não Permitir': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getApuracao(String? apuracao) { 
		switch (apuracao) { 
			case '': 
			case '1': 
				return '1-Regime Competencia'; 
			case '2': 
				return '2-Regime de Caixa'; 
			default: 
				return null; 
		} 
	} 

	static setApuracao(String? apuracao) { 
		switch (apuracao) { 
			case '1-Regime Competencia': 
				return '1'; 
			case '2-Regime de Caixa': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getMicroempreeIndividual(String? microempreeIndividual) { 
		switch (microempreeIndividual) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setMicroempreeIndividual(String? microempreeIndividual) { 
		switch (microempreeIndividual) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCalcPisCofinsEfd(String? calcPisCofinsEfd) { 
		switch (calcPisCofinsEfd) { 
			case '': 
			case '0': 
				return 'AB=Alíquota Básica'; 
			case '1': 
				return 'AD=Alíquota Diferenciada'; 
			case '2': 
				return 'UP=Unidade de Medida de Produto'; 
			default: 
				return null; 
		} 
	} 

	static setCalcPisCofinsEfd(String? calcPisCofinsEfd) { 
		switch (calcPisCofinsEfd) { 
			case 'AB=Alíquota Básica': 
				return '0'; 
			case 'AD=Alíquota Diferenciada': 
				return '1'; 
			case 'UP=Unidade de Medida de Produto': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getSimplesTabela(String? simplesTabela) { 
		switch (simplesTabela) { 
			case '': 
			case '1': 
				return '1=Federal'; 
			case '2': 
				return '2=Estadual'; 
			default: 
				return null; 
		} 
	} 

	static setSimplesTabela(String? simplesTabela) { 
		switch (simplesTabela) { 
			case '1=Federal': 
				return '1'; 
			case '2=Estadual': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getSimplesAtividade(String? simplesAtividade) { 
		switch (simplesAtividade) { 
			case '': 
			case '0': 
				return 'Comercio'; 
			case '1': 
				return 'Indústria'; 
			case '2': 
				return 'Serviços Anexo III'; 
			case '3': 
				return 'Serviços Anexo IV'; 
			case '4': 
				return '"Serviços Anexo V'; 
			default: 
				return null; 
		} 
	} 

	static setSimplesAtividade(String? simplesAtividade) { 
		switch (simplesAtividade) { 
			case 'Comercio': 
				return '0'; 
			case 'Indústria': 
				return '1'; 
			case 'Serviços Anexo III': 
				return '2'; 
			case 'Serviços Anexo IV': 
				return '3'; 
			case '"Serviços Anexo V': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getPerfilSped(String? perfilSped) { 
		switch (perfilSped) { 
			case '': 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			default: 
				return null; 
		} 
	} 

	static setPerfilSped(String? perfilSped) { 
		switch (perfilSped) { 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

	static getApuracaoConsolidada(String? apuracaoConsolidada) { 
		switch (apuracaoConsolidada) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setApuracaoConsolidada(String? apuracaoConsolidada) { 
		switch (apuracaoConsolidada) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getSubstituicaoTributaria(String? substituicaoTributaria) { 
		switch (substituicaoTributaria) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setSubstituicaoTributaria(String? substituicaoTributaria) { 
		switch (substituicaoTributaria) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFormaCalculoIss(String? formaCalculoIss) { 
		switch (formaCalculoIss) { 
			case '': 
			case '0': 
				return 'Normal'; 
			case '1': 
				return 'Profissional Habilitado'; 
			case '2': 
				return 'Valor Fixo'; 
			default: 
				return null; 
		} 
	} 

	static setFormaCalculoIss(String? formaCalculoIss) { 
		switch (formaCalculoIss) { 
			case 'Normal': 
				return '0'; 
			case 'Profissional Habilitado': 
				return '1'; 
			case 'Valor Fixo': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}