function scr_id() {
    static counter = 0;
    counter++;
    return "ID" + string(counter);
}

function scr_subscribe(eventType, functionRef){
  var _id = id;
  var evId = scr_id();
  with(obj_pubsub) {
	  listenerEventLookup[$ evId] = {
		  eventType: eventType,
		  entity: _id,
	  };
	  if (!struct_exists(listenerEntityLookup, _id)) {
		  listenerEntityLookup[$ _id] = [];
	  }
	  array_push(listenerEntityLookup[$ _id], evId);
	  listeners[$ eventType][$ evId] = {
		  entity: _id,
		  event: functionRef,
	  };
  }
  return evId;
}

function scr_unsubscribe(evId) {
	var _id = id;
	with(obj_pubsub) {
		struct_remove(listenerEntityLookup, _id);
		var eventType = listenerEventLookup[$ evId].eventType;
		struct_remove(listenerEventLookup, evId);
		struct_remove(listeners[$ eventType], evId);
	}
}

function scr_unsubscribeAll() {
	var _id = id;
	with(obj_pubsub) {
		if (struct_exists(listenerEntityLookup, _id)) {
			var evIds = listenerEntityLookup[$ _id];
			for (var n=0; n<array_length(evIds); n++) {
				var evId = evIds[n];
				var eventType = listenerEventLookup[$ evId].eventType;
				struct_remove(listenerEventLookup, evId);
				struct_remove(listeners[$ eventType], evId);
			}
			struct_remove(listenerEntityLookup, _id);
		}
	}
}