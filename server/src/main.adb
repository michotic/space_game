with Game_Server_Pkg;
with World_Pkg;

procedure Main is
begin
   World_Pkg.Create_World;
   Game_Server_Pkg.Start_Server;
end Main;
