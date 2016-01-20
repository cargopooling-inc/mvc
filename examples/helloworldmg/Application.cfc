component extends="mvc.DJango"{

    this.name = "helloworldmg";
    this.sessionmanagement = "true";

    this.mvc_configurations.viewLocation = "/examples/helloworldmg/views/";
    this.mvc_configurations.configurationClass="mvc.util.configuration.ModelGlueXmlConfiguration";
    this.mvc_configurations.configurationXml="config/ModelGlue.xml";
    this.mvc_configurations.developmentMode=true;
    this.mvc_configurations.cacheAdapter="mvc.util.adapters.DefaultCacheAdapter";
    this.mvc_configurations.helpersClasses=[
        "examples.helloworldmg.helpers.MathHelper"
    ];

    function onRequestStart(){
        super.onRequestStart();
    }

    function onSessionStart(){
        super.onSessionstart();
    }

    function onSessionEnd(){
        super.onSessionEnd();
    }

    function onApplicationStart(){
        super.onApplicationStart();
    }

}
