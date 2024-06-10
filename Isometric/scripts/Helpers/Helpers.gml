// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function inArray(arr, val){
	
	if typeof(val) == "struct" { // compare struct VALUES instead of references
		for (var i = 0; i < array_length(arr); i++){
				if compareStructs(arr[i], val) return i
		}
		return -1	
	}
	
	// compare arrays using array_equals if value is an array. arr must be 2D for this to happen
	if typeof(val) == "array" {
		for (var i = 0; i < array_length(arr); i++){
			if typeof(arr[i]) == "array" and array_equals(arr[i], val) return i
		}
		return -1	
	}
	
	for (var i = 0; i < array_length(arr); i++){
			if arr[i] == val return i
	}
	return -1
}

function compareStructs(struct1, struct2) {
	var keys1 = variable_struct_get_names(struct1)
	var keys2 = variable_struct_get_names(struct2)
	
	if array_length(keys1) != array_length(keys2) return false
	
	for (var i = 0; i < array_length(keys1); i++) {
		if variable_struct_get(struct1, keys1[i]) != variable_struct_get(struct2, keys1[i]) return false
	}
	return true
	
}

function print(str) {
	show_debug_message(str)
}	
	