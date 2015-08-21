component asyncAll="false" labels="list" skip="false"{

    function beforeTests(){

    }
    function afterTests(){

    }

    public void function testLinkTo(){

        _configurations = {

            urlManager="mvc.util.url.URLManager",
            viewLocation= "./views/",
            eventName="event",
            errorEvent="exception",
            missingEvent="not-found",
            defaultEvent="home",
            reloadKey="init",
            reloadPassword="true",
            configurationClass="mvc.util.configuration.XmlConfiguration",
            configurationXml="config/mvc.xml",
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

        var um = new mvc.util.url.URLManager( fw );

        assert( len( um.linkTo( 'home', event ) ) > 0 );

    }

}
