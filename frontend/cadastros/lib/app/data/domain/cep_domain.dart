class CepDomain {
	CepDomain._();

	static getUf(String? uf) { 
		switch (uf) { 
			case '': 
			case '0': 
				return 'AC'; 
			case '1': 
				return 'AL'; 
			case '2': 
				return 'AM'; 
			case '3': 
				return 'AP'; 
			case '4': 
				return 'BA'; 
			case '5': 
				return 'CE'; 
			case '6': 
				return 'DF'; 
			case '7': 
				return 'ES'; 
			case '8': 
				return 'GO'; 
			case '9': 
				return 'MA'; 
			case '10': 
				return 'MG'; 
			case '11': 
				return 'MS'; 
			case '12': 
				return 'MT'; 
			case '13': 
				return 'PA'; 
			case '14': 
				return 'PB'; 
			case '15': 
				return 'PE'; 
			case '16': 
				return 'PI'; 
			case '17': 
				return 'PR'; 
			case '18': 
				return 'RJ'; 
			case '19': 
				return 'RN'; 
			case '20': 
				return 'RO'; 
			case '21': 
				return 'RR'; 
			case '22': 
				return 'RS'; 
			case '23': 
				return 'SC'; 
			case '24': 
				return 'SE'; 
			case '25': 
				return 'SP'; 
			case '26': 
				return 'TO'; 
			default: 
				return null; 
		} 
	} 

	static setUf(String? uf) { 
		switch (uf) { 
			case 'AC': 
				return '0'; 
			case 'AL': 
				return '1'; 
			case 'AM': 
				return '2'; 
			case 'AP': 
				return '3'; 
			case 'BA': 
				return '4'; 
			case 'CE': 
				return '5'; 
			case 'DF': 
				return '6'; 
			case 'ES': 
				return '7'; 
			case 'GO': 
				return '8'; 
			case 'MA': 
				return '9'; 
			case 'MG': 
				return '10'; 
			case 'MS': 
				return '11'; 
			case 'MT': 
				return '12'; 
			case 'PA': 
				return '13'; 
			case 'PB': 
				return '14'; 
			case 'PE': 
				return '15'; 
			case 'PI': 
				return '16'; 
			case 'PR': 
				return '17'; 
			case 'RJ': 
				return '18'; 
			case 'RN': 
				return '19'; 
			case 'RO': 
				return '20'; 
			case 'RR': 
				return '21'; 
			case 'RS': 
				return '22'; 
			case 'SC': 
				return '23'; 
			case 'SE': 
				return '24'; 
			case 'SP': 
				return '25'; 
			case 'TO': 
				return '26'; 
			default: 
				return null; 
		} 
	}

}