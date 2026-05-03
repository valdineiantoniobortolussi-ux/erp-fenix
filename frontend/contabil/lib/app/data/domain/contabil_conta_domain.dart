class ContabilContaDomain {
	ContabilContaDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'S': 
				return 'Sintética'; 
			case 'A': 
				return 'Analítica'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Sintética': 
				return 'S'; 
			case 'Analítica': 
				return 'A'; 
			default: 
				return null; 
		} 
	}

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case 'A': 
				return 'Ativa'; 
			case 'I': 
				return 'Inativa'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case 'Ativa': 
				return 'A'; 
			case 'Inativa': 
				return 'I'; 
			default: 
				return null; 
		} 
	}

	static getNatureza(String? natureza) { 
		switch (natureza) { 
			case '': 
			case 'C': 
				return 'Credora'; 
			case 'D': 
				return 'Devedora'; 
			default: 
				return null; 
		} 
	} 

	static setNatureza(String? natureza) { 
		switch (natureza) { 
			case 'Credora': 
				return 'C'; 
			case 'Devedora': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

	static getPatrimonioResultado(String? patrimonioResultado) { 
		switch (patrimonioResultado) { 
			case '': 
			case 'P': 
				return 'Patrimonio'; 
			case 'R': 
				return 'Resultado'; 
			default: 
				return null; 
		} 
	} 

	static setPatrimonioResultado(String? patrimonioResultado) { 
		switch (patrimonioResultado) { 
			case 'Patrimonio': 
				return 'P'; 
			case 'Resultado': 
				return 'R'; 
			default: 
				return null; 
		} 
	}

	static getLivroCaixa(String? livroCaixa) { 
		switch (livroCaixa) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setLivroCaixa(String? livroCaixa) { 
		switch (livroCaixa) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getDfc(String? dfc) { 
		switch (dfc) { 
			case '': 
			case '0': 
				return 'Não participa'; 
			case '1': 
				return 'Atividades Operacionais'; 
			case '2': 
				return 'Atividades de Financiamento'; 
			case '3': 
				return 'Atividades de Investimento'; 
			default: 
				return null; 
		} 
	} 

	static setDfc(String? dfc) { 
		switch (dfc) { 
			case 'Não participa': 
				return '0'; 
			case 'Atividades Operacionais': 
				return '1'; 
			case 'Atividades de Financiamento': 
				return '2'; 
			case 'Atividades de Investimento': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}