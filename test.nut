


dofile("mavbase.nut", true)
dofile("mavgened.nut", true)
dofile("../mavlink/nout.nut", true)

print("loaded\n")
local testobj = MAV.GPSPositionMessage()
testobj.sysId = 5
testobj.lat = 124.5
print(testobj + "\n")
local b = testobj.toBlob()
print("packed: " + mkString(b, ",") + "\n")
b.seek(0)
local obj2 = MAV.Message.fromBlob(b)
print("unpacked: " + obj2 + "\n")

