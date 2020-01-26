/**
 * Created by Evgen on 25.01.2020.
 */

@IsTest
private class AnimalDTOTests {
    static testMethod void testParse() {
        String json = '{\"animal\":{\"id\":1,\"name\":\"chicken\",\"eats\":\"chicken food\",\"says\":\"cluck cluck\"}}';
        AnimalDTO obj = AnimalDTO.parse(json);
        System.assert(obj != null);
    }
}