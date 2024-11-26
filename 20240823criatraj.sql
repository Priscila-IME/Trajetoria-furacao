
create table furacao.linhas as (

with

 traj_n as (select  st_makeline(vertex_n order by data) as traj  from  furacao.vertices),

 traj_s as (select st_makeline(vertex_s order by data) as traj  from furacao.vertices),

 traj_e as (select st_makeline(vertex_e order by data) as traj  from furacao.vertices),

 traj_w as (select st_makeline(vertex_w order by data) as traj  from furacao.vertices), 

 traj_c as (select st_makeline(centroid order by data) as traj  from furacao.vertices)



 select traj as geom, 'norte' as vertices from traj_n union

 select traj as geom, 'sul' as vertices from traj_s union

 select traj as geom, 'leste' as vertices from traj_e union

 select traj as geom, 'oeste' as vertices from traj_w union

 select traj as geom, 'centroide' as vertices from traj_c
 )