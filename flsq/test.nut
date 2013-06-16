
dofile("lib/log.nut", true)
dofile("lib/collection.nut", true)
dofile("lib/osagent.nut", true)
dofile("lib/actor.nut", true)

dofile("mavbase.nut", true)
// dofile("mavgened.nut", true)
dofile("gen/generated.nut", true)

// writeclosuretofile("asbytes",loadfile("nout.nut", true))

class MavlinkReceiver extends Actor {
    function receive(msg) {
	debug("RA received: " + msg)

	local b = msg.toBlob()
	print("packed: " + mkString(b, ",") + "\n")
	b.seek(0)
	local obj2 = MAV.Message.fromBlob(b)
	print("unpacked: " + obj2 + "\n")
    }
}

local mr = MavlinkReceiver()

print("pretending to receive a message - FIXME add publishing foo\n")
local testobj = MAV.Message.create(MAV.MSG_HWSTATUS)
testobj.sysId = 5
testobj.Vcc = 124.5
mr.sendTo(testobj)
// print(testobj + "\n")

Scheduler.run()

