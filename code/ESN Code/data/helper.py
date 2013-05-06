input = open('MackeyGlass_t17_single_column', 'r');
output = open('MackeyGlass_t17_with_time', 'w');
counter = 0;

for line in input:
	output.write(str(counter) + "," + line);
	counter += 1

input.close();
output.close();