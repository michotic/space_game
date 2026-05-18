with Ada.Strings.Unbounded;
with Ada.Text_IO;

with AWS.Messages;
with AWS.MIME;
with AWS.Net.WebSocket.Registry.Control;
with AWS.Server;

with Game_Socket_Pkg;

package body Game_Server_Pkg is

   procedure Start_Server is
      Server : AWS.Server.HTTP;
   begin

      Ada.Text_IO.Put_Line ("Server starting...");

      --  Set up websocket to handle client inputs
      AWS.Net.WebSocket.Registry.Control.Start;
      AWS.Net.WebSocket.Registry.Register
        ("/game", Game_Socket_Pkg.Create'Access);

      --  Start web server
      AWS.Server.Start
        (Server,
         "Ada Web Server",
         Max_Connection => 10,
         Callback       => Handler'Access);

      --  Await input before stopping server
      Ada.Text_IO.Put_Line ("Press 'q' to stop the server.");
      AWS.Server.Wait (AWS.Server.Q_Key_Pressed);

      --  Shut down the server
      Ada.Text_IO.Put_Line ("Server stopping...");
      AWS.Server.Shutdown (Server);
      Ada.Text_IO.Put_Line ("Server stopped.");

   end Start_Server;

   function Handler (Request : AWS.Status.Data) return AWS.Response.Data is
      use Ada.Strings.Unbounded;

      URI  : constant String := AWS.Status.URI (Request);
      Root : constant String := "public";
      Path : Unbounded_String;

   begin
      Ada.Text_IO.Put_Line (">>> Client Request");

      --  Static file handler; Gets path of file we'll respond with
      if URI = "/" then
         Path := To_Unbounded_String (Root & "/index.html");
      else
         Path := To_Unbounded_String (Root & URI);
      end if;

      Ada.Text_IO.Put_Line ("Path = " & To_String (Path));
      Ada.Text_IO.Put_Line
        ("Content Type = " & AWS.MIME.Content_Type (To_String (Path)));

      --  Serve requested file
      return
        AWS.Response.File
          (Content_Type => AWS.MIME.Content_Type (To_String (Path)),
           Filename     => To_String (Path));

   exception
      when others =>
         return
           AWS.Response.Acknowledge
             (AWS.Messages.S404, "Something went wrong!");
   end Handler;

end Game_Server_Pkg;
