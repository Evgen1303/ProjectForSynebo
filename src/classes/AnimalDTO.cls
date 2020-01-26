/**
 * Created by Evgen on 25.01.2020.
 */

public with sharing class AnimalDTO {

    public Animal animal;

    public class Animal {
        public Integer id;
        public String name;
        public String eats;
        public String says;
    }


    public static AnimalDTO parse(String json) {
        return (AnimalDTO) System.JSON.deserialize(json, AnimalDTO.class);
    }
}