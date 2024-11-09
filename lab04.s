
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
lw t0 0(a0)
lw t1 4(a0)
whileloop:
    bne t0, zero, iflabel
    addi a0, a0, 4
    lw t0 0(a0)
    lw t1 4(a0)
    j whileloop
iflabel:
    blt t0, t1, returnzero
    addi a0, zero, 1
    j out
returnzero:
    add a0, zero, zero
out:
            jr   ra 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------

beq a0, zero, out2
addi t3, zero, 1
beq a0, t3, out2
bne a0, t3, end
addi a0, a0, 4
addi t3, a0, 4
j recCheck
out2:
j str_ge
end:
            jr   ra
