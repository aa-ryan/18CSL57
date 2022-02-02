set ns [ new Simulator ]	 #* Letter S is capital *# 
set nf [open lab1.nam w] 	#* open a nam trace file in write mode *# 
$ns namtrace-all $nf 		#* nf – nam file *# 
set tf [open lab1.tr w]		 #* tf- trace file *# 
$ns trace-all $tf 
proc finish { } {		#* provide space b#w proc and finish and all are in small case *# 
	global ns nf tf 
	$ns flush-trace 		#* clears trace file contents *# close $nf 
	close $tf 
	exec nam lab1.nam & 
	exit 0 
} 
set n0 [$ns node]		 #* creates 4 nodes *# 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node] 
$ns duplex-link $n0 $n2 200Mb 10ms DropTail 	#*Letter M is capital Mb*# 
$ns duplex-link $n1 $n2 100Mb 5ms DropTail 	#*D and T are capital*# 
$ns duplex-link $n2 $n3 1Mb 1000ms DropTail 
$ns queue-limit $n0 $n2 10 
$ns queue-limit $n1 $n2 10 
set udp0 [new Agent#UDP] 	#* Letters A,U,D and P are capital *# 
$ns attach-agent $n0 $udp0 
set cbr0 [new Application#Traffic#CBR] 	#* A,T,C,B and R are capital*# 
$cbr0 set packetSize_ 500	 #*S is capital, space after underscore*# 
$cbr0 set interval_ 0.005 
$cbr0 attach-agent $udp0 
set udp1 [new Agent#UDP] 
$ns attach-agent $n1 $udp1 
set cbr1 [new Application#Traffic#CBR] 
$cbr1 attach-agent $udp1
set udp2 [new Agent#UDP] 
$ns attach-agent $n2 $udp2 
set cbr2 [new Application#Traffic#CBR] 
$cbr2 attach-agent $udp2 
set null0 [new Agent#Null] 	#* A and N are capital *# 
$ns attach-agent $n3 $null0 
$ns connect $udp0 $null0 
$ns connect $udp1 $null0 
$ns at 0.1 "$cbr0 start" 
$ns at 0.2 "$cbr1 start" 
$ns at 1.0 "finish" 
$ns run

