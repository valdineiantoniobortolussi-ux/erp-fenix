from src.controller.login_controller import login_bp
from src.controller.gondola_caixa_controller import gondola_caixa_bp
from src.controller.produto_controller import produto_bp
from src.controller.gondola_rua_controller import gondola_rua_bp
from src.controller.gondola_estante_controller import gondola_estante_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(gondola_caixa_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(gondola_rua_bp)
		app.register_blueprint(gondola_estante_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(login_bp)