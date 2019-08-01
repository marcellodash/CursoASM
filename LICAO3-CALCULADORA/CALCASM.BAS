10 cls
20 input "val 1=>";A
30 input "val 2=>";B
40 input "0) Add;1) sub;2)mult;3)div";C
50 poke (&9000), C
60 poke (&9001), A
70 poke (&9002), B
80 call &8000
90 ? peek(&9003)