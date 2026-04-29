class NfeDetalheDomain {
	NfeDetalheDomain._();

	static getIndicadorEscalaRelevante(String? indicadorEscalaRelevante) { 
		switch (indicadorEscalaRelevante) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setIndicadorEscalaRelevante(String? indicadorEscalaRelevante) { 
		switch (indicadorEscalaRelevante) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEntraTotal(String? entraTotal) { 
		switch (entraTotal) { 
			case '': 
			case '0': 
				return '0=Valor do item (vProd) não compõe o valor total da NF-e'; 
			case '1': 
				return '1=Valor do item (vProd) compõe o valor total da NF-e (vProd)'; 
			default: 
				return null; 
		} 
	} 

	static setEntraTotal(String? entraTotal) { 
		switch (entraTotal) { 
			case '0=Valor do item (vProd) não compõe o valor total da NF-e': 
				return '0'; 
			case '1=Valor do item (vProd) compõe o valor total da NF-e (vProd)': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}