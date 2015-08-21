component extends="mvc.core.Controller" {

    public void function sayHello( required Any event ){

        var user = new examples.helloworldmg.model.bean.User();

        user.setName( event.getValue( 'name' ) );

        event.setValue( 'hello.message', user );

    }

}
