import math

DEPTH = 256 # Sample count
BIT_WIDTH = 16 

MAX_AMPLITUDE = 32767 # Max value of 16 bits signed vector. 2^15 - 1 = 32767 

for i in range(DEPTH):

    angle = (2.0 * math.pi * i) / DEPTH
    
    val = int(round(MAX_AMPLITUDE * math.sin(angle)))
    

    hex_val = val & 0xFFFF 
    

    print(f"    sine_rom[{i}] = 16'h{hex_val:04X}; // Dec: {val}")
