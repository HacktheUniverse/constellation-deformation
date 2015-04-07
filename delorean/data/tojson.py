import json
import sys

try:
	file_name = sys.argv[1]
except:
	file_name = "starData"

out_file = "data/%s.json" % file_name

with open('data/stars.text','r') as f:
	with open(out_file, 'w') as out:
		i = 0
		out.write('[')
		for line in f:			
			parts = line.split()	
			if len(parts) > 1:
				# The following conditional limits to luminiousity <= 5.5
				#if float(parts[6]) <= 5.5:
				i += 1
				print parts[6]
				out.write('{"pos":[%s , %s, %s], "color": %s, "lum":%s, "speed":[%s,%s,%s], "hip":%s },\n' %(
					parts[0],parts[1],parts[2],parts[3],parts[4], parts[12], parts[13], parts[14], parts[18].strip('HIP')
				))
		# print "filtered down to %s stars" % i
		out.write(']')
	
		


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