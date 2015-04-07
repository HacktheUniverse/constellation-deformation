import json
with open('data/stars.text','r') as f:
	with open('data/orion_stars.json', 'w') as out:
		orion_stars = [27989, 26207, 25336, 25930, 25281, 24436, 27366, 26727, 28614, 29426, 28691, 27913, 29038, 26311, 22449, 22845, 22509, 22549, 22797, 23123]
		for line in f:
			i = 0
			parts = line.split()
			if len(parts) >1:
				if len(parts[18].strip('HIP').strip('#')) > 0:
					for o in orion_stars:
						if int(o) == int(parts[18].strip('HIP').strip('#')):
							out.write('{"pos":[%s , %s, %s], "color": %s, "lum":%s, "speed":[%s,%s,%s], "hip":%s },' %(
								parts[0],parts[1],parts[2],parts[3],parts[4], parts[12], parts[13], parts[14], parts[18].strip('HIP')
							))
				
