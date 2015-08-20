<!---
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
--->
<cfif thistag.executionmode eq "start"><cfsilent>
<cfscript>
catchValues = attributes.catchValues;

</cfscript>

</cfsilent>
<cfheader statuscode="500" />
<cfoutput>
    <h1>MVC error</h1>
    <h2>&copy; Cargopooling, Inc.</h2>

    <cfloop collection="#catchValues#" item="value">

        <cfif trim( value ) eq 'TagContext' >

            <p>
                <strong>#value#</strong>
            </p>

            <cfloop array="#catchValues[value]#" index="TagContext">

                <cfif structKeyExists( tagcontext, 'Raw_Trace' )>

                    <p>
                        <strong>#TagContext.Raw_Trace#</strong>
                    </p>

                </cfif>

                <cfif structKeyExists( tagcontext, 'codePrintHTML' )>

                    <p>
                        #TagContext.codePrintHTML#
                    </p>

                </cfif>

            </cfloop>

            <hr>

        <cfelseif isSimpleValue( catchValues[value] ) >


            <cfif len( catchValues[value] )>

                <p>
                    <strong>#value#</strong>
                </p>

                <p>
                    #catchValues[value]#
                </p>

                <hr>
            </cfif>

        </cfif>

    </cfloop>


</cfoutput>

</cfif>