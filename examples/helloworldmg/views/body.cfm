<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>
<!DOCTYPE html>
<html>

    <head>

    </head>

    <body>

        <cfif event.exists('hello.message')>

        <h1>Hello #event.getValue('hello.message').getName()# !</h1>

        <h2>#helper('math').sum( 1, 3 )#</h2>

        </cfif>

        <form action="#event.linkTo('say.hello','language')#" method="post">

            <input type="text" name="name" value="" />

            <input type="submit" value="Say Hello">

        </form>

    </body>
</html>
</cfoutput>