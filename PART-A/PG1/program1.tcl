set ns [new Simulator] 				# simulator object with name "ns"
set nf [open program1.nam w]		#  open/create program1.nam and assign pointer "nf"
$ns namtrace-all $nf				# Record all simulation traces in NAM input format
set tf [open program1.tr w]			# Create trace file program1.tr and assign pointer "tf"
$ns trace-all $tf					# Trace will go to the program1.tr by "tf"
proc finish {} {					# proc decaler procedure
	global ns nf tf					# global tells we're using variables decalred outside the procedure
	$ns flush-trace					# flush-trace = simulator method to dump the traces on the respective file
	close $tf						# close trace file
	exec nam program1.nam &			# execute nam for visulation
	exit 0							# ends the applications 
}

set n0 [$ns node]					# Create a node pointed by n0. To refer use $n0
set n1 [$ns node]					
set n2 [$ns node]
set n3 [$ns node]

# $n0 and $n2 are connected using bi-directional link with
# bandwidth = 200Mb, Propagation delay = 10ms 
# and DropTail (the way to handle buffer overflow, last packet arrived is dropped)
$ns duplex-link $n0 $n2 200Mb 10ms DropTail
$ns duplex-link $n2 $n3 100Mb 5ms DropTail
$ns duplex-link $n2 $n3 1Mb 1000ms DropTail

$ns queue-limit $n0 $n2 10			# buffer capacity from node 0 to node 2 = 10 packets
$ns queue-limit $n1 $n2 10

set udp0 [new Agent/UDP]			# Create UDP agent with name udp0
$ns attach-agent $n0 $udp0			# Attach $udp0 to node 0 ($n0)

# For actual data to flow, we need traffic generators,
# The simulate some application traffic. Ex: CBR
# Creating CBR (constant bit rate) agent cbr0, set the packet size, packet interval
set cbr0 [new Application/Traffic/CBR] 
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0			# Attack CBR agent $cbr0 to UDP agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

set null0 [new Agent/Null]			# Create a null agent which acts as traffic sink / receiver
$ns attach-agent $n3 $null0

# in UDP communication data flows from UDP agent to NULL agent.
# so connect udp agent to null agent
$ns connect $udp0 $null0
$ns connect $udp1 $null0

$ns at 0.1 "$cbr0 start"			# Start event scheduler
$ns at 0.2 "$cbr1 start"			# Call the finish procedure defined
$ns at 1.0 "finish"
$ns run
