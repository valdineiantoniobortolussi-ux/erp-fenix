class PessoaEnderecoDomain {
	PessoaEnderecoDomain._();

	static getUf(String? uf) { 
		switch (uf) { 
			case '': 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AM': 
				return 'AM'; 
			case 'AP': 
				return 'AP'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MG': 
				return 'MG'; 
			case 'MS': 
				return 'MS'; 
			case 'MT': 
				return 'MT'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'PR': 
				return 'PR'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'RS': 
				return 'RS'; 
			case 'SC': 
				return 'SC'; 
			case 'SE': 
				return 'SE'; 
			case 'SP': 
				return 'SP'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	} 

	static setUf(String? uf) { 
		switch (uf) { 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AM': 
				return 'AM'; 
			case 'AP': 
				return 'AP'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MG': 
				return 'MG'; 
			case 'MS': 
				return 'MS'; 
			case 'MT': 
				return 'MT'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'PR': 
				return 'PR'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'RS': 
				return 'RS'; 
			case 'SC': 
				return 'SC'; 
			case 'SE': 
				return 'SE'; 
			case 'SP': 
				return 'SP'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	}

	static getPrincipal(String? principal) { 
		switch (principal) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPrincipal(String? principal) { 
		switch (principal) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEntrega(String? entrega) { 
		switch (entrega) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setEntrega(String? entrega) { 
		switch (entrega) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCobranca(String? cobranca) { 
		switch (cobranca) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setCobranca(String? cobranca) { 
		switch (cobranca) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCorrespondencia(String? correspondencia) { 
		switch (correspondencia) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setCorrespondencia(String? correspondencia) { 
		switch (correspondencia) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}