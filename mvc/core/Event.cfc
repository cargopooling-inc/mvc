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
	
	property mvc.util.adapters.ICacheAdapter cacheAdapter;
	property Struct eventHandler;
	property mvc.core.View _views;
	property Any helpers;
	
	variables.helpers = {};
	
	variables._arguments = {};
	variables._results = createObject('java','java.util.ArrayList').init();
	variables._values = {};
	variables._views = {};
	
	public Event function init( required Struct eventHandler, required mvc.Framework framework ){
		
		setEventHandler(eventHandler);
		setCacheAdapter( framework.getCacheAdapter() );
		variables._eventHandler = eventHandler; // set first event handler;
		variables._framework = framework;
		variables._views = new mvc.core.View();
		
		return this;
	}
	
	/*************************************************************************************    
    *    
    *    Views management    
    *    
    **************************************************************************************/
 
	public String function getView( required String name ){
		return variables._views.getValue( name );
	}
	
	public boolean function viewExists( required String name ){
		return variables._views.exists( name );
	}

    public String function getContentType(){
        return variables._eventHandler.contentType;
    }
	
	/*************************************************************************************    
    *    
    *    Value management    
    *    
    **************************************************************************************/
    
    private void function addArgument( required String name, required any value ){
		variables._arguments.put( arguments.name, arguments.value );
	}
	
	public any function getArgument( required String name, any defaultValue ){
		
		if( !isNull( arguments.defaultValue ) and !this.argumentExists( arguments.name ) ){
			
			return arguments.defaultValue;
			
		}
		
		return variables._arguments.get( arguments.name );
	}
    
    public boolean function argumentExists( required String name ){
		return variables._arguments.containsKey( arguments.name );
	}
	
	public void function setValue( required String name, required any value ){
		variables._values.put( arguments.name, arguments.value );
	}
	
	public any function getValue( required String name, any defaultValue='' ){
		
		if( !isNull( arguments.defaultValue ) and !this.exists( arguments.name ) ){
			
			return arguments.defaultValue;
			
		}
		
		return variables._values[ arguments.name ];
		
	}
	
	public Struct function getAll(){
		return variables._values;
	}
	 
	public void function removeValue( required String name ){
		variables._values.remove( arguments.name );
	}
	
	public boolean function exists( required String name ){
		return structKeyExists( variables._values, arguments.name );
	}
	
	public void function merge( required Struct values ){
		structAppend( variables._values, arguments.values );
	}

	/*************************************************************************************
    *    
    *    Results    
    *    
    **************************************************************************************/
    
	public void function addResult( required String name ){

        isRedirect( name );

		variables._results.add( name );
	}
	
	// create link
	public String function linkTo( required String event, String append="", String anchor="", Struct params={}, String host=variables._framework.getConfig('host'), String paramsPattern=variables._framework.getConfig('paramsPattern') ){
		return variables._framework.getURLManager().linkTo( event, this, append, anchor, params, host, paramsPattern );
	} 
	
	// forwward event 
	public void function forward( required String event, String append="", String anchor="", Struct params={}, String host=variables._framework.getConfig('host'), String paramsPattern=variables._framework.getConfig('paramsPattern'), boolean addtoken=false, statuscode=302 ){
		var link = linkTo( event, append, anchor, params, host, paramsPattern );
		forwarToUrl( link, addtoken, statuscode );
	}
	
	// forward to url
	public void function forwarToUrl( required String url, boolean addtoken=false, statuscode=302 ){
		location( url=arguments.url, addtoken=addtoken, statuscode=statuscode );
	}
	
	/*************************************************************************************    
    *    
    *    Command    
    *    
    **************************************************************************************/	
	
	public void function execute(){
		
		var ckey = "";
		var event = getEventHandler();

		// get cache before execute all event handlers
		if( variables._eventHandler.cache == true and variables._eventHandler.cachekey != '' ){

			// create cache key
			ckey = createCacheKey( variables._eventHandler.cachekey );

			if( getCacheAdapter().exists( ckey, "mvc.core.Event" ) == true ){

                trace( type='Information', text="Cache Exists " );

				variables._views.setValue( "main", getCacheAdapter().get( ckey, "mvc.core.Event" ) );

				return;
			}

		}

        // interceptor before
        executeInterceptors( event, 'before' );

        // trigger
        trigger( event );

        // interceptor after
        executeInterceptors( event, 'after' );

		// render vews
        renderViews( event );

		// results
        iterateResults( event );

		if( variables._eventHandler.cache == true and variables._eventHandler.cachekey != '' ){

            if( event.name == variables._eventHandler.name ){

                // create cache key
                ckey = createCacheKey( variables._eventHandler.cachekey );

                getCacheAdapter().put( ckey, variables._views.getValue( "main" ), variables._eventHandler.cacheTimeout, "mvc.core.Event" );

            }

		}

        return;
	}

	private void function executeInterceptors( required Struct event, required String position ){

		var next = "";
		var ckey = "";
		var iterator = event.interceptor.iterator();
		var interceptor = "";

        while( iterator.hasNext() ){

            next = iterator.next();

            if( variables._framework.interceptorExists( next ) ){

                interceptor = variables._framework.getInterceptors().get( next ).get( position );

                // trigger
                trigger( interceptor );

                // render vews
                renderViews( interceptor );

                // results
                iterateResults( interceptor );

            }

        }

        return;
	}

    private void function trigger( required Struct event ){

        var arg = "";
        var args = "";
        var trigger = {};
        var triggers = arguments.event.triggers.iterator();

        // execute all triggers
        while( triggers.hasNext() ){

            trigger = triggers.next();

            args = trigger.values.iterator();

            while( args.hasNext() ){

                arg = args.next();

                addArgument( arg.name, arg.value );

            };

            invokeListeners( trigger.name );

        }

    }

    private void function renderViews( required Struct event ){

        var viewRenderer = "";
        var views = arguments.event.views.iterator();
        var view = {};
        var values = "";
        var value  = {};
        var ckey = "";

        while( views.hasNext() ){

            view = views.next();

            values = view.values.iterator();

            while( values.hasNext() ){

                value = values.next();

                setValue( value.name, value.value );

            }

            // manage the cache views
            if( view.cache == true and view.cachekey != '' ){

                // create cache key
                ckey = createCacheKey( view.cachekey );
                ckey = hash( ckey & view.name & view.template );

                if( getCacheAdapter().exists( ckey ) == false ){

                    viewRenderer = variables._framework.getTemplateRenderer().render( this, view.template );

                        getCacheAdapter().put( ckey, viewRenderer, view.cachetimeout );

                }else{

                    viewRenderer = getCacheAdapter().get( ckey );

                }

            }else{

                viewRenderer = variables._framework.getTemplateRenderer().render( this, view.template);

            }

            variables._views.setValue( view.name, viewRenderer, view.conflict );

        }

    }

    private void function iterateResults( required Struct event ){

        var results = arguments.event.results.iterator();
        var result = {};

        while( results.hasNext() ){

            result = results.next();

            if( len( result.name ) ){

                if( arrayFind( variables._results, result.name ) ){

                    if( result.redirect == false ){

                        executeNextEvent( result.to );

                    }else{

                        this.forward( event=result.to, append=result.append, statuscode=result.statuscode );

                    }

                }

            }else{

                if( result.redirect == false ){

                    executeNextEvent( result.to );

                }else{

                    this.forward( event=result.to, append=result.append, statuscode=result.statuscode );

                }

            }

        }

    }

    private void function isRedirect( required String name ){

        var results = getEventHandler().results.iterator();
        var result = {};

        while( results.hasNext() ){

            result = results.next();

            if( len( result.name ) ){

                if( result.name == arguments.name ){

                    if( result.redirect == true ){

                        this.forward( event=result.to, append=result.append, statuscode=result.statuscode );

                    }

                }

            }

        }

    }
	
	private void function executeNextEvent( required String name ){
		var event = variables._framework.getEventHandlers()[ name ];
		
		setEventHandler( event );
		
		this.execute();
		
	}
	
	private void function invokeListeners( required String name ){
		var listeners = variables._framework.getListeners();
		var iterator = "";
		var listener = "";

        if( structKeyExists( listeners, name ) ){

            iterator = listeners[ name ].iterator();

            while( iterator.hasNext() ){

                listener = iterator.next();

                invoke( listener.controller, listener.listener, { event=this } );

                //listener.controller[ listener.listener ]( event=this );

            }

        }else if( variables._framework.getConfig( 'developmentMode' ) ){

            variables._framework.getLogger().write( text="No Listeners with name: #arguments.name#" );

        }

	}
	
	private String function createCacheKey( required String keys ){
		var key = "";
		var i = 0;
		var t = "";
		
		for( i=1; i<=listLen( keys ); i++ ){
			t = listGetAt( keys, i );
			key = key & t & this.getValue( t );
		}
		
		return key;
	}
	
}