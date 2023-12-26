var keys = struct_get_names(listeners.step);
for (var n=0; n<array_length(keys); n++) {
	var listener = listeners.step[$ keys[n]];
	with (listener.entity) {
		listener.event();
	}
}
