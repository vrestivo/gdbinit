set disassembly-flavor intel

set $RAX = "RAX:\t"
set $RBX = "RBX:\t"
set $RCX = "RCX:\t"
set $RDX = "RDX:\t"
set $RSI = "RSI:\t"
set $RDI = "RDI:\t"
set $RBP = "RBP:\t"
set $RSP = "RSP:\t"
set $RIP = "RIP:\t"

set $R8 = "R8:\t"
set $R9 = "R9:\t"
set $R10 = "R10:\t"
set $R11 = "R11:\t"
set $R12 = "R12:\t"
set $R13 = "R13:\t"
set $R14 = "R14:\t"
set $R15 = "R15:\t"

set $STEP_BANNER = "\n\n\t\t\t************** STEP **************\n\n"
set $INST_BANNER = "\t\t\t********** INSTRUCTIONS **********\n\n"
set $REGS_BANNER = "\n\n\t\t\t********** REGISTERS **********\n\n"
set $EFLAGS_BANNER = "\n\n\t\t\t********** EFLAGS **********\n\n"
set $STACK_BANNER = "\n\n\t\t\t********** STACK **********\n\n"

set $INIT_BP = 0
define hook-stop

  if($INIT_BP == 0)
    set $INIT_BP = $rbp
  end

  printf "%s", $STEP_BANNER

  #print instructions around rip
  printf "%s", $INST_BANNER
  x/16i $rip-12

  #print registers in hex
  printf "%s", $REGS_BANNER
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RAX, $rax, $R8, $r8
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RBX, $rbx, $R9, $r9
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RCX, $rcx, $R10, $r10
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RDX, $rdx, $R11, $r11
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RSI, $rsi, $R12, $r12
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RDI, $rdi, $R13, $r13
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RSP, $rsp, $R14, $r14
  printf "\t%s 0x%016x\t\t %s 0x%016x\n", $RBP, $rbp, $R15, $r15
  
  #print registers in decimal
  printf "\n\n"
  printf "\t%s %16d\t\t %s %16d\n", $RAX, $rax, $R8, $r8
  printf "\t%s %16d\t\t %s %16d\n", $RBX, $rbx, $R9, $r9
  printf "\t%s %16d\t\t %s %16d\n", $RCX, $rcx, $R10, $r10
  printf "\t%s %16d\t\t %s %16d\n", $RDX, $rdx, $R11, $r11
  printf "\t%s %16d\t\t %s %16d\n", $RSI, $rsi, $R12, $r12
  printf "\t%s %16d\t\t %s %16d\n", $RDI, $rdi, $R13, $r13
  printf "\t%s %16d\t\t %s %16d\n", $RSP, $rsp, $R14, $r14
  printf "\t%s %16d\t\t %s %16d\n", $RBP, $rbp, $R15, $r15

  #print eflags register
  printf "%s", $EFLAGS_BANNER
  i r eflags
  printf "\n\n"

  #print stack
  printf "%s", $STACK_BANNER
  print_stack 

end

define print_stack
  set $STACK_SIZE = $INIT_BP-$rsp
  set $COUNTER = 0
  printf "\tThe stack is: %d bytes\n\n", $STACK_SIZE

  while($COUNTER < $STACK_SIZE)
    set $CURRENT = $rbp-($STACK_SIZE-$COUNTER)
    x/xw $CURRENT
    set $COUNTER = $COUNTER += 4
  end
  printf "\n\n"

end
