with Ada.Text_IO; use Ada.Text_IO;
with World_Pkg;

package body Game_Socket_Pkg is

   function Create
     (Socket : AWS.Net.Socket_Access; Request : AWS.Status.Data)
      return AWS.Net.WebSocket.Object'Class is
   begin
      Put_Line ("Creating WebSocket for " & AWS.Status.URI (Request));

      return
        Game_Socket_Instance'
          (AWS.Net.WebSocket.Object
             (AWS.Net.WebSocket.Create (Socket, Request))
           with null record);
   end Create;

   overriding
   procedure On_Open (Socket : in out Game_Socket_Instance; Message : String)
   is
   begin
      Put_Line ("WebSocket opened - " & Message);
      Socket.Send ("{""type"":""hello"",""message"":""Welcome!""}");
      --  Request test chunk
      Socket.Send (World_Pkg.Get_Test_Chunk_JSON);
   end On_Open;

   overriding
   procedure On_Message
     (Socket : in out Game_Socket_Instance; Message : String) is
   begin
      Put_Line ("Received: " & Message);

      --  Echo back data for now
      Socket.Send (Message);
   end On_Message;

   overriding
   procedure On_Close (Socket : in out Game_Socket_Instance; Message : String)
   is
      pragma Unreferenced (Socket);
   begin
      Put_Line ("WebSocket closed: " & Message);
   end On_Close;

end Game_Socket_Pkg;
