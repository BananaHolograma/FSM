<p align="center">
	<img width="256px" src="https://github.com/GodotParadise/FSM/blob/main/icon.jpg" alt="GodotParadiseFSM logo" />
	<h1 align="center">Godot Paradise FSM</h1>
	
[![LastCommit](https://img.shields.io/github/last-commit/GodotParadise/FSM?cacheSeconds=600)](https://github.com/GodotParadise/FSM/commits)
[![Stars](https://img.shields.io/github/stars/godotparadise/FSM)](https://github.com/GodotParadise/FSM/stargazers)
[![Total downloads](https://img.shields.io/github/downloads/GodotParadise/FSM/total.svg?label=Downloads&logo=github&cacheSeconds=600)](https://github.com/GodotParadise/FSM/releases)
[![License](https://img.shields.io/github/license/GodotParadise/FSM?cacheSeconds=2592000)](https://github.com/GodotParadise/FSM/blob/main/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=github)](https://github.com/godotparadise/FSM/pulls)
[![](https://img.shields.io/discord/1167079890391138406.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/XqS7C34x)
</p>

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/GodotParadise/FSM/blob/main/README.md)

- - -

Una máquina de estados finitos diseñada para cubrir el 95% de los casos de uso, proporcionando funcionalidad esencial y un nodo de estado básico que puede ampliarse.

- [Requerimientos](#requerimientos)
- [✨Instalacion](#instalacion)
	- [Automatica (Recomendada)](#automatica-recomendada)
	- [Manual](#manual)
	- [CSharp version](#csharp-version)
- [Guia](#guia)
	- [GodotParadiseState](#godotparadisestate)
		- [\_enter()](#_enter)
		- [\_exit()](#_exit)
		- [\_handle\_input(event)](#_handle_inputevent)
		- [physics\_update(delta)](#physics_updatedelta)
		- [update(delta)](#updatedelta)
		- [\_on\_animation\_player\_finished(name: String)](#_on_animation_player_finishedname-string)
		- [\_on\_animation\_finished()](#_on_animation_finished)
	- [Señales](#señales)
- [The Finite State Machine *(FSM)*](#the-finite-state-machine-fsm)
	- [Parámetros exportados](#parámetros-exportados)
	- [Parámetros accessibles como variable](#parámetros-accessibles-como-variable)
	- [Como cambiar de estado](#como-cambiar-de-estado)
	- [Funciones](#funciones)
		- [change\_state(state: GodotParadiseState, params: Dictionary = {}, force: bool = false)](#change_statestate-godotparadisestate-params-dictionary---force-bool--false)
		- [change\_state\_by\_name(name: String, params: Dictionary = {}, force: bool = false)](#change_state_by_namename-string-params-dictionary---force-bool--false)
		- [enter\_state(state: GodotParadiseState, previous\_state: GodotParadiseState)](#enter_statestate-godotparadisestate-previous_state-godotparadisestate)
		- [exit\_state(state: GodotParadiseState)](#exit_statestate-godotparadisestate)
		- [get\_state(name: String)](#get_statename-string)
		- [has\_state(name: String) -\> bool](#has_statename-string---bool)
		- [current\_state\_is(state: GodotParadiseState) -\> bool](#current_state_isstate-godotparadisestate---bool)
		- [current\_state\_name\_is(name: String) -\> bool](#current_state_name_isname-string---bool)
		- [lock\_state\_machine()](#lock_state_machine)
		- [unlock\_state\_machine()](#unlock_state_machine)
	- [Señales](#señales-1)
- [✌️Eres bienvenido a](#️eres-bienvenido-a)
- [🤝Normas de contribución](#normas-de-contribución)
- [📇Contáctanos](#contáctanos)

# Requerimientos
📢 No ofrecemos soporte para Godot 3+ ya que nos enfocamos en las versiones futuras estables a partir de la versión 4.
* Godot 4+

# ✨Instalacion
## Automatica (Recomendada)
Puedes descargar este plugin desde la [Godot asset library](https://godotengine.org/asset-library/asset/2039) oficial usando la pestaña AssetLib de tu editor Godot. Una vez instalado, estás listo para empezar
## Manual 
Para instalar manualmente el plugin, crea una carpeta **"addons"** en la raíz de tu proyecto Godot y luego descarga el contenido de la carpeta **"addons"** de este repositorio
## CSharp version
Este plugin también ha sido escrito en C# y puedes encontrarlo en [FSM-CSharp](https://github.com/GodotParadise/FSM-CSharp)


La máquina de estados finitos se puede añadir como cualquier otro nodo del árbol de escenas donde se quiera utilizar.

![fsm-add-node](https://github.com/GodotParadise/FSM/blob/main/images/fsm_add_child.png)
![fsm-added-scene-tree](https://github.com/GodotParadise/FSM/blob/main/images/fsm_added_scene_tree.png)
![fsm-example](https://github.com/GodotParadise/FSM/blob/main/images/fsm_example.png)

⚠️ La máquina de estados finitos **siempre necesita al menos un estado por defecto** con el que empezar, este estado por defecto se puede establecer en la variable exportada `current_state`. Una vez hecho esto, al ejecutar la escena este será el estado actual de la máquina hasta que se den las condiciones que cambien el estado. Aunque nada se romperá sin él, tener un estado inicial definido es una buena práctica para empezar.

Siempre habrá un solo `physic_process()` o `_process()` ya que es la máquina principal la que se encarga de llamar a los métodos virtuales de cada estado. Si tu estado sobreescribe `physics_update()` se ejecutará en el bloque de `physic_process()`

`_enter()` y `_exit()` son llamadas cuando el nuevo estado se convierte en el actual y cuando se va a transicionar a otro estado. Son útiles para limpiar o preparar algún tipo de parámetros dentro del estado para ser usados sólo en este estado.

# Guia
## GodotParadiseState
Todas las funciones aquí son virtuales, lo que significa que pueden ser sobrescritas con la funcionalidad deseada en cada caso.

En todos los estados tienes acceso a los `previous_states` y a los `params` extra que has intercambiado entre transición y transición. Los `previous_states` sólo están disponibles si has habilitado la pila en el FSM.

```py
class_name GodotParadiseState extends Node

signal state_entered
signal state_finished(next_state, params: Dictionary)

var previous_states: Array[GodotParadiseState] = []
var params: Dictionary = {}

func _enter() -> void:
	pass
	

func _exit() -> void:
	pass
	

func handle_input(_event):
	pass	


func physics_update(_delta):
	pass
	
	
func update(_delta):
	pass
	

func _on_animation_player_finished(_name: String):
	pass


func _on_animation_finished():
	pass
```

### _enter()
Esta función se ejecuta cuando el estado entra por primera vez como estado actual.
### _exit()
Esta función se ejecuta cuando el estado deja de ser el estado actual y pasa al siguiente.
### _handle_input(event)
En caso de que quieras personalizar como este estado maneja las entradas en tu juego este es el lugar para hacerlo. El tipo de evento es InputEvent
### physics_update(delta)
Esta función se ejecuta en cada fotograma del proceso físico de la máquina de estados finitos
### update(delta)
Esta función se ejecuta en cada fotograma del proceso de la máquina de estados finitos
### _on_animation_player_finished(name: String)
Puedes usar esta función genéricamente para ejecutar lógica personalizada cuando un AnimationPlayer termina cualquier animación. Esta recibe el nombre de la animación como parámetro para evitar errores y ser consistente con la señal original.
### _on_animation_finished()
Puede usar esta función genéricamente para ejecutar lógica personalizada cuando un AnimatedSprite(2/3)D termina cualquier animación. Esta función no recibe ningún parámetro para evitar errores y ser consistente con la señal original.

## Señales
- *state_entered*
- *state_finished(next_state, params: Dictionary)*

Si por ejemplo quieres implementar un estado **Idle** es tan fácil como:
```py
class_name Idle extends GodotParadiseState

func _enter() -> void:
	# play animations...
	# set velocity to zero...

func _exit() -> void:
	# stop animation...s

func _physics_update(delta):
	# detect the input direction to change to another state such as Walk or Crouch
```

# The Finite State Machine *(FSM)*
## Parámetros exportados
- current_state: GodotParadiseState = null
- stack_capacity: int = 3
- flush_stack_when_reach_capacity: bool = false
- enable_stack: bool = true
## Parámetros accessibles como variable
- states: Dictionary
- states_stack: Array[GodotParadiseState]
- locked: bool

Cuando este nodo está listo en el árbol de escenas, todos los estados detectados como hijos **en cualquier nivel de anidamiento** se guardan en un diccionario para facilitar el acceso por sus nombres de nodo.

La **FSM** se conecta a todas las señales `state_finished` de los estados anidados existentes. Cuando se produce un cambio de estado y la pila está habilitada, el estado anterior se añade a la pila `states_stack`. Puedes definir una `stack_capacity` para definir el número de estados anteriores que quieres guardar. Esta pila es accesible en cada estado para manejar condiciones en las que necesitamos saber qué estados han sido transicionados previamente. El valor locked permite bloquear o desbloquear la máquina de estados para la ejecución de estados. Se puede reanudar reseteándolo a false. Cuando está bloqueada **la pila también está deshabilitada.**

## Como cambiar de estado
Este es un ejemplo de código que cambia del estado **Idle** a **Run**:
```py
if not horizontal_direction.is_zero_approx() and owner.is_on_floor():
	## El primer parámetro puede ser la clase o el nombre de la clase en formato String
	state_finished.emit("Run", {})
	#or 
	state_finished.emit(Run, {"sprint_time": 4.0})
	return
```
Como puedes ver, dentro de cada estado individual, tienes la opción de emitir la señal `state_finished`, que será monitorizada por la máquina de estados padre.

## Funciones
Normalmente **no se desea llamar a estas funciones manualmente**, es preferible emitir señales desde los propios estados y dejar que la máquina de estados finitos reaccione a estas señales para ejecutar acciones como cambiar el estado. Por cierto, nada te impide hacerlo y puede ser necesario en tu caso de uso.

### change_state(state: GodotParadiseState, params: Dictionary = {}, force: bool = false)
Cambia el estado actual al siguiente estado pasado como parámetro si no son el mismo. Esta acción puede forzarse con el tercer parámetro force. Si el estado puede ser transitado, se ejecutará la función `_exit()` del estado actual y la función `_enter()` del siguiente estado. En esta transición el nuevo estado puede recibir parámetros externos. Emite la señal `state_changed`

### change_state_by_name(name: String, params: Dictionary = {}, force: bool = false)
Realiza la misma acción que la función `change_state` pero recibiendo el estado con el nombre que tiene en el diccionario de estados. Por ejemplo, si tenemos un estado de nodo llamado **'Idle'** en la escena, se puede cambiar usando `change_state_by_name("Idle")`

### enter_state(state: GodotParadiseState, previous_state: GodotParadiseState)
Esta función es llamada cuando un nuevo estado se convierte en el estado actual. Durante este proceso, la señal `state_entered`  es emitida.


### exit_state(state: GodotParadiseState)
Sale del estado actual hacia el proporcionado como parámetro en la función, ejecuta la función `_exit()` antes de salir.
### get_state(name: String)
Retorna el nodo de estado usando la clave del diccionario de la variable `states` en la FSM si existe o nulo si no.
### has_state(name: String) -> bool
Comprueba que el estado existe en el diccionario de estados de la FSM

### current_state_is(state: GodotParadiseState) -> bool
Comprueba que el estado actual es el proporcionado como parámetro

### current_state_name_is(name: String) -> bool
Mismo que el anterior pero usando la clave del diccionario en formato String.

### lock_state_machine()
Bloquea la FSM, todos los procesos son seteados a false y el stack es deshabilitado. Esta función es llamada automáticamente cuando la variable `locked` cambia a false.


### unlock_state_machine()
Desbloquea la máquina si estaba bloqueado, todos los procesos son seteados a true y el stack es habilitado de nuevo. Esta función es llamada automáticamente cuando la variable `locked` cambia a true.

## Señales
- *state_changed(from_state: GodotParadiseState, state: GodotParadiseState)*
- *stack_pushed(new_state: GodotParadiseState, stack:Array[GodotParadiseState])*
- *stack_flushed(flushed_states: Array[GodotParadiseState])*


# ✌️Eres bienvenido a
- [Give feedback](https://github.com/GodotParadise/FSM/pulls)
- [Suggest improvements](https://github.com/GodotParadise/FSM/issues/new?assignees=BananaHolograma&labels=enhancement&template=feature_request.md&title=)
- [Bug report](https://github.com/GodotParadise/FSM/issues/new?assignees=BananaHolograma&labels=bug%2C+task&template=bug_report.md&title=)

GodotParadise esta disponible de forma gratuita.

Si estas agradecido por lo que hacemos, por favor, considera hacer una donación. Desarrollar los plugins y contenidos de GodotParadise requiere una gran cantidad de tiempo y conocimiento, especialmente cuando se trata de Godot. Incluso 1€ es muy apreciado y demuestra que te importa. ¡Muchas Gracias!

- - -
# 🤝Normas de contribución
**¡Gracias por tu interes en GodotParadise!**

Para garantizar un proceso de contribución fluido y colaborativo, revise nuestras [directrices de contribución](https://github.com/godotparadise/FSM/blob/main/CONTRIBUTING.md) antes de empezar. Estas directrices describen las normas y expectativas que mantenemos en este proyecto.

**📓Código de conducta:** En este proyecto nos adherimos estrictamente al [Código de conducta de Godot](https://godotengine.org/code-of-conduct/). Como colaborador, es importante respetar y seguir este código para mantener una comunidad positiva e inclusiva.
- - -


# 📇Contáctanos
Si has construido un proyecto, demo, script o algun otro ejemplo usando nuestros plugins haznoslo saber y podemos publicarlo en este repositorio para ayudarnos a mejorar y saber que lo que hacemos es útil.
