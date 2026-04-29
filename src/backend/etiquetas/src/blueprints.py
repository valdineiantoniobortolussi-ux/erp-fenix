from src.controller.login_controller import login_bp
from src.controller.etiqueta_layout_controller import etiqueta_layout_bp
from src.controller.etiqueta_formato_papel_controller import etiqueta_formato_papel_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(etiqueta_layout_bp)
		app.register_blueprint(etiqueta_formato_papel_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(login_bp)