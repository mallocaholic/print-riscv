# Esse algoritmo printa o resto
beq x0,x0,main

size_10:
    addi x7,x0,0x1
    addi x27,x0,0x0
    loop_s10:
        bge x7,x21,back
        slli x6,x7,0x1
        slli x7,x7,0x3
        add x7,x6,x7 #Multiplica por 10
        addi x27,x27,0x1 # retorna x27
        beq x0,x0,loop_s10

    back:
        beq x0,x0,size

#resto numero no x21
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
    addi x5,x0,0xA 
    blt x23,x5,continue
    addi x22,x22,0x1
    add x23,x0,x0
    continue:
    jalr x0,0(x1)


printar_numero:
    beq x0,x0,size_10 # pega o tamanho do numero
    size:
	addi sp,sp,-4
    sw x1,0(sp) # Endereco na pilha

    addi x31,x0,0x1 # iterator
    addi x6,x0,0x1 # 1

	add x18,x0,x21

    bge x27,x6,loop_print
    end_print:
        addi x21,x21,0x30
        sb x21,1024(x0)
        lw x1,0(sp)
        jalr x0,0(x1)
	keep:
	add x18,x0,x21
    loop_print:
		addi x0,x0,0x0
        jal x1,resto
		
		add x21,x0,x22 # passa a referencia
		
		addi x6,x0,0x1
        addi x31,x31,0x1 # i++

        blt x31,x27,loop_print
        addi x31,x0,0x1

        addi x30,x22,0x30
        sb x30,1024(x0)
		add x28,x22,x0
    loop_mult:
        slli x29,x28,0x1
        slli x28,x28,0x3
        add x28,x28,x29 # x22 * 10n

        addi x31,x31,0x1 #iterator
        bge x31,x27,end_mult
        beq x0,x0,loop_mult

        end_mult:
        sub x21,x18,x28
        sub x27,x27,x6 # - 1
        addi x31,x0,0x1 # zera iterator
        bne x27,x31,keep
        beq x0,x0,end_print

#numero no x21
main:
addi x21,x0,0x83
jal x1,printar_numero




