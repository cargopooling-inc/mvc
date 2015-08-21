component asyncAll="false" labels="list" skip="false"{

    function beforeTests(){

    }
    function afterTests(){

    }

    public void function testExists(){

        var view = new mvc.core.View();

        assert( view.exists( 'test' ) == false );

    }

    public void function testGetValue(){

        var view = new mvc.core.View();

        assert( len( view.getValue( 'test' ) ) < 1 );

    }

    public void function testGetAll(){

        var view = new mvc.core.View();

        assert( len( view.getValue( 'test' ) ) < 1 );

    }

    public void function testSetValue(){

        var view = new mvc.core.View();

        view.setValue( 'test', 'pippo' );

        assert( view.getValue( 'test' ) == 'pippo' );

    }

}