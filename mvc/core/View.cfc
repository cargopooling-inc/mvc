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
component output="false" accessors="true" {

	property Struct instance;

	variables.instance = {};
		
	public boolean function exists( required String name ){
		return variables.instance.containsKey( name );
	}
	
	public String function getValue( required String name ){
		if( !this.exists(name) ){
			return "";
		}
		return arrayToList( variables.instance.get( name ), ' ' );
	}
	
	public String function getAll(){
		var k = "";
		var result = "";
		
		for( key in variables.instance ){
			
			result = result & this.getValue( key );
			
		}
		
		return result;
	}
	
	public void function setValue( required String name, required String value, String conflict="overwrite" ){
		
		if( !this.exists( name ) ){
			variables.instance.put( name, createObject('java','java.util.ArrayList').init() );
		}
		
		switch( conflict ){
			
			case "append":{
				variables.instance.get( name ).add( value );
				break;
			}
			
			case "prepend":{
				arrayPrepend( variables.instance.get( name ), value );
				break;
			}
			
			default: {
				variables.instance.get( name ).add( value );
				break;
			}
			
		}
	
	}
	
}