<p align="center">
	<img width="256px" src="https://github.com/GodotParadise/FSM/blob/main/icon.jpg" alt="GodotParadiseFSM logo" />
	<h1 align="center">Godot Paradise FSM</h1>
	
[![LastCommit](https://img.shields.io/github/last-commit/GodotParadise/FSM?cacheSeconds=600)](https://github.com/GodotParadise/FSM/commits)
[![Stars](https://img.shields.io/github/stars/godotparadise/FSM)](https://github.com/GodotParadise/FSM/stargazers)
[![Total downloads](https://img.shields.io/github/downloads/GodotParadise/FSM/total.svg?label=Downloads&logo=github&cacheSeconds=600)](https://github.com/GodotParadise/FSM/releases)
[![License](https://img.shields.io/github/license/GodotParadise/FSM?cacheSeconds=2592000)](https://github.com/GodotParadise/FSM/blob/main/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=github)](https://github.com/godotparadise/FSM/pulls)
</p>

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://github.com/GodotParadise/FSM/blob/main/locale/README.es-ES.md)

- - -

PLUGIN DESCRIPTION

- [Requirements](#requirements)
- [✨Installation](#installation)
	- [Automatic (Recommended)](#automatic-recommended)
	- [Manual](#manual)
- [You are welcome to](#you-are-welcome-to)
- [Contribution guidelines](#contribution-guidelines)
- [Contact us](#contact-us)


# Requirements
📢 We don't currently give support to Godot 3+ as we focus on future stable versions from version 4 onwards
* Godot 4+

# ✨Installation
## Automatic (Recommended)
You can download this plugin from the official [Godot asset library](https://godotengine.org/asset-library/asset/2039) using the AssetLib tab in your godot editor. Once installed, you're ready to get started
##  Manual 
To manually install the plugin, create an **"addons"** folder at the root of your Godot project and then download the contents from the **"addons"** folder of this repository.

# Getting started
The finite state machine can be added as any other node in the scene tree where you want to use it. 
![fsm-add-node](https://github.com/GodotParadise/FSM/blob/main/images/fsm_add_child.png)
![fsm-added-scene-tree](https://github.com/GodotParadise/FSM/blob/main/images/fsm_added_scene_tree.jpg)

⚠️ The finite state machine **always need at least one default state** to start with, this default state can be set on the exported variable `current_state`. Once this is done, when executing the scene this will be the current state of the machine until the conditions that change the state occur.

There will always be only one `physic_process()` or `_process()` since it is the main machine that is in charge of calling the virtual methods of each state.If your state overrides `physics_update()` will be executed as `physic_process()`

`_enter()` and `_exit()` are called when the new state becomes the current and when it will transition to another state. They are useful to clean up or get ready some sort of parameters inside the state to be used only in this state.
 
# Basics
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

So for example if you want to implement a **Idle** state it's easy as:
```py
class_name Idle extends GodotParadiseState

func _enter() -> void:
	# play animations...
	# set velocity to zero...

func _exit() -> void:
	# stop animation...

func _physics_update(delta):
	# detect the input direction to change to another state such as Walk or Crouch
```



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
