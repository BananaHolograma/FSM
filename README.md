<p align="center">
	<img width="256px" src="https://github.com/GodotParadise/FSM/blob/main/icon.jpg" alt="GodotParadiseFSM logo" />
	<h1 align="center">Godot Paradise FSM</h1>
	
[![LastCommit](https://img.shields.io/github/last-commit/GodotParadise/FSM?cacheSeconds=600)](https://github.com/GodotParadise/FSM/commits)
[![Stars](https://img.shields.io/github/stars/godotparadise/FSM)](https://github.com/GodotParadise/FSM/stargazers)
[![Total downloads](https://img.shields.io/github/downloads/GodotParadise/FSM/total.svg?label=Downloads&logo=github&cacheSeconds=600)](https://github.com/GodotParadise/FSM/releases)
[![License](https://img.shields.io/github/license/GodotParadise/FSM?cacheSeconds=2592000)](https://github.com/GodotParadise/FSM/blob/main/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=github)](https://github.com/godotparadise/FSM/pulls)
[![](https://img.shields.io/discord/1167079890391138406.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/XqS7C34x)
[![Kofi](https://badgen.net/badge/icon/kofi?icon=kofi&label)](https://ko-fi.com/bananaholograma)
</p>

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://github.com/GodotParadise/FSM/blob/main/locale/README.es-ES.md)

- - -

A finite state machine designed to cover 95% of use cases, providing essential functionality and a basic state node that can be extended.

- [Requirements](#requirements)
- [✨Installation](#installation)
	- [Automatic (Recommended)](#automatic-recommended)
	- [Manual](#manual)
	- [CSharp version](#csharp-version)
- [Getting started](#getting-started)
- [Guide](#guide)
	- [GodotParadiseState](#godotparadisestate)
		- [\_enter()](#_enter)
		- [\_exit()](#_exit)
		- [\_handle\_input(event)](#_handle_inputevent)
		- [physics\_update(delta)](#physics_updatedelta)
		- [update(delta)](#updatedelta)
		- [\_on\_animation\_player\_finished(name: String)](#_on_animation_player_finishedname-string)
		- [\_on\_animation\_finished()](#_on_animation_finished)
	- [Signals](#signals)
- [The Finite State Machine *(FSM)*](#the-finite-state-machine-fsm)
	- [Exported parameters](#exported-parameters)
	- [Accessible parameters](#accessible-parameters)
	- [How to change the state](#how-to-change-the-state)
	- [Functions](#functions)
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
	- [Signals](#signals-1)
- [✌️You are welcome to](#️you-are-welcome-to)
- [🤝Contribution guidelines](#contribution-guidelines)
- [📇Contact us](#contact-us)


# Requirements
📢 We don't currently give support to Godot 3+ as we focus on future stable versions from version 4 onwards
* Godot 4+

# ✨Installation
## Automatic (Recommended)
You can download this plugin from the official [Godot asset library](https://godotengine.org/asset-library/asset/2039) using the AssetLib tab in your godot editor. Once installed, you're ready to get started
##  Manual 
To manually install the plugin, create an **"addons"** folder at the root of your Godot project and then download the contents from the **"addons"** folder of this repository.
## CSharp version
This plugin has also been written in C# and you can find it on [FSM-CSharp](https://github.com/GodotParadise/FSM-CSharp)


# Getting started
The finite state machine can be added as any other node in the scene tree where you want to use it. 
![fsm-add-node](https://github.com/GodotParadise/FSM/blob/main/images/fsm_add_child.png)
![fsm-added-scene-tree](https://github.com/GodotParadise/FSM/blob/main/images/fsm_added_scene_tree.png)
![fsm-example](https://github.com/GodotParadise/FSM/blob/main/images/fsm_example.png)

⚠️ The finite state machine **always need at least one default state** to start with, this default state can be set on the exported variable `current_state`. Once this is done, when executing the scene this will be the current state of the machine until the conditions that change the state occur. 
While nothing will break without it, having a defined initial state is good practice to start from.

There will always be only one `physic_process()` or `_process()` since it is the main machine that is in charge of calling the virtual methods of each state.If your state overrides `physics_update()` will be executed as `physic_process()`

`_enter()` and `_exit()` are called when the new state becomes the current and when it will transition to another state. They are useful to clean up or get ready some sort of parameters inside the state to be used only in this state.
 
# Guide
## GodotParadiseState
All the functions here are virtual, which means they can be overridden with the desired functionality in each case.

In all states you have access to the `previous_states` and the extra `params` you have exchanged between transition and transition.
The `previous_states` are available only if you enabled the stack in the FSM.


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
This function executes when the state enters for the first time as the current state.
### _exit()
This function executes when the state exits from being the current state and transitions to the next one.
### _handle_input(event)
In case you want to customize how this state handle the inputs in your game this is the place to do that. The event type is InputEvent
### physics_update(delta)
This function executes on each frame of the finite state machine's physic process
### update(delta)
This function executes on each frame of the finite state machine's process
### _on_animation_player_finished(name: String)
You can use this function generically to execute custom logic when an AnimationPlayer finishes any animation. This receive the animation name as parameter to avoid errors and be consistent with the original signal.
### _on_animation_finished()
You can use this function generically to execute custom logic when an AnimatedSprite(2/3)D finishes any animation. This does not receive any params to avoid errors and be consistent with the original signal.

## Signals
- *state_entered*
- *state_finished(next_state, params: Dictionary)*

So for example if you want to implement a **Idle** state it's easy as:
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
## Exported parameters
- current_state: GodotParadiseState = null
- stack_capacity: int = 3
- flush_stack_when_reach_capacity: bool = false
- enable_stack: bool = true
## Accessible parameters
- states: Dictionary
- states_stack: Array[GodotParadiseState]
- locked: bool

When this node is ready in the scene tree, all the states detected as children **at any nesting level** are saved in a dictionary for easy access by their node names. 

The **finite state machine** connects to all the `state_finished` signals from the nested existing states.
When a change state happens and the **stack is enabled**, the previous state is appended to the `states_stack`. You can define a `stack_capacity` to define the number of previous states you want to save. This stack is accessible on each state to handle conditions in which we need to know which states have been previously transitioned.
The locked value enables the state machine to be locked or unlocked for state execution. It can be resumed by resetting it to false. When it's locked **the stack is also disabled.**

## How to change the state
This is an example of code that changes state from Idle to Run:
```py
if not horizontal_direction.is_zero_approx() and owner.is_on_floor():
	## First parameter can be the class String name or the Class itself
	state_finished.emit("Run", {})
	#or 
	state_finished.emit(Run, {"sprint_time": 4.0})
	return
```
As you can see, within each individual state, you have the option to emit the `state_finished` signal, which will be monitored by the parent state machine.
You can find a more complex example in the repository [FirstPersonController](https://github.com/GodotParadise/First-Person-Controller/tree/main/first_person_controller/state_machine)


## Functions
Usually **you don't really want to call this functions manually**, it is preferable to emit signals from the states themselves and let the finite state machine react to these signals in order to execute actions such as changing the state. By the way, nothing stops you yo do that and may be needed in your use case.

### change_state(state: GodotParadiseState, params: Dictionary = {}, force: bool = false)
Changes the current state to the next state passed as parameter if they are not the same. This action can be forced with the third parameter force.
If the state can be transitioned, the `_exit()` function from the current state and the `_enter()` function of the next state will be executed.
In this transition the new state can receive external parameters. Emits the signal `state_changed`

### change_state_by_name(name: String, params: Dictionary = {}, force: bool = false)
Perform the same action as the `change_state` function but by receiving the state with the name it has in the states dictionary. For example, if we have a node state named **'Idle'** in the scene, it can be changed using `change_state_by_name("Idle")`

### enter_state(state: GodotParadiseState, previous_state: GodotParadiseState)
This function is called when a new state becomes the current state. During this process, the `state_entered` signal is emitted.

### exit_state(state: GodotParadiseState)
Exit the state passed as parameter, execute the `_exit()` function on this state.
### get_state(name: String)
Returns the state node using the dictionary key from the states variable if it exists, or null if it does not.

### has_state(name: String) -> bool
Check if the state with that name exists on the states dictionary

### current_state_is(state: GodotParadiseState) -> bool
Check if the current state is the one passed as parameter

### current_state_name_is(name: String) -> bool
Same as above but using the dictionary key from states

### lock_state_machine()
Lock the state machine, all the process are set to false and the stack is disabled. This function is called automatically when locked changes to false

### unlock_state_machine()
Unlock the machine, all the process are set to true and stack is enabled again (if it was enabled). This function is called automatically when locked changes to true

## Signals
- *state_changed(from_state: GodotParadiseState, state: GodotParadiseState)*
- *stack_pushed(new_state: GodotParadiseState, stack:Array[GodotParadiseState])*
- *stack_flushed(flushed_states: Array[GodotParadiseState])*


# ✌️You are welcome to
- [Give feedback](https://github.com/GodotParadise/FSM/pulls)
- [Suggest improvements](https://github.com/GodotParadise/FSM/issues/new?assignees=BananaHolograma&labels=enhancement&template=feature_request.md&title=)
- [Bug report](https://github.com/GodotParadise/FSM/issues/new?assignees=BananaHolograma&labels=bug%2C+task&template=bug_report.md&title=)

GodotParadise is available for free.

If you're grateful for what we're doing, please consider a donation. Developing GodotParadise requires massive amount of time and knowledge, especially when it comes to Godot. Even $1 is highly appreciated and shows that you care. Thank you!

- - -
# 🤝Contribution guidelines
**Thank you for your interest in Godot Paradise!**

To ensure a smooth and collaborative contribution process, please review our [contribution guidelines](https://github.com/GodotParadise/FSM/blob/main/CONTRIBUTING.md) before getting started. These guidelines outline the standards and expectations we uphold in this project.

**📓Code of Conduct:** We strictly adhere to the [Godot code of conduct](https://godotengine.org/code-of-conduct/) in this project. As a contributor, it is important to respect and follow this code to maintain a positive and inclusive community.

- - -

# 📇Contact us
If you have built a project, demo, script or example with this plugin let us know and we can publish it here in the repository to help us to improve and to know that what we do is useful.
