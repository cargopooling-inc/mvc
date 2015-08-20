/**
  *
  *
  *    Copyright 2015 - Cargopoooling, Inc. - U.S.A.
  *    Author: Cristian Costantini
  *    www.cargopooling.com
  *
  *    Licensed under the Apache License, Version 2.0 (the "License");
  *    you may not use this file except in compliance with the License.
  *    You may obtain a copy of the License at
  *
  *    http://www.apache.org/licenses/LICENSE-2.0
  *
  *    Unless required by applicable law or agreed to in writing, software
  *    distributed under the License is distributed on an "AS IS" BASIS,
  *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  *    See the License for the specific language governing permissions and
  *    limitations under the License.
  *
  *
**/
component {

    // default configurations
    _configurations = {

        urlManager="mvc.util.url.URLManager",
        viewLocation= "./views/",
        eventName="event",
        errorEvent="exception",
        errorEventStatus="500",
        missingEvent="not-found",
        missingEventStatus="404",
        defaultEventStatus="200",
        defaultEvent="home",
        reloadKey="init",
        reloadPassword="true",
        configurationClass="mvc.util.configuration.XmlConfiguration",
        configurationXml="config/mvc.xml",
        cacheAdapter="mvc.util.adapters.DefaultCacheAdapter",
        cacheConfigurationFile="/mvc/util/adapters/cache.xml",
        cacheDefaultTimeout=30,
        cacheDefaultSweep=30,
        flushCache='flush',
        paramsPattern='event',
        host='',
        loggerClass="mvc.util.log.Logger",
        developmentMode=true,
        beanFactoryAdapter="mvc.util.adapters.BeanFactoryAdapter",
        beanFactoryAdapterScope="request",
        beanFactoryAdapterVar="mvc_beanFactory"

    };

    this.mvc_configurations = {};

    variables.initialized = false;


    // flush cache
    param name="url[ _configurations.flushCache ]" type="String" default="";

    // bootstrap params
    param name="url[ _configurations.reloadKey ]" type="String" default="";


    public function bootstrap(){

        var framework = "";
        var beanFactoryAdapter = "";

        structAppend( _configurations, this.mvc_configurations, true );

        trace( type='Information', text="bootstrap framework..." );

        lock scope="Application" timeout="30" throwontimeout="true" type="exclusive" {

            framework = new mvc.Framework( _configurations );

            beanFactoryAdapter = createObject( 'component', _configurations.beanFactoryAdapter ).init( _configurations.beanFactoryAdapterScope , _configurations.beanFactoryAdapterVar );

            if( beanFactoryAdapter.exists() ){

                framework.setBeanFactory( beanFactoryAdapter );

            }

            // load configuration
            createObject( "component", _configurations.configurationClass ).init( framework );

            // load cache adapter
            createObject( "component", _configurations.cacheAdapter ).init( framework );

            application._framework = framework;

        }

    }

    public function onApplicationStart(){

            bootstrap();

    }

    public function onSessionStart(){

        application._framework.executeEvent( 'framework.onSessionStart' );

    }

    public function onSessionEnd(){

        application._framework.executeEvent( 'framework.onSessionEnd' );

    }

    public function onRequestStart(){

        structAppend( _configurations, this.mvc_configurations, true );

        if( !structKeyExists( url, _configurations.reloadKey ) ){
            url[ _configurations.reloadKey ] = "-_NULL_-";
        }

        if( !structKeyExists( url, _configurations.flushCache ) ){
            url[ _configurations.flushCache ] = "-_NULL_-";
        }

        if( url[ _configurations.reloadKey ] == _configurations.reloadPassword or _configurations.developmentMode == true ){

            trace( type='Information', text="reload framework..." );

            bootstrap();

        }

        if( url[ _configurations.flushCache ] == true  or _configurations.developmentMode == true ){

            application._framework.getCacheAdapter().flush();

        }

        request._configurations = _configurations;
        request._framework = application._framework;

        if( variables.initialized == false ){

            variables.initialized = true;

            application._framework.executeEvent( 'framework.onApplicationStart' );

        }

    }

}
