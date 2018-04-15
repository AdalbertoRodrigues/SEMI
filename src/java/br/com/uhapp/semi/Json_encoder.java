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
                        if (declaredField.getClass().isPrimitive() || declaredField.getType().getSimpleName().equals("String")) {
                            json += "\"" + declaredField.getName() + "\":\"" + method.invoke(o) + "\",";
                        }
                        else if(!declaredField.getClass().isPrimitive()) {
                            
                            if (declaredField.getType().getSimpleName().equals("ArrayList")) {
                                //declaredField.setAccessible(true);
                                //System.out.println(declaredField.get(o).getClass().getDeclaredMethod("get").invoke(declaredField.get(o), 0).getClass().getSimpleName());
                            }
                            else if(declaredField.getType().getSimpleName().equals("Date"))
                                json += "\"" + declaredField.getName() + "\":\"" + method.invoke(o).toString() + "\",";
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
    public static void main(String args[]) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        Usuario usuario = new Usuario("123", "aaa", "1234", "0");
        Carga carga = new Carga("0", 20, "xxx", "20x20");
        
        
        Motorista motorista = new Motorista("123", true, new Date(2018, 1, 1), "123", "nome", "1234", "1");
        Endereco endereco = new Endereco("11700", "Praia Grande", "SP", "BR", "rua", "pontoDeReferencia", "complemento");
        Endereco endereco2 = new Endereco("11700", "Praia Grande", "SP", "BR", "rua", "pontoDeReferencia", "complemento");
        Mensagem mensagem = new Mensagem("eae", usuario);
        Chat chat = new Chat(motorista, usuario, new ArrayList<>());
        chat.getMensagens().add(mensagem);
        chat.getMensagens().add(mensagem);
        chat.getMensagens().add(mensagem);
        
        Viagem viagem = new Viagem(endereco, endereco2, new Date(2018, 10, 20), 20, "ok", chat, carga);
        
        ArrayList viagens = new ArrayList<Viagem>();
        viagens.add(viagem);
        viagens.add(viagem);
        viagens.add(viagem);
        motorista.setViagens(viagens);
        //motorista.getClass().getDeclaredField("viagens").setAccessible(true);
        Method metodo = motorista.getClass().getDeclaredMethod("getViagens");
        Object lista = metodo.invoke(motorista);
        
        //System.out.println(lista.getClass().getMethod("get").getName());
        
        System.out.println(Json_encoder.encode(motorista));
    }
}
