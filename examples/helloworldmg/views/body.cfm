<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>
<!DOCTYPE html>
<html>

    <head>

    </head>

    <body>

        <cfif event.exists('hello.message')>

        <h1>Hello #event.getValue('hello.message').getName()# !</h1>

        </cfif>

        <form action="index.cfm?event=say.hello" method="post">

            <input type="text" name="name" value="" />

            <input type="submit" value="Say Hello">

        </form>

    </body>
</html>
</cfoutput>