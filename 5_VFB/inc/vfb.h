#ifndef VFB_H_
#define VFB_H_

/* Non-queued communication
 * Vfb_Read: Performs an "explicit" read on a sender-receiver communication data
 * Vfb_Write: Initiates transmission of data of a send port.
 *
 * Queued communication
 * Vfb_Receive: Performs an "explicit" read on a sender-receiver communication data
 * Vfb_Send: It is similar to Vfb_Write, the difference is that this API is used to transmit data to a queue type data
 *
 * Vfb_Call: Initiate a client-server communication.
 *
 * */

// Errors
#define VFB_E_OK				((Std_ReturnType) 0)
#define VFB_E_INVALID			((Std_ReturnType) 1)
#define VFB_E_TIMEOUT			((Std_ReturnType) 129)
#define VFB_E_LIMIT				((Std_ReturnType) 130)
#define VFB_E_NO_DATA			((Std_ReturnType) 131)
#define VFB_E_TRANSMIT_ACK		((Std_ReturnType) 132)

#endif /* VFB_H_ */
