component asyncAll="false" labels="list" skip="false"{

    function beforeTests(){

    }
    function afterTests(){

    }

    public void function testLinkTo(){

        _configurations = {

            urlManager="mvc.util.url.SESURLManager",
            viewLocation= "./views/",
            eventName="event",
            errorEvent="exception",
            missingEvent="not-found",
            defaultEvent="home",
            reloadKey="init",
            reloadPassword="true",
            configurationClass="mvc.util.configuration.XmlConfiguration",
            configurationXml="/test/mvc/config/mvc.xml",
            cacheAdapter="mvc.util.adapters.CacheAdapter",
            cacheConfigurationFile="/mvc/util/adapters/cache.xml",
            cacheDefaultTimeout=30,
            cacheDefaultSweep=30,
            loggerClass="mvc.util.log.Logger",
            developmentMode=true,
            beanFactoryAdapter="mvc.util.adapters.BeanFactoryAdapter",
            beanFactoryAdapterScope="request",
            beanFactoryAdapterVar="mvc_beanFactory"

        };

        var fw = new mvc.Framework( _configurations );
        var conf = new mvc.util.configuration.XmlConfiguration( fw );

        var event = new mvc.core.Event( fw.getEventHandlers()['home'], fw );

        var um = new mvc.util.url.SESURLManager( fw );

        event.setValue( 'lang', 'it' );
        event.setValue( 'cane', 'pippo' );

        // required String event, required mvc.core.Event context, String append="", String anchor="", Struct params={}, String host="", String paramsPattern=""

        debug( um.linkTo( event='home', context=event, append="cane,lang", anchor="anchor", params={'gatto'='birba','topo'='jerry'}, host="http://localhost:8080", paramsPattern="lang>event>cane>gatto>topo"  ) );

        assert( len( um.linkTo( 'home', event ) )  );

    }

}
