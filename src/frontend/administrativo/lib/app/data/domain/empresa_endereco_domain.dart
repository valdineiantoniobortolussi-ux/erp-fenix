class EmpresaEnderecoDomain {
	EmpresaEnderecoDomain._();

	static getUf(String? uf) { 
		switch (uf) { 
			case '': 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
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
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
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
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
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
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
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