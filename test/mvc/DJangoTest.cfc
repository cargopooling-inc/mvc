component asyncAll="false" labels="list" skip="false"{

    function beforeTests(){

    }
    function afterTests(){

    }

    public void function onApplicationStartTest(){

        var django = new mvc.DJango();

        django.onApplicationStart();

    }

    public void function onSessionStartTest(){

        var django = new mvc.DJango();

        django.onSessionStart();

    }


    public void function onSessionEndTest(){

        var django = new mvc.DJango();

        django.onSessionEnd();

    }

    public void function onRequestStartTest(){

        var django = new mvc.DJango();

        django.onRequestStart();

    }

}
