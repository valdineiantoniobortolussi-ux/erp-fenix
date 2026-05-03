class TributIcmsCustomDetDomain {
	TributIcmsCustomDetDomain._();

	static getUfDestino(String? ufDestino) { 
		switch (ufDestino) { 
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

	static setUfDestino(String? ufDestino) { 
		switch (ufDestino) { 
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

	static getCst(String? cst) { 
		switch (cst) { 
			case '': 
			case '00': 
				return '00'; 
			case '10': 
				return '10'; 
			case '20': 
				return '20'; 
			case '30': 
				return '30'; 
			case '40': 
				return '40'; 
			case '41': 
				return '41'; 
			case '50': 
				return '50'; 
			case '51': 
				return '51'; 
			case '60': 
				return '60'; 
			case '70': 
				return '70'; 
			case '90': 
				return '90'; 
			default: 
				return null; 
		} 
	} 

	static setCst(String? cst) { 
		switch (cst) { 
			case '00': 
				return '00'; 
			case '10': 
				return '10'; 
			case '20': 
				return '20'; 
			case '30': 
				return '30'; 
			case '40': 
				return '40'; 
			case '41': 
				return '41'; 
			case '50': 
				return '50'; 
			case '51': 
				return '51'; 
			case '60': 
				return '60'; 
			case '70': 
				return '70'; 
			case '90': 
				return '90'; 
			default: 
				return null; 
		} 
	}

	static getCsosn(String? csosn) { 
		switch (csosn) { 
			case '': 
			case '101': 
				return '101'; 
			case '102': 
				return '102'; 
			case '103': 
				return '103'; 
			case '201': 
				return '201'; 
			case '202': 
				return '202'; 
			case '203': 
				return '203'; 
			case '300': 
				return '300'; 
			case '400': 
				return '400'; 
			case '500': 
				return '500'; 
			case '900': 
				return '900'; 
			default: 
				return null; 
		} 
	} 

	static setCsosn(String? csosn) { 
		switch (csosn) { 
			case '101': 
				return '101'; 
			case '102': 
				return '102'; 
			case '103': 
				return '103'; 
			case '201': 
				return '201'; 
			case '202': 
				return '202'; 
			case '203': 
				return '203'; 
			case '300': 
				return '300'; 
			case '400': 
				return '400'; 
			case '500': 
				return '500'; 
			case '900': 
				return '900'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeBc(String? modalidadeBc) { 
		switch (modalidadeBc) { 
			case '': 
			case '0': 
				return '0-Margem Valor Agregado'; 
			case '1': 
				return '1-Valor Pauta'; 
			case '2': 
				return '2-Valor Preço Máximo'; 
			case '3': 
				return '3-Valor da Operação'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeBc(String? modalidadeBc) { 
		switch (modalidadeBc) { 
			case '0-Margem Valor Agregado': 
				return '0'; 
			case '1-Valor Pauta': 
				return '1'; 
			case '2-Valor Preço Máximo': 
				return '2'; 
			case '3-Valor da Operação': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getModalidadeBcSt(String? modalidadeBcSt) { 
		switch (modalidadeBcSt) { 
			case '': 
			case '0': 
				return '0-Valor Preço Máximo'; 
			case '1': 
				return '1-Valor Lista Negativa'; 
			case '2': 
				return '2-Valor Lista Positiva'; 
			case '3': 
				return '3-Valor Lista Neutra'; 
			case '4': 
				return '4-Margem Valor Agregado'; 
			case '5': 
				return '5-Valor Pauta'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeBcSt(String? modalidadeBcSt) { 
		switch (modalidadeBcSt) { 
			case '0-Valor Preço Máximo': 
				return '0'; 
			case '1-Valor Lista Negativa': 
				return '1'; 
			case '2-Valor Lista Positiva': 
				return '2'; 
			case '3-Valor Lista Neutra': 
				return '3'; 
			case '4-Margem Valor Agregado': 
				return '4'; 
			case '5-Valor Pauta': 
				return '5'; 
			default: 
				return null; 
		} 
	}

}