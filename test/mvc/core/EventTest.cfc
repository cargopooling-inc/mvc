component asyncAll="false" labels="list" skip="false"{

    function beforeTests(){

    }
    function afterTests(){

    }

    public void function testConstructor(){

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

    }

    public void function testGetView(){

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

        assert( event.getView('pippo') == "" );

    }

    public void function testViewExists(){

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

        assert( event.viewExists('pippo') == false );

    }

    public void function testGetArgument(){

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

        assert( event.getArgument('test','pippo') == 'pippo' );

    }

    public void function testArgumentExists(){

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

        assert( event.argumentExists('test') == false );

    }

    public void function testSetValue(){

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

        event.setValue( 'test', 'pippo' );

        assert( event.getValue('test') == 'pippo' );

    }

    public void function testExists(){

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

        event.setValue( 'test', 'pippo' );

        assert( event.exists('test') );

    }

    public void function testGetAll(){

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

        event.setValue( 'test', 'pippo' );

        assert( structIsEmpty( event.getAll() ) == false );

    }

    public void function testRemove(){

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

        event.setValue( 'test', 'pippo' );
        event.removeValue( 'test' );

        assert( structIsEmpty( event.getAll() ) == true );

    }

    public void function testLikTo(){

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
            beanFactoryAdapterVar="mvc_beanFactory",
            flushCache='flush',
            paramsPattern='event',
            host=''

        };

        var fw = new mvc.Framework( _configurations );
        var conf = new mvc.util.configuration.XmlConfiguration( fw );

        var event = new mvc.core.Event( fw.getEventHandlers()['home'], fw );

        assert( len( event.linkTo( 'home' ) ) > 0   );

    }




}