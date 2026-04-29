class NfeDetalheImpostoPisDomain {
	NfeDetalheImpostoPisDomain._();

	static getCstPis(String? cstPis) { 
		switch (cstPis) { 
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

	static setCstPis(String? cstPis) { 
		switch (cstPis) { 
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