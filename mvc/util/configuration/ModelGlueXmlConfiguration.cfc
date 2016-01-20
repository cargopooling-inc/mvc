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
component extends="mvc.util.configuration.Configuration" output="false"{
	
	public void function run(){
		
		var xml = parseConfiguration( expandPath( variables._configuration.configurationXml ) );
		
		loadInclude( xml );

		load( xml );
		
	}
	
	private void function load( required Xml xml ){

		loadConfig( xml );

		loadController( xml );

		loadEvent( xml );

        loadInterceptor( xml );

	}
	
	private void function loadInclude( required Xml xml ){
		var includes = xmlSearch( xml, "/modelglue/include/" );
		var iterator = includes.iterator();
		var config = "";
		
		while( iterator.hasNext() ){
			
			config = iterator.next();
			
			load( parseConfiguration( expandPath( config.xmlAttributes.config ) ) );
			
		}
		
	}
	
	private void function loadEvent( required Xml xml ){
		var events = xmlSearch( xml , "/modelglue/event-handlers/event-handler/" );
		var event = {};

        var aliasNext = "";
        var aliases = "";
        var alias = "";

		var triggerNext = "";
		var triggers = "";
		var trigger = "";
		
		var values = "";
		var value = [];
		
		var viewNext = "";
		var views = "";
		var view = "";
		
		var iterator = "";
		var next = "";

		var result = {};

		var evtObj = {};

		// set configs
		iterator = events.iterator();
		
		while( iterator.hasNext() ){

			next = iterator.next();

            param name="next.xmlAttributes.type" default="";

            evtObj = next.xmlAttributes;
            evtObj.put( 'interceptor', evtObj.get('type') );

			event = newEvent( argumentCollection=evtObj );

            aliases = xmlSearch( next, "aliases/alias/" ).iterator();

            while( aliases.hasNext() ){

                aliasNext = aliases.next();

                param name="aliasNext.xmlAttributes.language" default="#variables._configuration.get('defaultLanguage')#";

                alias = super.newAlias( aliasNext.xmlAttributes.name, evtObj.name, aliasNext.xmlAttributes.language );

                super.addAlias( alias );

            }

			triggers = xmlSearch( next, "broadcasts/message/" ).iterator();
			
			while( triggers.hasNext() ){
				
				triggerNext = triggers.next();
				
				trigger = super.trigger( triggerNext.xmlAttributes.name );
				
				values = triggerNext.xmlChildren.iterator();
				
				while( values.hasNext() ){
					
					trigger.values.add( super.addValue( argumentCollection=values.next().xmlAttributes ) );
					
				}
				
				event.triggers.add( trigger );
				
			}
			
			views = xmlSearch( next, "views/include/" ).iterator();
			
			value = [];
			
			while( views.hasNext() ){
				
				viewNext = views.next();
				
				view = super.view( argumentCollection=viewNext.xmlAttributes );
				
				values = viewNext.xmlChildren.iterator(); 
				
				while( values.hasNext() ){
					
					view.values.add( super.addValue( argumentCollection=values.next().xmlAttributes ) );
					
				}
				
				event.views.add( view );
				
			}
			
			results = xmlSearch( next, "results/result/" ).iterator();
			
			while( results.hasNext() ){

                result = results.next().xmlAttributes;
                result.put( 'to', result.do );
								
				event.results.add( super.result( argumentCollection=result ) );
				
			}
			
			addEvent( event );
			
		}
	}

	private void function loadInterceptor( required Xml xml ){
		var events = xmlSearch( xml , "/modelglue/event-types/event-type/" );
		var event = {};

        var positions = "";
        var position = "";

		var triggerNext = "";
		var triggers = "";
		var trigger = "";

		var values = "";
		var value = [];

		var viewNext = "";
		var views = "";
		var view = "";

		var iterator = "";
		var next = "";

        var result = {};

		// set configs
		iterator = events.iterator();

		while( iterator.hasNext() ){

			next = iterator.next();

            positions = next.xmlChildren.iterator();

            while( positions.hasNext() ){

                position = positions.next();

			    event = newInterceptor( name=next.xmlAttributes.name, position=lCase( position.xmlName ) );

                triggers = xmlSearch( position, "broadcasts/message/" ).iterator();

                while( triggers.hasNext() ){

                    triggerNext = triggers.next();

                    trigger = super.trigger( triggerNext.xmlAttributes.name );

                    values = triggerNext.xmlChildren.iterator();

                    while( values.hasNext() ){

                        trigger.values.add( super.addValue( argumentCollection=values.next().xmlAttributes ) );

                    }

                    event.triggers.add( trigger );

                }

                views = xmlSearch( position, "views/include/" ).iterator();

                value = [];

                while( views.hasNext() ){

                    viewNext = views.next();

                    view = super.view( argumentCollection=viewNext.xmlAttributes );

                    values = viewNext.xmlChildren.iterator();

                    while( values.hasNext() ){

                        view.values.add( super.addValue( argumentCollection=values.next().xmlAttributes ) );

                    }

                    event.views.add( view );

                }

                results = xmlSearch( position, "results/result/" ).iterator();

                while( results.hasNext() ){

                    result = results.next().xmlAttributes;
                    result.put( 'to', result.do );


                    event.results.add( super.result( argumentCollection=result ) );

                }

                addInterceptor( event );

            }

		}

	}

	private void function loadController( required Xml xml ){
		var controllers = xmlSearch( xml, "modelglue/controllers/controller/" );
		var controller = {};
		var iteratorCtrl = "";
		var nextCtrl = "";
		var iterator = "";
		var next = "";
		
		// set configs
		iteratorCtrl = controllers.iterator();
		
		while( iteratorCtrl.hasNext() ){
			
			nextCtrl = iteratorCtrl.next();

            param name="nextCtrl.xmlAttributes.class" default="#nextCtrl.xmlAttributes.type#";

			controller = newController( argumentCollection=nextCtrl.xmlAttributes );

			iterator = nextCtrl.xmlChildren.iterator();

			while( iterator.hasNext() ){

				next = iterator.next();

                param name="next.xmlAttributes.name" default="#next.xmlAttributes.message#";
                param name="next.xmlAttributes.handler" default="#next.xmlAttributes.function#";

				controller.bindings.add( bind( argumentCollection=next.xmlAttributes ) );
				
			}
			
			addController( controller );
			
		}
		
	}
	
	private void function loadConfig( required Xml xml ){
		var configs = xmlSearch( xml , "/modelglue/config/setting/" );
		var iterator = "";
		var next = "";
		
		// set configs
		iterator = configs.iterator();
		
		while( iterator.hasNext() ){

			next = iterator.next();

			setConfig( argumentCollection=next.xmlAttributes );

		}

	}
	
	private Xml function parseConfiguration( required String filePath ){
		
		var xml = "";
		
		lock name="#filePath#" timeout="50" type="exclusive" throwontimeout="true" {

			xml = fileRead( filePath, "utf-8" );
		}
		
		xml = xmlParse( xml );
		
		return xml;	
	}
	
}