/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.uhapp.semi;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author adalberto
 */
public class Json_encoder {
    public static String encode(Object o) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        String json = "{";
        for (Method method : o.getClass().getDeclaredMethods()) {
            if (method.getName().substring(0, 3).equals("get") || method.getName().substring(0, 2).equals("is")) {
                for (Field declaredField : o.getClass().getDeclaredFields()) {
                    
                    if (declaredField.getName().toLowerCase().equals(method.getName().substring(3, method.getName().length()).toLowerCase())) {
                        if (declaredField.getClass().isPrimitive() || declaredField.getType().getSimpleName().equals("String") || declaredField.getType().getSimpleName().equals("int")) {
                            json += "\"" + declaredField.getName() + "\":\"" + method.invoke(o) + "\",";
                        }
                        else if(!declaredField.getClass().isPrimitive()) {
                            
                            if (declaredField.getType().getSimpleName().equals("ArrayList")) {
                                //declaredField.setAccessible(true);
                                //System.out.println(declaredField.get(o).getClass().getDeclaredMethod("get").invoke(declaredField.get(o), 0).getClass().getSimpleName());
                            }
                            else if(declaredField.getType().getSimpleName().equals("Date"))
                                json += "\"" + declaredField.getName() + "\":\"" + method.invoke(o) + "\",";
                            else {
                                declaredField.setAccessible(true);
                                json += "\"" + declaredField.getName() + "\":" + Json_encoder.encode(declaredField.get(o)) + ",";
                            }
                        }
                            
                        
                    }
                    else if (declaredField.getName().equals(method.getName().substring(2, method.getName().length()).toLowerCase())) {
                        
                        json += "\"" + declaredField.getName() + "\":\"" + method.invoke(o) + "\",";
                    }
                    
                }
            }  
        }
        json = json.substring(0, json.length() - 1) + "}";

        
        return json;
    }
}
