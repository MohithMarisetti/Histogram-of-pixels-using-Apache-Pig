pixels = load '$P' using PigStorage(',') AS (red:int,green:int,blue:int); 

red_pixels = GROUP pixels BY red;   
green_pixels = GROUP pixels BY green;   
blue_pixels = GROUP pixels BY blue;   


red_pixels_count = FOREACH red_pixels GENERATE group, COUNT(pixels);
green_pixels_count = FOREACH green_pixels GENERATE group, COUNT(pixels);
blue_pixels_count = FOREACH blue_pixels GENERATE group, COUNT(pixels);

R = FOREACH red_pixels_count GENERATE 1,$0,$1;
G = FOREACH green_pixels_count GENERATE 2,$0,$1;
B = FOREACH blue_pixels_count GENERATE 3,$0,$1; 

RGB = UNION R, G, B;

result = ORDER RGB BY $0,$1;

STORE result INTO '$O' USING PigStorage (',');

