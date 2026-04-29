import jwt
import json
from datetime import datetime, timezone, timedelta
from sqlalchemy.orm.exc import NoResultFound
from src.util.util import cifrar, md5_string  # Importe os métodos necessários
from src.util.constants import CHAVE
from src.service.usuario_token_service import UsuarioTokenService
from src.model.view_pessoa_usuario_model import ViewPessoaUsuarioModel

class LoginService:

    @staticmethod
    def gerar_token(usuario: ViewPessoaUsuarioModel):
        exp_time = datetime.now(timezone.utc) + timedelta(days=1)
        payload = {
            'sub': usuario.login,
            'exp': exp_time,
            'iss': 'T2Ti' 
        }
        token = jwt.encode(payload, CHAVE, algorithm='HS256')
        return token

    @staticmethod
    def login(usuario: ViewPessoaUsuarioModel):
        md5_senha = md5_string(usuario.login + usuario.senha)

        # Filtra o usuário no banco de dados
        user = ViewPessoaUsuarioModel.query.filter_by(login=usuario.login, senha=md5_senha).first()

        if user:
            token_jwt = LoginService.gerar_token(usuario)

            # auditoria
            current_time = datetime.now(timezone.utc)
            usuario_token = {
                'login': usuario.login,
                'token': token_jwt,
                'dataCriacao': current_time,
                'horaCriacao': current_time.strftime('%H:%M:%S'),
                'dataExpiracao': current_time + timedelta(days=1),
                'horaExpiracao': (current_time + timedelta(days=1)).strftime('%H:%M:%S')
            }            
            usuario_token_service = UsuarioTokenService()
            usuario_token_service.insert(usuario_token)            

            user_json = json.dumps(user.serialize())
            user_cifrado = cifrar(user_json)
            objeto_login = {
                'token': cifrar(token_jwt),
                'user': user_cifrado
            }
            return objeto_login

        raise NoResultFound('Usuário ou senha inválidos')
