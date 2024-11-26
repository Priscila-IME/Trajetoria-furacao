--select * from furacao.vertices
-- limit 10
create table furacao.metricas as (
	select data, 
	--estatísticas centroide
		st_distance(centroid::geography, lead(centroid::geography) over (order by data)) as dist_cent, 
		 case 
			 when degrees(st_azimuth(centroid, lead(centroid) over (order by data))) >= 0 
			 then degrees(st_azimuth(centroid, lead(centroid) over (order by data))) 
			 when degrees(st_azimuth(centroid, lead(centroid) over (order by data))) < 0 
			 then 360+degrees(st_azimuth(centroid, lead(centroid) over (order by data))) 
		 end as az_centr,
	--estatísticas N
		st_distance(vertex_n::geography, lead(vertex_n::geography) over (order by data)) as dist_n, 
		 case 
			 when degrees(st_azimuth(vertex_n, lead(vertex_n) over (order by data))) >= 0 
			 then degrees(st_azimuth(vertex_n, lead(vertex_n) over (order by data))) 
			 when degrees(st_azimuth(vertex_n, lead(vertex_n) over (order by data))) < 0 
			 then 360+degrees(st_azimuth(vertex_n, lead(vertex_n) over (order by data))) 
		 end as az_n,
		 st_y(st_transform(lead(vertex_n) over (order by data),3857)) - st_y(st_transform(vertex_n, 3857)) as diff_n,
	--estatísticas S
		 st_distance(vertex_s::geography, lead(vertex_s::geography) over (order by data)) as dist_s, 
		 case 
			 when degrees(st_azimuth(vertex_s, lead(vertex_s) over (order by data))) >= 0 
			 then degrees(st_azimuth(vertex_s, lead(vertex_s) over (order by data))) 
			 when degrees(st_azimuth(vertex_s, lead(vertex_s) over (order by data))) < 0 
			 then 360+degrees(st_azimuth(vertex_s, lead(vertex_s) over (order by data))) 
		 end as az_s,
		 st_y(st_transform(vertex_s, 3857)) - st_y(st_transform(lead(vertex_s) over (order by data),3857)) as diff_s,
	--estatísticas E
		 st_distance(vertex_e::geography, lead(vertex_e::geography) over (order by data)) as dist_e, 
		 case 
			 when degrees(st_azimuth(vertex_e, lead(vertex_e) over (order by data))) >= 0 
			 then degrees(st_azimuth(vertex_e, lead(vertex_e) over (order by data))) 
			 when degrees(st_azimuth(vertex_e, lead(vertex_e) over (order by data))) < 0 
			 then 360+degrees(st_azimuth(vertex_e, lead(vertex_e) over (order by data))) 
		 end as az_e,
		 - st_x(st_transform(vertex_e, 3857)) + st_x(st_transform(lead(vertex_e) over (order by data),3857)) as diff_e,
	--estatísticas W
		 st_distance(vertex_w::geography, lead(vertex_w::geography) over (order by data)) as dist_w, 
		 case 
			 when degrees(st_azimuth(vertex_w, lead(vertex_w) over (order by data))) >= 0 
			 then degrees(st_azimuth(vertex_w, lead(vertex_w) over (order by data))) 
			 when degrees(st_azimuth(vertex_w, lead(vertex_w) over (order by data))) < 0 
			 then 360+degrees(st_azimuth(vertex_w, lead(vertex_w) over (order by data))) 
		 end as az_w,
		 st_x(st_transform(vertex_w, 3857)) - st_x(st_transform(lead(vertex_w) over (order by data),3857)) as diff_w
from furacao.vertices)
--limit 200

select data, diff_n, diff_s,
-- deslocamento booleano

		case
			when diff_n > 1 and diff_s < -1 then 'Verdadeiro'
			else 'Falso'
		end as desloca_norte,
		case
			when diff_s > 1 and diff_n < -1 then 'Verdadeiro'
			else 'Falso'
		end as desloca_sul,

-- deslocamento absoluto

		case

			when diff_n > 1 then diff_n else--greatest(diff_n,diff_s)

			when diff_n < -1 and diff_s < -1 and greatest(absolute(diff_n),absolute(diff_s)) = diff_s then -(diff_s - diff_n) else

			else 'Falso'

		end as desloca_norte_abs

from furacao.metricas
where data in (select data from furacao.metricas

			   order by random()

			limit 50)