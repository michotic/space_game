with AWS.Net.WebSocket;
with AWS.Status;

package Game_Socket_Pkg is

   type Game_Socket_Instance is new AWS.Net.WebSocket.Object with null record;

   function Create
     (Socket : AWS.Net.Socket_Access; Request : AWS.Status.Data)
      return AWS.Net.WebSocket.Object'Class;

   overriding
   procedure On_Open (Socket : in out Game_Socket_Instance; Message : String);

   overriding
   procedure On_Message
     (Socket : in out Game_Socket_Instance; Message : String);

   overriding
   procedure On_Close (Socket : in out Game_Socket_Instance; Message : String);

end Game_Socket_Pkg;
