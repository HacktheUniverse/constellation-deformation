import json
with open('stars.text','r') as f:
	with open('stars.json', 'w') as out:
		#orion_stars = [27989, 26207, 25336, 25930, 25281, 24436, 27366, 26727, 28614, 29426, 28691, 27913, 29038, 26311, 22449, 22845, 22509, 22549, 22797, 23123]
		for line in f:
			parts = line.split()
			if len(parts) >1:
				out.write('{"pos":[%s , %s, %s], "color": %s, "lum":%s, "speed":[%s,%s,%s], "hip":%s },' %(
					parts[0],parts[1],parts[2],parts[3],parts[4], parts[12], parts[13], parts[14], parts[18].strip('HIP')
					))

	
		


# datavar 0 colorb_v + 3
# datavar 1 lum
# datavar 2 absmag
# datavar 3 appmag
# datavar 4 texnum
# datavar 5 distly
# datavar 6 dcalc
# datavar 7 plx
# datavar 8 plxerr
# datavar 9 vx 
# datavar 10 vy
# datavar 11 vz
# datavar 12 speed
# datavar 13 hipnum				
# 				