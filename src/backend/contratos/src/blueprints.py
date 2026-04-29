from src.controller.login_controller import login_bp
from src.controller.contrato_controller import contrato_bp
from src.controller.setor_controller import setor_bp
from src.controller.tipo_contrato_controller import tipo_contrato_bp
from src.controller.contrato_tipo_servico_controller import contrato_tipo_servico_bp
from src.controller.contrato_solicitacao_servico_controller import contrato_solicitacao_servico_bp
from src.controller.contrato_template_controller import contrato_template_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_cliente_controller import view_pessoa_cliente_bp
from src.controller.view_pessoa_fornecedor_controller import view_pessoa_fornecedor_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(contrato_bp)
		app.register_blueprint(setor_bp)
		app.register_blueprint(tipo_contrato_bp)
		app.register_blueprint(contrato_tipo_servico_bp)
		app.register_blueprint(contrato_solicitacao_servico_bp)
		app.register_blueprint(contrato_template_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_cliente_bp)
		app.register_blueprint(view_pessoa_fornecedor_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)