#ifndef __SQOS_HPP
#define __SQOS_HPP

#define MAX_MAVLINK_LEN 256

typedef unsigned char uint8_t;

// Utility functions
SQInteger register_global_func(HSQUIRRELVM v,SQFUNCTION f,const char *fname);
void print_args(HSQUIRRELVM v);

class SQOS {
	// FIXME - perhaps we could find this through a squirrel userptr instead?
	static SQOS *instance;

public:
	SQOS();

        void init(HSQUIRRELVM v, const char *platformName);

protected:

	//
	// Provide by platform implementers
	//

	// Send a message
    virtual void sendMavlink(const uint8_t *payload, unsigned payloadLen) = 0;

	// Implementer should return any received messages by writing to
	// destBuf.  On entry *destBufLen contains the max # of bytes which
	// can be accepted.  On exit *destBufLen should contain the number of
	// bytes which were written
	// @return true if a message as received, or false for timeout
	virtual bool waitMessage(int waitMsecs, uint8_t *destBuf, int *destBufLen) = 0;

private:
	// Glue

	static SQInteger osSendMavlink(HSQUIRRELVM v);
	static SQInteger osWaitMessage(HSQUIRRELVM v);
};

#endif
