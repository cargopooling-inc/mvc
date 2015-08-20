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
component output="false" accessors="true" implements="mvc.util.adapters.ICacheAdapter" {

	variables.STATIC = {};
	variables.STATIC.DEFAULTCLASS = "mvc.core.View";

    variables._state = {};
    variables._lastSweep = now();
    variables._lockName = createUUID();

	public ICacheAdapter function init( required mvc.Framework framework ){
		
		var config = framework.getConfigurations();

		variables.defaultTimeOut = config.cacheDefaultTimeout;
		variables._sweepInterval = config.cacheDefaultSweep;

        variables._state[ hash( variables.STATIC.DEFAULTCLASS ) ] = {};
		
		framework.setCacheAdapter( this );
		
		return this;

	}
	
	public void function put( required String key, required String content, Numeric timeout=variables.defaultTimeOut, String class=variables.STATIC.DEFAULTCLASS ){

        var element = {key=key,content=content,timeout=timeout,created=now()};
		var cache = "";
        
        if( !structKeyExists( variables._state, hash( class ) ) ){
            variables._state[ hash( class ) ] = {};
        }

        variables._state[ hash( class ) ][ hash( key ) ] = element;

	}
	
	public String function get( required String key, String class=variables.STATIC.DEFAULTCLASS ){

        sweep();

        return variables._state[ hash( class ) ][ hash( key ) ]['content'];

	}
	
	public boolean function exists( required String key, String class=variables.STATIC.DEFAULTCLASS ){

        sweep();

        if( !structKeyExists( variables._state, hash( class ) ) ){

            return false;

        }else if( !structKeyExists( variables._state[ hash( class ) ], hash( key ) ) ){

            return false;

        }

		return true;

	}

    public void function flush( String class=variables.STATIC.DEFAULTCLASS ){
        variables._state[ hash( class ) ] = {};
    }

    private void function sweep(){

        var sinceLastSweep = dateDiff("s", variables._lastSweep, now());
        var element = "";
        var class  = "";
        var key = "";

        if( dateDiff("s", variables._lastSweep, now()) gt variables._sweepInterval ){

            lock name="#variables._lockName#" timeout="10" type="exclusive"{

                if( dateDiff("s", variables._lastSweep, now()) gt variables._sweepInterval ){

                    for( class in variables._state ){

                        for( key in variables._state[ class ] ){

                            element =  variables._state[ class ][ key ];

                            if( sinceLastSweep gt element.timeout ){

                                purge( key , key );

                            }

                        }

                    }

                    variables._lastSweep = now();

                }

            }

        }

    }

    private void function purge( required String key, String class=variables.STATIC.DEFAULTCLASS ){

        structDelete( variables._state[ hash( class ) ], hash( key ) );

    }



}