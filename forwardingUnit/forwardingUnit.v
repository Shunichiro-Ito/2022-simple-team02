module forwardingUnit(input [2:0] IDEX_RegRd,EXMEM_RegRd,IFID_RegRs,IFID_RegRd,
                    input IDEX_RegWrite,EXMEM_RegWrite,
                    output [1:0] FwdA,FwdB);
    assign FwdA[1] = (IDEX_RegWrite)&(IDEX_RegRd==IFID_RegRs);
    assign FwdA[0] = (EXMEM_RegWrite)&(EXMEM_RegRd==IFID_RegRs);
    assign FwdB[1] = (IDEX_RegWrite)&(IDEX_RegRd==IFID_RegRd);
    assign FwdB[0] = (EXMEM_RegWrite)&(EXMEM_RegRd==IFID_RegRd);
endmodule