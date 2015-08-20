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
component implements="IBeanFactoryAdapter"{

    public BeanFactoryAdapter function init( String scope="request", String beanFactoryVar="mvc_beanFactory" ){

        variables.scope = arguments.scope;
        variables.beanFactoryVar = arguments.beanFactoryVar;

        return this;

    }

    public Any function getBean( required String name ){

        return proxy().getBean( arguments.name );

    }

    public boolean function exists(){

        return structKeyExists( evaluate( variables.scope ), variables.beanFactoryVar );

    }

    private any function proxy(){

        return evaluate( variables.scope & "." & variables.beanFactoryVar );

    }

}
