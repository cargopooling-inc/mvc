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
component  output="false" accessors="true" implements="IURLManager"{
			
	public IURLManager function init( required mvc.Framework framework ){
		variables._framework = framework;
		
		return this;
	}
	
	// create link
	public String function linkTo( required String event, required mvc.core.Event context, String append="", String anchor="", Struct params={}, String host="", String paramsPattern="", String language="" ){
		
		var link = "";
		var name = "";
		var i = "";
		
		link = host & cgi.SCRIPT_NAME & "?" & variables._framework.getConfig('eventName') & "=";

		link = link & variables._framework.getAlias( event, language );
		
		// append values
		for( i=1; i<=listLen( append ); i++ ){
			
			name = listGetAt( append, i );
			
			link = link & "&#name#=#urlEncodedFormat( context.getValue( name ) )#";
		}

		// append params
		for( i in params ){

			link = link & "&#i#=#urlEncodedFormat( params[ i ] )#";
		}
		
		// add anchor
		if( len( anchor ) ){

			link = link & "##" & anchor;
		}
		
		return link;
	}
	
}