/**
 * @file register_handling.h
 * @author George
 * @date 22/10/2022
 * @brief Preprocessor macros to handle register set, clear, read, write etc.
 * @copyright 2022 Learn Embedded Systems With George
 */

#ifndef REGISTER_HANDLING_H_
#define REGISTER_HANDLING_H_


/**
 * @def _BV
 * @brief Bit value, set a bit and get it's byte value.
 */
#define _BV(bit)						(1 << (bit))

/**
 * @def REGISTER_SET_BIT
 * @brief Set a given bit inside a register.
 */
#define REGISTER_SET_BIT(reg, bit)		((reg) |= _BV(bit))

/**
 * @def REGISTER_CLEAR_BIT
 * @brief Clear a given bit inside a register.
 */
#define REGISTER_CLEAR_BIT(reg, bit)    ((reg) &= ~(_BV(bit))

/**
 * @def REGISTER_WRITE
 * @brief Write a value inside a register.
 */
#define REGISTER_WRITE(reg, value)   	((reg) = (value))

/**
 * @def REGISTER_READ
 * @brief Read the value present inside a register.
 */
#define REGISTER_READ(reg)         		(reg)

/**
 * @def REGISTER_READ_BIT
 * @brief Read the bit value present inside a register.
 */
#define REGISTER_READ_BIT(reg, bit)    	((reg) & _BV(bit))

/**
 * @def CHK_BIT_IS_SET
 * @brief Check if a given bit is set inside the register.
 */
#define CHK_BIT_IS_SET(reg, bit)		(REGISTER_READ_BIT(reg, bit))

/**
 * @def CHK_BIT_IS_CLEAR
 * @brief Check if a given bit is cleared inside the register.
 */
#define CHK_BIT_IS_CLEAR(reg, bit)		(!(REGISTER_READ_BIT(reg, bit)))

/**
 * @def LOOP_UNTIL_BIT_IS_SET
 * @brief Loop until the bit is set inside a register.
 */
#define LOOP_UNTIL_BIT_IS_SET(reg, bit) do { } while (CHK_BIT_IS_CLEAR(reg, bit))

/**
 * @def LOOP_UNTIL_BIT_IS_CLEAR
 * @brief Loop until the bit is cleared inside a register.
 */
#define LOOP_UNTIL_BIT_IS_CLEAR(reg, bit) do { } while (CHK_BIT_IS_SET(reg, bit))

/**
 * @def REGISTER_CLEAR_BITS
 * @brief Clear a number of bits inside a register based on a mask (clrmask)
 * and from a given position (pos).
 */
#define REGISTER_CLEAR_BITS(reg, clrmask, pos)	((reg) &= ~((clrmask) << (pos)))

/**
 * @def REGISTER_SET_BITS
 * @brief Set a number of bits inside a register based on a mask (setmask)
 * and on their value (val), from a given position (pos). \n
 * Note: We will perform a clear based on the mask before writing the value.
 */
#define REGISTER_SET_BITS(reg, val, setmask, pos) do { \
                                                  	  REGISTER_CLEAR_BITS(reg, setmask, pos); \
                                                  	  ((reg) |= ((val) << (pos))); \
                                                	 } while(0)

/**
 * @def REGISTER_SET_BITS
 * @brief Read a number of bits from a given position.
 * Note: The mask (rdmask) is applied to discard the trailing bits that are not of interest for us.
 */
#define REGISTER_READ_BITS(reg, rdmask, pos)		((REGISTER_READ(reg) >> (pos)) & (rdmask))


#endif /* REGISTER_HANDLING_H_ */
