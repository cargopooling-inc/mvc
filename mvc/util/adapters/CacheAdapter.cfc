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
component output="false" accessors="true" implements="ICacheAdapter" {

	property cacheManagement.CacheManager cacheManager;
	
	variables.STATIC = {};
	variables.STATIC.DEFAULTCLASS = "mvc.core.View";

	public ICacheAdapter function init( required mvc.Framework framework ){
		
		var config = framework.getConfigurations();
		
		variables.cacheManager = new cacheManagement.CacheManager( config.cacheConfigurationFile );
		variables.defaultTimeOut = config.cacheDefaultTimeout;

		framework.setCacheAdapter( this );
		
		return this;
	}
	
	public void function put( required String key, required String content, Numeric timeout=variables.defaultTimeOut, String class=variables.STATIC.DEFAULTCLASS ){
		var element = getCacheManager().getCacheFactory().createElement().init( key, content, false, 0, timeout );
		var cache = "";
        
        if( !getCacheManager().cacheExists( class ) ){
        	getCacheManager().addCache( class );
        }
        
        cache = getCacheManager().getCache( class );
        
		cache.put( element );
	}
	
	public String function get( required String key, String class=variables.STATIC.DEFAULTCLASS ){
		return getCacheManager().get( class, key );
	}
	
	public boolean function exists( required String key, String class=variables.STATIC.DEFAULTCLASS ){
		return getCacheManager().exists( class, key );
	}

	public void function flush( String class=variables.STATIC.DEFAULTCLASS ){

        if( getCacheManager().cacheExists( class ) ){
            getCacheManager().flush( class );
        }

	}

}