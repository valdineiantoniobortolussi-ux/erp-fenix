class NfeCupomFiscalReferenciadoDomain {
	NfeCupomFiscalReferenciadoDomain._();

	static getModeloDocumentoFiscal(String? modeloDocumentoFiscal) { 
		switch (modeloDocumentoFiscal) { 
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

	static setModeloDocumentoFiscal(String? modeloDocumentoFiscal) { 
		switch (modeloDocumentoFiscal) { 
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