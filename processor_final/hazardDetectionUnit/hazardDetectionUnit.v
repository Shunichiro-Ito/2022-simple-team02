module hazardDetectionUnit (
    input IDEX_memRead,  // pipeline-stall
    input [2:0] IDEX_RegRd,  //pipeline-stall
    input [2:0] IFID_Rs, //pipeline-stall
    input [2:0] IFID_Rd, //pipeline-stall
    input notReadRsRd, //NOP,HLT, LI,B,BE,BLT,BLE,BNEのとき1, pipeline-stall
    input branch, //branch
    output PCWrite, //pipeline-stall
    output IFIDWrite,// pipeline-stall
    output IFFlush, //branch
    output IDFlush );//pipeline-stall

    //branch
    assign IFFlush = branch;

    //pipeline-stall
    wire pipeline_stall;

    assign pipeline_stall =  ((IFID_Rs == IDEX_RegRd) & IDEX_memRead & ~notReadRsRd)
                            |((IFID_Rd == IDEX_RegRd) & IDEX_memRead & ~notReadRsRd);

    assign PCWrite = ~pipeline_stall; 

    assign IFIDWrite = ~pipeline_stall;

    assign IDFlush = pipeline_stall;

    
    

endmodule


