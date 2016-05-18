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
component  output="false" accessors="true"{
	
	// utils
	property mvc.util.url.IURLManager urlManager;
	property mvc.util.template.TemplateRenderer templateRenderer;
	property mvc.util.adapters.ICacheAdapter cacheAdapter;
	property mvc.util.log.ILogger logger;
	property Struct helpers;
	
	// IOC Adapter
	property mvc.util.adapters.IBeanFactoryAdapter beanFactory;
	
	// configurations
	property Struct listeners;
	property Struct controllers;
	property Struct eventHandlers;
	property Struct interceptors;
	property Struct aliases;
	property Struct configurations;
	
	// default configurations
	variables.configurations = {};

	// constructor
	public Framework function init( Struct configurations={}, Struct helpers={} ){
		
		variables.listeners = {};
		variables.controllers = {};
		variables.beanFactory = "";
		variables.eventHandlers = {};
		variables.interceptors = {};
		variables.aliases = {};

		variables.configurations = configurations;
		
		// URL manager
		setUrlManager( createObject("component", variables.configurations.urlManager ).init( this ) );

        // template renderer
		setTemplateRenderer( new mvc.util.template.TemplateRenderer( getConfigurations()['viewLocation'] ) );

        // logger
        setLogger( createObject("component", variables.configurations.loggerClass ) );
		
		setHelpers( helpers );

        variables.errorRenderer = new mvc.util.error.Error();
 
		return this;
	}
	
	/**    
      *    
      *    Configuration management methods    
      *    12.05.12    
      *    15:04:41 PM      
      *    Author: Cristian Costantini    
      *        
      *    
    **/
	
	// set value to configuration
	public void function setConfig( required String name, required Any value ){
		getConfigurations().put( name, value );
	}
	
	// get value from configuration
	public Any function getConfig( required String name ){

		return getConfigurations()[ name ];
	}
	
	// add controller
	public void function addController( required String name, required String class, Array bind=[] ){
		var controller = createObject("component", class ).init( this );
		var iterator = bind.iterator();
		var next = {};
		
		// set controller properties
		controller.setBeanFactory( getBeanFactory() );
		controller.setHelpers( getHelpers() );
		
		while( iterator.hasNext() ){
			next = iterator.next();
			registerListener( next.name, next.handler, controller ) ;
		}
		
		getControllers().put( name, controller );
	}
	
	// add event
	public void function addEvent( required String name, String access='public', boolean cache=false, 
								   String cachekey, Numeric cachetimeout, Array triggers=[], Array views=[],
                                   Array results=[], Array interceptor=[], String contentType="",
                                   boolean rest=false, String method="" ){
	
		getEventHandlers().put( name, {'name'=name,'access'=access,'cache'=cache,'cacheKey'=cachekey,'cachetimeout'=cachetimeout,'triggers'=triggers,'views'=views,'results'=results, 'interceptor'=interceptor, 'contentType'=contentType, 'rest'=rest, 'method'=method} );
	}

	// add interceptor
	public void function addInterceptor( required String name, required String position, Array triggers=[], Array views=[], Array results=[] ){

        if( !interceptorExists( name ) ){
            getInterceptors().put( name, {'before'={},'after'={} } );
        }

        getInterceptors().get( name ).put( position, {'name'=name,'triggers'=triggers,'views'=views,'results'=results} );

	}

    // interceptor exists
    public boolean function interceptorExists( required String name ){
        return structKeyExists( getInterceptors(), name );
    }

	// event handler exists
    public boolean function eventExists( required String name ){
        return structKeyExists( getEventHandlers(), name );
    }

    // add alias
    public void function addAlias( required String name, required String event, required String language ){

        getAliases().put( name, {'event'=event,'language'=language} );
    }

    // alias exists
    public boolean function aliasExists( required String name ){

        return structKeyExists( getAliases(), name );
    }

    // get alias from event if exists otherwise return event name
    public String function getAlias( required String event, required String language ){

        var alias = event;
        var aliases = getAliases();

        for( var a in aliases ){

            if( aliases[ a ].event == event && aliases[ a ].language == language ){

                alias = a;

                break;

            }

        }

        return alias;
    }

	// execute event handler
	public mvc.core.Event function executeEvent( required String name, Struct values={}, mvc.core.Event eh ){
		
		var event = "";
		var local.eh = {};
		
		try{

            if( structKeyExists( request, 'language' ) ){

                values.put( 'language', request.language );

            }

			if( !eventExists( name ) ){

                if( !aliasExists( name ) ){

				    return onMissingEvent( name );

                }else{

                    var alias = getAliases().get( name );

                    values.put( 'alias', name );

                    local.eh = getEventHandlers()[ alias.get('event') ];

                }

			}else{

			    local.eh = getEventHandlers()[ name ];

			}

			if( !local.eh.access == "public" ){

				throw( "Event handler #name# is private." );
			}

            if( local.eh.rest == true ){

                var requestData = getHttpRequestData();

                if( requestData.method == local.eh.method ){

                    values.put( 'content', requestData.content );

                }else{

                    throw( "Request method is not #local.eh.method#" );

                }

            }

			event = new mvc.core.Event( eventHandler=local.eh, framework=this );

            if( structKeyExists( arguments, 'eh' ) ){

                event.merge( arguments.eh.getAll() );

            }
			
			structAppend( values, form );
			structAppend( values, url );

			event.merge( values );

            event.setValue( 'http-status-code', getConfig('defaultEventStatus') );
			
			event.execute();
			
			return event;
			
		}catch( Any e ){
			
			return onError( e, local.eh );
			
		}

	}
	
	// execute missing event
	private mvc.core.Event function onMissingEvent( required String name ){
		
		var event = "";
		var missingEvent = "";
		var local.eh = {};
		
		if( !eventExists( getConfig( 'missingEvent' ) ) ){
			throw( "Event handler #name# is undefined" );
		}

		local.eh = getEventHandlers()[ getConfig( "missingEvent" ) ];
		
		event = new mvc.core.Event( eventHandler=local.eh, framework=this );
		
		structAppend( form, url );
			
		event.merge( form );

        event.setValue( 'http-status-code', getConfig('missingEventStatus') );

		event.execute();

		return event;
	}

	// execute on error event
	private mvc.core.Event function onError( required Any catchValues, Struct cnf={} ){

		var errorEvent = "";
		var values = {};
		var event = "";
		var eh = {};
		var er = "";

        param name="arguments.cnf.rest" default="false";

        errorEvent = iif( arguments.cnf.rest == true, de("restErrorEvent"), de("errorEvent") );

		if( !eventExists( getConfig( errorEvent ) ) ){

            er = variables.errorRenderer.generateError( catchValues );

			writeOutput( er );
            abort;

		}

		eh = getEventHandlers()[ getConfig( errorEvent ) ];

		event = new mvc.core.Event( eventHandler=eh, framework=this );

		structAppend( values, url );
		structAppend( values, form );
		structAppend( values, {'errors'=arguments.catchValues } );

		event.merge( values );

        event.setValue( 'http-status-code', getConfig('errorEventStatus') );

		event.execute();
		
		return event;
	}
	
	// register a controller listener 
	private void function registerListener( required String eventName, required String listener, required Any controller ){
		
		if( !getListeners().containsKey( eventName ) ){

			getListeners().put( eventName, createObject('java','java.util.ArrayList').init() );

		}
		
		getListeners().get( eventName ).add( {'listener'=listener,'controller'=controller} );
		
	}
	
}