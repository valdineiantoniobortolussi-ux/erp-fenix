import base64
import pyaes
import hashlib
from util.constants import CHAVE, VETOR  # Importa CHAVE e VETOR do arquivo constants.py

def cifrar(value):
    iv_int = int.from_bytes(VETOR.encode('utf-8'), 'big')
    aes = pyaes.AESModeOfOperationCTR(CHAVE.encode('utf-8'), pyaes.Counter(iv_int))
    encrypted = aes.encrypt(value.encode('utf-8'))
    return base64.b64encode(encrypted).decode('utf-8')

def decifrar(value):    
    ciphertext = base64.b64decode(value)
    iv_int = int.from_bytes(VETOR.encode('utf-8'), 'big')
    aes = pyaes.AESModeOfOperationCTR(CHAVE.encode('utf-8'), pyaes.Counter(iv_int))
    decrypted = aes.decrypt(ciphertext)
    return decrypted.decode('utf-8')

def md5_string(texto: str) -> str:
    return hashlib.md5(texto.encode()).hexdigest()
