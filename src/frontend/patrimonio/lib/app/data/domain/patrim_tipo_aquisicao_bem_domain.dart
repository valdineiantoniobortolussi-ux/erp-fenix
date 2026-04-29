class PatrimTipoAquisicaoBemDomain {
	PatrimTipoAquisicaoBemDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '1': 
				return '1=Compra'; 
			case '2': 
				return '2=Permuta'; 
			case '3': 
				return '3=Doação'; 
			case '4': 
				return '4=Locação'; 
			case '5': 
				return '5=Comodato'; 
			case '6': 
				return '6=Leasing'; 
			case '7': 
				return '7=Transferência'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case '1=Compra': 
				return '1'; 
			case '2=Permuta': 
				return '2'; 
			case '3=Doação': 
				return '3'; 
			case '4=Locação': 
				return '4'; 
			case '5=Comodato': 
				return '5'; 
			case '6=Leasing': 
				return '6'; 
			case '7=Transferência': 
				return '7'; 
			default: 
				return null; 
		} 
	}

}