stream output: 1,  			#ANIMATIONS FLIGHTGEAR
  stream name, "output_positions_1",
  create, yes,
  port, 8001,
  host, "127.0.0.1",				#pc-attila
  socket type, tcp,
  non blocking,
  #echo, "stream_generic_fg_out.log",
  values, 31,

drive, node, GND, structural, string, "X[1]",  direct,
drive, node, GND, structural, string, "X[2]",  direct,
drive, node, GND, structural, string, "X[3]",  direct,

drive, node, GND, structural, string, "E[1]",  direct,
drive, node, GND, structural, string, "E[2]",  direct,
drive, node, GND, structural, string, "E[3]",  direct,

drive, node, GND, structural, string, "XP[1]",  direct,
drive, node, GND, structural, string, "XP[2]",  direct,
drive, node, GND, structural, string, "XP[3]",  direct,

drive, node, GND, structural, string, "Omega[1]",  direct,
drive, node, GND, structural, string, "Omega[2]",  direct,
drive, node, GND, structural, string, "Omega[3]",  direct,

drive, node, BALL+1, structural, string, "X[1]",  direct,
drive, node, BALL+1, structural, string, "X[2]",  direct,
drive, node, BALL+1, structural, string, "X[3]",  direct,

drive, node, BALL+1, structural, string, "XP[1]",  direct,
drive, node, BALL+1, structural, string, "XP[2]",  direct,
drive, node, BALL+1, structural, string, "XP[3]",  direct,

drive, node, BALL+2, structural, string, "X[1]",  direct,
drive, node, BALL+2, structural, string, "X[2]",  direct,
drive, node, BALL+2, structural, string, "X[3]",  direct,

drive, node, BALL+2, structural, string, "XP[1]",  direct,
drive, node, BALL+2, structural, string, "XP[2]",  direct,
drive, node, BALL+2, structural, string, "XP[3]",  direct,

drive, node, BALL+3, structural, string, "X[1]",  direct,
drive, node, BALL+3, structural, string, "X[2]",  direct,
drive, node, BALL+3, structural, string, "X[3]",  direct,

drive, node, BALL+3, structural, string, "XP[1]",  direct,
drive, node, BALL+3, structural, string, "XP[2]",  direct,
drive, node, BALL+3, structural, string, "XP[3]",  direct,

drive,element,BALL,body,string,"m",direct;
