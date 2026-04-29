class TributIcmsCustomCabDomain {
	TributIcmsCustomCabDomain._();

	static getOrigemMercadoria(String? origemMercadoria) { 
		switch (origemMercadoria) { 
			case '': 
			case '0': 
				return 'AAA'; 
			case '1': 
				return 'BBB'; 
			case '2': 
				return 'CCC'; 
			default: 
				return null; 
		} 
	} 

	static setOrigemMercadoria(String? origemMercadoria) { 
		switch (origemMercadoria) { 
			case 'AAA': 
				return '0'; 
			case 'BBB': 
				return '1'; 
			case 'CCC': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}