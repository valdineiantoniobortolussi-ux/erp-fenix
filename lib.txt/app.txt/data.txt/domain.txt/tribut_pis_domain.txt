class TributPisDomain {
	TributPisDomain._();

	static getCstPis(String? cstPis) { 
		switch (cstPis) { 
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

	static setCstPis(String? cstPis) { 
		switch (cstPis) { 
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

	static getModalidadeBaseCalculo(String? modalidadeBaseCalculo) { 
		switch (modalidadeBaseCalculo) { 
			case '': 
			case '0': 
				return '0-Percentual'; 
			case '1': 
				return '1-Unidade'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeBaseCalculo(String? modalidadeBaseCalculo) { 
		switch (modalidadeBaseCalculo) { 
			case '0-Percentual': 
				return '0'; 
			case '1-Unidade': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}