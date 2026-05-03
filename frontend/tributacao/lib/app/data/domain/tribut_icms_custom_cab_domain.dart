class TributIcmsCustomCabDomain {
	TributIcmsCustomCabDomain._();

	static getOrigemMercadoria(String? origemMercadoria) { 
		switch (origemMercadoria) { 
			case '': 
			case '0': 
				return '0=Nacional'; 
			case '1': 
				return '1=Estrangeira - Importação Direta'; 
			case '2': 
				return '2=Estrangeira - Adquirida no Mercado Interno'; 
			default: 
				return null; 
		} 
	} 

	static setOrigemMercadoria(String? origemMercadoria) { 
		switch (origemMercadoria) { 
			case '0=Nacional': 
				return '0'; 
			case '1=Estrangeira - Importação Direta': 
				return '1'; 
			case '2=Estrangeira - Adquirida no Mercado Interno': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}