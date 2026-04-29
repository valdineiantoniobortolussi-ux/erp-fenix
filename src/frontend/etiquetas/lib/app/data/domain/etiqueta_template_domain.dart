class EtiquetaTemplateDomain {
	EtiquetaTemplateDomain._();

	static getFormato(String? formato) { 
		switch (formato) { 
			case '': 
			case '0': 
				return '0=EAN'; 
			case '1': 
				return '1=QR Code'; 
			default: 
				return null; 
		} 
	} 

	static setFormato(String? formato) { 
		switch (formato) { 
			case '0=EAN': 
				return '0'; 
			case '1=QR Code': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}