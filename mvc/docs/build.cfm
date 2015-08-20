<!---
Let's generate our default HTML documentation on myself: 
 --->
<cfscript>
	colddoc = createObject("component", "colddoc.ColdDoc").init();

	strategy = createObject("component", "colddoc.strategy.api.HTMLAPIStrategy").init( expandPath("api"), "ColdDoc 1.0");
	colddoc.setStrategy(strategy);

	colddoc.generate( expandPath( '/mvc' ), "mvc" );
</cfscript>

<h1>Done!</h1>

<a href="api/index.html">Documentation</a>
