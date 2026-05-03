from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv
from sqlalchemy import create_engine
from src.util.constants import CHAVE
from datetime import datetime, timezone, timedelta
import jwt  # Importa a biblioteca PyJWT
from jwt import ExpiredSignatureError, InvalidTokenError  # Importa as exceções diretamente
from sqlalchemy.orm import scoped_session, sessionmaker

# Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

# Importa as configurações da aplicação Flask
from src.config import config

# Cria a instância do SQLAlchemy para interagir com o banco de dados
db = SQLAlchemy()

# Função para criar e configurar a aplicação Flask
def create_app(config_mode):
    # Cria a instância da aplicação Flask
    app = Flask(__name__)

    # Configura a aplicação Flask com base no modo de configuração fornecido
    app.config.from_object(config[config_mode])

    # Inicializa o SQLAlchemy com a aplicação Flask
    db.init_app(app)

    # Inicializa o JWT com a aplicação Flask
    jwt_manager = JWTManager(app)

    @app.before_request
    def configurar_banco_dinamico():
        cnpj = request.headers.get('cnpj')
        if cnpj:
            new_uri = f"mysql://root:root@localhost/{cnpj}"
            app.config['SQLALCHEMY_DATABASE_URI'] = new_uri
            print(f"Database URI set to: {new_uri}")
            
            # Cria um novo engine
            new_engine = create_engine(new_uri)
            # Remove as sessões existentes
            db.session.remove()
            db.engine.dispose()

            # Recria o engine e sessão
            Session = scoped_session(sessionmaker(bind=new_engine))
            db.session = Session
    
    @app.before_request
    def verificar_token_requisicao():
        # Rotas que não precisam de autenticação
        rotas_excluidas = ['/login', '/']
        if request.path not in rotas_excluidas:
            auth_header = request.headers.get('Authorization')
            if auth_header:
                token = auth_header.split(" ")[1]
                try:
                    # Decodifica o token usando a biblioteca PyJWT
                    decoded = jwt.decode(token, CHAVE, algorithms=['HS256'])

                    # auditoria
                    current_time = datetime.now(timezone.utc)
                    # Create the audit record data
                    objeto_auditoria = {
                        'dataRegistro': current_time,
                        'horaRegistro': current_time.strftime('%H:%M:%S'),
                        'janelaController': request.endpoint,
                        'acao': request.method,
                        'conteudo': request.data.decode('utf-8') if request.method in ['POST', 'PUT'] and request.data else request.full_path,
                        'tokenJwt': token
                    }            
                    from src.service.auditoria_service import AuditoriaService
                    auditoria_service = AuditoriaService()
                    auditoria_service.insert(objeto_auditoria)

                    if decoded is None:
                        return jsonify({"msg": "Token inválido ou expirado"}), 401
                except ExpiredSignatureError:
                    return jsonify({"msg": "Token expirado"}), 401
                except InvalidTokenError:
                    return jsonify({"msg": "Token inválido"}), 401
            else:
                return jsonify({"msg": "Token ausente"}), 401

    return app
