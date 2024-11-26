create table furacao.vertices as (
 with
	table1 as (
	select data::timestamp, geom from furacao.furacaosimplificado),
	dumping as (
	select data, (st_dumppoints(geom)).geom
	from table1)--,
 --west as (
--	select distinct d.data, first_value(d.geom) over (partition by d.data order by st_x(d.geom)) as vertex_w
--	from dumping d, table1 t
--	where st_within(d.geom, st_boundary(st_envelope(t.geom)))), 
 --south as  (
--	select distinct d.data, first_value(d.geom) over (partition by d.data order by st_y(d.geom)) as vertex_s
--	from dumping d, table1 t
--	where st_within(d.geom, st_boundary(st_envelope(t.geom)))),
 --east as (
--	select distinct d.data, first_value(d.geom) over (partition by d.data order by st_x(d.geom) desc) as vertex_e-
--	from dumping d, table1 t
--	where st_within(d.geom, st_boundary(st_envelope(t.geom)))),
-- north as  (
	select distinct d.data, first_value(d.geom) over (partition by d.data order by st_y(d.geom) desc) as vertex_n, 
							first_value(d.geom) over (partition by d.data order by st_y(d.geom) ) as vertex_s, 
							first_value(d.geom) over (partition by d.data order by st_x(d.geom) desc) as vertex_e, 
							first_value(d.geom) over (partition by d.data order by st_x(d.geom) ) as vertex_w, 
							st_centroid(t.geom) as centroid
	from dumping d, table1 t
	where st_within(d.geom, st_boundary(st_envelope(t.geom)))
)