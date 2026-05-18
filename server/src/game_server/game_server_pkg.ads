with AWS.Response;
with AWS.Status;

package Game_Server_Pkg is

   --  Starts web server & keeps running until Q is pressed.
   procedure Start_Server;

private

   --  Handler for client requests
   function Handler (Request : AWS.Status.Data) return AWS.Response.Data;

end Game_Server_Pkg;
