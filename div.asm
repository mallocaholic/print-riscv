# Esse algoritmo printa o resto
#numero no x21
resto:
srli x5,x21,0x1
srli x6,x21,0x2
add x22,x5,x6 # q = ( n >> 1) + ( n >> 2 )

srli x5,x22,0x4
add x22,x22,x5 # q = q + ( q >> 4 )

srli x5,x22,0x8
add x22,x22,x5 # q = q + ( q >> 8 )

srli x5,x22,0x10
add x22,x22,x5 # q = q + ( q >> 8 )

srli x22,x22,0x3 # q = q >> 3
# coloco o resto em x23
slli x23,x22,0x2 # ( q << 2 )
add x23,x23,x22 # (( q << 2 ) + q )
slli x23,x23,0x1 # ((q << 2) + q) << 1
sub x23,x21,x23 # resto = n - (((q << 2) + q) << 1)
# Resultado = q + ( r > 9)
addi x27,x0,0xA 
blt x23,x5,continue
addi x22,x22,0x1
add x23,x0,x0
continue:
addi x23,x23,0x30
sb x22,1024(x0)







