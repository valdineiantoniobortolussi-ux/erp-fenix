class WmsParametroDomain {
	WmsParametroDomain._();

	static getItemDiferenteCaixa(String? itemDiferenteCaixa) { 
		switch (itemDiferenteCaixa) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setItemDiferenteCaixa(String? itemDiferenteCaixa) { 
		switch (itemDiferenteCaixa) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}