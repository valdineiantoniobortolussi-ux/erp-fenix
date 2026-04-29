class GuiasAcumuladasDomain {
	GuiasAcumuladasDomain._();

	static getGpsTipo(String? gpsTipo) { 
		switch (gpsTipo) { 
			case '': 
			case '1': 
				return '1-Filial própia empresa'; 
			case '2': 
				return '2-Somente um serviço'; 
			case '3': 
				return '3-Filial referente aos cooperados'; 
			default: 
				return null; 
		} 
	} 

	static setGpsTipo(String? gpsTipo) { 
		switch (gpsTipo) { 
			case '1-Filial própia empresa': 
				return '1'; 
			case '2-Somente um serviço': 
				return '2'; 
			case '3-Filial referente aos cooperados': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}