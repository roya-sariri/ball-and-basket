extends Node

const save_loacation = "res://save/data.json"
var save_dict = {"name": "name", "level": 1, "point": 0, "heart": 3}

var color_lst = [Color(1, 0.50, 0.93), Color(0.98, 0.94, 0),
Color(0.97, 0.18, 0.16), Color(0.58, 0.40, 0.80), Color(0.78, 0.85, 11),
Color(0.7, 1, 0.1), Color(0.31, 0.88, 0.82), Color(0.40, 0.31, 0.01),
 Color(0.14, 0.18, 0.23)]

var remaining_color_lst = []
#1, 0.50, 0.93#pink
#0.98, 0.94, 0#yellow
#0.98, 0.63, 0.18#orange
#0.97, 0.18, 0.16#red
#0.58, 0.40, 0.80#perpule
#0.78, 0.85, 11#blue
#0.7, 1, 0.1#green
#0.31, 0.88, 0.82#blue_green
#0.40, 0.31, 0.01#brown
#0.14, 0.18, 0.23#black
