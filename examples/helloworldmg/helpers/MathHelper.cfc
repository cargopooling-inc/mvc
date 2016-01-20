/**
 * Created by Cristian Costantini on 20/01/16.
 */
component extends="mvc.util.helper.AbsHelper"{

    public function init(){

        variables.name = "math";

        return this;
    }

    public Numeric function sum( required Numeric a, required Numeric b ){

        return a + b;
    }

}
