package com.way.you.Util;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.way.you.bean.Combean;

public class ComBeanSerializer implements JsonSerializer<Combean> {

	@Override
	public JsonElement serialize(Combean vo, Type typeOfVo, JsonSerializationContext context) {
		return context.serialize((Object) vo);
	}

}
