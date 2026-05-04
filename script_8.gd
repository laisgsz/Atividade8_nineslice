extends Control

# O coração agora está dentro do HBoxContainer
@onready var texture_rect: TextureRect = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect

# O botão agora vem antes da barra na sua árvore
@onready var botao: Button = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/BotaoAnimar

# A barra de progresso é o último item do VBoxContainer
@onready var progress_bar: ProgressBar = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/MeuProgressBar
# Variável para controlar a animação e evitar conflitos se clicar várias vezes
var meu_tween: Tween

func _ready() -> void:
	# Configuração inicial da barra (Requisito: valor inicial)
	progress_bar.value = 0
	
	# Conecta o sinal de clique do botão via código (Requisito: disparado por botão)
	if not botao.pressed.is_connected(_ao_pressionar_botao):
		botao.pressed.connect(_ao_pressionar_botao)

func _ao_pressionar_botao() -> void:
	# Reinicia a barra se ela já estiver cheia para permitir novo teste
	if progress_bar.value >= 100:
		progress_bar.value = 0
		
	animar_com_easing()

func animar_com_easing() -> void:
	# Se já houver uma animação rodando, nós a paramos antes de começar outra
	if meu_tween:
		meu_tween.kill()
	
	# Cria o objeto de animação (Requisito: usar Tween)
	meu_tween = create_tween()
	
	# Configura a animação da propriedade 'value' até 100 em 1.5 segundos
	# Requisito: tween_property + set_trans + set_ease
	meu_tween.tween_property(progress_bar, "value", 70, 1.5)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
