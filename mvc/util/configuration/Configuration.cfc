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
component  output="false" implements="IConfiguration"{
	
	public Configuration function init( required mvc.Framework framework ){
		
		variables._framework = framework;
		variables._configuration = framework.getConfigurations();

        setDefault();
		
		run();
		
		return this;
	}
	
	package void function setConfig( required String name, required Any value ){
		variables._framework.setConfig( name, value );
	}
	
	package Struct function newController( required String name, required String class ){

		return {'name'=name,'class'=class,'bindings'=[]};
	}
	
	package void function addController( required Struct controller ){
		variables._framework.addController( controller.name, controller.class, controller.bindings );
	}
	
	package Struct function newEvent( required String name, String access="public", boolean cache=false, String cachekey="", Numeric cachetimeout=0, String interceptor="", String contentType="text/html; charset=utf-8" ){

		return {'name'=name,'access'=access,'cache'=cache,'cachekey'=cachekey,'cachetimeout'=cachetimeout,'triggers'=[],'results'=[],'views'=[],'interceptor'=listToArray( interceptor, ',' ),'contentType'=contentType};
	}
	
	package void function addEvent( required Struct event ){
		variables._framework.addEvent( event.name, event.access, event.cache, event.cachekey, event.cachetimeout, event.triggers, event.views, event.results, event.interceptor, event.contentType );
	}
	
	package Struct function trigger( required String name, Array values=[] ){
		return {'name'=name,'values'=values};
	}
	
	package Struct function bind( required String name, required String handler ){
		return {'name'=name,'handler'=handler};
	}
	
	package Struct function view( required String name, required String template, String conflict="overwrite", Array values=[], 
								 boolean cache=false, String cachekey="", Numeric cachetimeout=0 ){
	
		return {'name'=name,'template'=template,'conflict'=conflict,'values'=values,'cache'=cache,'cacheKey'=cachekey,'cacheTimeout'=cachetimeout};
	}
	
	package Struct function addValue( required String name, required String value ){
		return {'name'=name,'value'=value};
	}
	
	package Struct function result( String name="", required String to, boolean redirect=false, String append="" ){
		return {'name'=name,'to'=to,'redirect'=redirect,'append'=append};
	}

    package Struct function newInterceptor( required String name, required String position ){
        return {'name'=name,'position'=position,'triggers'=[],'results'=[],'views'=[]};
    }

    package void function addInterceptor( required Struct interceptor ){
        variables._framework.addInterceptor( interceptor.name, interceptor.position, interceptor.triggers, interceptor.views, interceptor.results );
    }
	
	
	public void function run(){
		
	}
	
	// default event handler
	private void function setDefault(){
		
		var event = "";

		event = newEvent( "framework.onRequestStart" );
		event.triggers.add( trigger( "onRequestStart" ) );
		
		addEvent( event );
		
		event = newEvent( "framework.onRequestEnd" );
		event.triggers.add( trigger( "onRequestEnd" ) );
		
		addEvent( event );
		
		event = newEvent( "framework.onApplicationStart" );
		event.triggers.add( trigger( "onApplicationStart" ) );
		
		addEvent( event );
		
		event = newEvent( "framework.onSessionStart" );
		event.triggers.add( trigger( "onSessionStart" ) );
		
		addEvent( event );
		
		event = newEvent( "framework.onSessionEnd" );
		event.triggers.add( trigger( "onSessionEnd" ) );
		
		addEvent( event );
		
	}

}