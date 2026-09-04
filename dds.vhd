`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2026 15:47:44
// Design Name: 
// Module Name: dds
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dds(
    input clk, reset,
    input [15:0] fcw,
    output reg [15:0] dds_out
    );
    
reg [15:0] sine_rom[255:0];
reg [31:0] accumulator;

initial begin
    sine_rom[0] = 16'h0000; // Dec: 0
    sine_rom[1] = 16'h0324; // Dec: 804
    sine_rom[2] = 16'h0648; // Dec: 1608
    sine_rom[3] = 16'h096A; // Dec: 2410
    sine_rom[4] = 16'h0C8C; // Dec: 3212
    sine_rom[5] = 16'h0FAB; // Dec: 4011
    sine_rom[6] = 16'h12C8; // Dec: 4808
    sine_rom[7] = 16'h15E2; // Dec: 5602
    sine_rom[8] = 16'h18F9; // Dec: 6393
    sine_rom[9] = 16'h1C0B; // Dec: 7179
    sine_rom[10] = 16'h1F1A; // Dec: 7962
    sine_rom[11] = 16'h2223; // Dec: 8739
    sine_rom[12] = 16'h2528; // Dec: 9512
    sine_rom[13] = 16'h2826; // Dec: 10278
    sine_rom[14] = 16'h2B1F; // Dec: 11039
    sine_rom[15] = 16'h2E11; // Dec: 11793
    sine_rom[16] = 16'h30FB; // Dec: 12539
    sine_rom[17] = 16'h33DF; // Dec: 13279
    sine_rom[18] = 16'h36BA; // Dec: 14010
    sine_rom[19] = 16'h398C; // Dec: 14732
    sine_rom[20] = 16'h3C56; // Dec: 15446
    sine_rom[21] = 16'h3F17; // Dec: 16151
    sine_rom[22] = 16'h41CE; // Dec: 16846
    sine_rom[23] = 16'h447A; // Dec: 17530
    sine_rom[24] = 16'h471C; // Dec: 18204
    sine_rom[25] = 16'h49B4; // Dec: 18868
    sine_rom[26] = 16'h4C3F; // Dec: 19519
    sine_rom[27] = 16'h4EBF; // Dec: 20159
    sine_rom[28] = 16'h5133; // Dec: 20787
    sine_rom[29] = 16'h539B; // Dec: 21403
    sine_rom[30] = 16'h55F5; // Dec: 22005
    sine_rom[31] = 16'h5842; // Dec: 22594
    sine_rom[32] = 16'h5A82; // Dec: 23170
    sine_rom[33] = 16'h5CB3; // Dec: 23731
    sine_rom[34] = 16'h5ED7; // Dec: 24279
    sine_rom[35] = 16'h60EB; // Dec: 24811
    sine_rom[36] = 16'h62F1; // Dec: 25329
    sine_rom[37] = 16'h64E8; // Dec: 25832
    sine_rom[38] = 16'h66CF; // Dec: 26319
    sine_rom[39] = 16'h68A6; // Dec: 26790
    sine_rom[40] = 16'h6A6D; // Dec: 27245
    sine_rom[41] = 16'h6C23; // Dec: 27683
    sine_rom[42] = 16'h6DC9; // Dec: 28105
    sine_rom[43] = 16'h6F5E; // Dec: 28510
    sine_rom[44] = 16'h70E2; // Dec: 28898
    sine_rom[45] = 16'h7254; // Dec: 29268
    sine_rom[46] = 16'h73B5; // Dec: 29621
    sine_rom[47] = 16'h7504; // Dec: 29956
    sine_rom[48] = 16'h7641; // Dec: 30273
    sine_rom[49] = 16'h776B; // Dec: 30571
    sine_rom[50] = 16'h7884; // Dec: 30852
    sine_rom[51] = 16'h7989; // Dec: 31113
    sine_rom[52] = 16'h7A7C; // Dec: 31356
    sine_rom[53] = 16'h7B5C; // Dec: 31580
    sine_rom[54] = 16'h7C29; // Dec: 31785
    sine_rom[55] = 16'h7CE3; // Dec: 31971
    sine_rom[56] = 16'h7D89; // Dec: 32137
    sine_rom[57] = 16'h7E1D; // Dec: 32285
    sine_rom[58] = 16'h7E9C; // Dec: 32412
    sine_rom[59] = 16'h7F09; // Dec: 32521
    sine_rom[60] = 16'h7F61; // Dec: 32609
    sine_rom[61] = 16'h7FA6; // Dec: 32678
    sine_rom[62] = 16'h7FD8; // Dec: 32728
    sine_rom[63] = 16'h7FF5; // Dec: 32757
    sine_rom[64] = 16'h7FFF; // Dec: 32767
    sine_rom[65] = 16'h7FF5; // Dec: 32757
    sine_rom[66] = 16'h7FD8; // Dec: 32728
    sine_rom[67] = 16'h7FA6; // Dec: 32678
    sine_rom[68] = 16'h7F61; // Dec: 32609
    sine_rom[69] = 16'h7F09; // Dec: 32521
    sine_rom[70] = 16'h7E9C; // Dec: 32412
    sine_rom[71] = 16'h7E1D; // Dec: 32285
    sine_rom[72] = 16'h7D89; // Dec: 32137
    sine_rom[73] = 16'h7CE3; // Dec: 31971
    sine_rom[74] = 16'h7C29; // Dec: 31785
    sine_rom[75] = 16'h7B5C; // Dec: 31580
    sine_rom[76] = 16'h7A7C; // Dec: 31356
    sine_rom[77] = 16'h7989; // Dec: 31113
    sine_rom[78] = 16'h7884; // Dec: 30852
    sine_rom[79] = 16'h776B; // Dec: 30571
    sine_rom[80] = 16'h7641; // Dec: 30273
    sine_rom[81] = 16'h7504; // Dec: 29956
    sine_rom[82] = 16'h73B5; // Dec: 29621
    sine_rom[83] = 16'h7254; // Dec: 29268
    sine_rom[84] = 16'h70E2; // Dec: 28898
    sine_rom[85] = 16'h6F5E; // Dec: 28510
    sine_rom[86] = 16'h6DC9; // Dec: 28105
    sine_rom[87] = 16'h6C23; // Dec: 27683
    sine_rom[88] = 16'h6A6D; // Dec: 27245
    sine_rom[89] = 16'h68A6; // Dec: 26790
    sine_rom[90] = 16'h66CF; // Dec: 26319
    sine_rom[91] = 16'h64E8; // Dec: 25832
    sine_rom[92] = 16'h62F1; // Dec: 25329
    sine_rom[93] = 16'h60EB; // Dec: 24811
    sine_rom[94] = 16'h5ED7; // Dec: 24279
    sine_rom[95] = 16'h5CB3; // Dec: 23731
    sine_rom[96] = 16'h5A82; // Dec: 23170
    sine_rom[97] = 16'h5842; // Dec: 22594
    sine_rom[98] = 16'h55F5; // Dec: 22005
    sine_rom[99] = 16'h539B; // Dec: 21403
    sine_rom[100] = 16'h5133; // Dec: 20787
    sine_rom[101] = 16'h4EBF; // Dec: 20159
    sine_rom[102] = 16'h4C3F; // Dec: 19519
    sine_rom[103] = 16'h49B4; // Dec: 18868
    sine_rom[104] = 16'h471C; // Dec: 18204
    sine_rom[105] = 16'h447A; // Dec: 17530
    sine_rom[106] = 16'h41CE; // Dec: 16846
    sine_rom[107] = 16'h3F17; // Dec: 16151
    sine_rom[108] = 16'h3C56; // Dec: 15446
    sine_rom[109] = 16'h398C; // Dec: 14732
    sine_rom[110] = 16'h36BA; // Dec: 14010
    sine_rom[111] = 16'h33DF; // Dec: 13279
    sine_rom[112] = 16'h30FB; // Dec: 12539
    sine_rom[113] = 16'h2E11; // Dec: 11793
    sine_rom[114] = 16'h2B1F; // Dec: 11039
    sine_rom[115] = 16'h2826; // Dec: 10278
    sine_rom[116] = 16'h2528; // Dec: 9512
    sine_rom[117] = 16'h2223; // Dec: 8739
    sine_rom[118] = 16'h1F1A; // Dec: 7962
    sine_rom[119] = 16'h1C0B; // Dec: 7179
    sine_rom[120] = 16'h18F9; // Dec: 6393
    sine_rom[121] = 16'h15E2; // Dec: 5602
    sine_rom[122] = 16'h12C8; // Dec: 4808
    sine_rom[123] = 16'h0FAB; // Dec: 4011
    sine_rom[124] = 16'h0C8C; // Dec: 3212
    sine_rom[125] = 16'h096A; // Dec: 2410
    sine_rom[126] = 16'h0648; // Dec: 1608
    sine_rom[127] = 16'h0324; // Dec: 804
    sine_rom[128] = 16'h0000; // Dec: 0
    sine_rom[129] = 16'hFCDC; // Dec: -804
    sine_rom[130] = 16'hF9B8; // Dec: -1608
    sine_rom[131] = 16'hF696; // Dec: -2410
    sine_rom[132] = 16'hF374; // Dec: -3212
    sine_rom[133] = 16'hF055; // Dec: -4011
    sine_rom[134] = 16'hED38; // Dec: -4808
    sine_rom[135] = 16'hEA1E; // Dec: -5602
    sine_rom[136] = 16'hE707; // Dec: -6393
    sine_rom[137] = 16'hE3F5; // Dec: -7179
    sine_rom[138] = 16'hE0E6; // Dec: -7962
    sine_rom[139] = 16'hDDDD; // Dec: -8739
    sine_rom[140] = 16'hDAD8; // Dec: -9512
    sine_rom[141] = 16'hD7DA; // Dec: -10278
    sine_rom[142] = 16'hD4E1; // Dec: -11039
    sine_rom[143] = 16'hD1EF; // Dec: -11793
    sine_rom[144] = 16'hCF05; // Dec: -12539
    sine_rom[145] = 16'hCC21; // Dec: -13279
    sine_rom[146] = 16'hC946; // Dec: -14010
    sine_rom[147] = 16'hC674; // Dec: -14732
    sine_rom[148] = 16'hC3AA; // Dec: -15446
    sine_rom[149] = 16'hC0E9; // Dec: -16151
    sine_rom[150] = 16'hBE32; // Dec: -16846
    sine_rom[151] = 16'hBB86; // Dec: -17530
    sine_rom[152] = 16'hB8E4; // Dec: -18204
    sine_rom[153] = 16'hB64C; // Dec: -18868
    sine_rom[154] = 16'hB3C1; // Dec: -19519
    sine_rom[155] = 16'hB141; // Dec: -20159
    sine_rom[156] = 16'hAECD; // Dec: -20787
    sine_rom[157] = 16'hAC65; // Dec: -21403
    sine_rom[158] = 16'hAA0B; // Dec: -22005
    sine_rom[159] = 16'hA7BE; // Dec: -22594
    sine_rom[160] = 16'hA57E; // Dec: -23170
    sine_rom[161] = 16'hA34D; // Dec: -23731
    sine_rom[162] = 16'hA129; // Dec: -24279
    sine_rom[163] = 16'h9F15; // Dec: -24811
    sine_rom[164] = 16'h9D0F; // Dec: -25329
    sine_rom[165] = 16'h9B18; // Dec: -25832
    sine_rom[166] = 16'h9931; // Dec: -26319
    sine_rom[167] = 16'h975A; // Dec: -26790
    sine_rom[168] = 16'h9593; // Dec: -27245
    sine_rom[169] = 16'h93DD; // Dec: -27683
    sine_rom[170] = 16'h9237; // Dec: -28105
    sine_rom[171] = 16'h90A2; // Dec: -28510
    sine_rom[172] = 16'h8F1E; // Dec: -28898
    sine_rom[173] = 16'h8DAC; // Dec: -29268
    sine_rom[174] = 16'h8C4B; // Dec: -29621
    sine_rom[175] = 16'h8AFC; // Dec: -29956
    sine_rom[176] = 16'h89BF; // Dec: -30273
    sine_rom[177] = 16'h8895; // Dec: -30571
    sine_rom[178] = 16'h877C; // Dec: -30852
    sine_rom[179] = 16'h8677; // Dec: -31113
    sine_rom[180] = 16'h8584; // Dec: -31356
    sine_rom[181] = 16'h84A4; // Dec: -31580
    sine_rom[182] = 16'h83D7; // Dec: -31785
    sine_rom[183] = 16'h831D; // Dec: -31971
    sine_rom[184] = 16'h8277; // Dec: -32137
    sine_rom[185] = 16'h81E3; // Dec: -32285
    sine_rom[186] = 16'h8164; // Dec: -32412
    sine_rom[187] = 16'h80F7; // Dec: -32521
    sine_rom[188] = 16'h809F; // Dec: -32609
    sine_rom[189] = 16'h805A; // Dec: -32678
    sine_rom[190] = 16'h8028; // Dec: -32728
    sine_rom[191] = 16'h800B; // Dec: -32757
    sine_rom[192] = 16'h8001; // Dec: -32767
    sine_rom[193] = 16'h800B; // Dec: -32757
    sine_rom[194] = 16'h8028; // Dec: -32728
    sine_rom[195] = 16'h805A; // Dec: -32678
    sine_rom[196] = 16'h809F; // Dec: -32609
    sine_rom[197] = 16'h80F7; // Dec: -32521
    sine_rom[198] = 16'h8164; // Dec: -32412
    sine_rom[199] = 16'h81E3; // Dec: -32285
    sine_rom[200] = 16'h8277; // Dec: -32137
    sine_rom[201] = 16'h831D; // Dec: -31971
    sine_rom[202] = 16'h83D7; // Dec: -31785
    sine_rom[203] = 16'h84A4; // Dec: -31580
    sine_rom[204] = 16'h8584; // Dec: -31356
    sine_rom[205] = 16'h8677; // Dec: -31113
    sine_rom[206] = 16'h877C; // Dec: -30852
    sine_rom[207] = 16'h8895; // Dec: -30571
    sine_rom[208] = 16'h89BF; // Dec: -30273
    sine_rom[209] = 16'h8AFC; // Dec: -29956
    sine_rom[210] = 16'h8C4B; // Dec: -29621
    sine_rom[211] = 16'h8DAC; // Dec: -29268
    sine_rom[212] = 16'h8F1E; // Dec: -28898
    sine_rom[213] = 16'h90A2; // Dec: -28510
    sine_rom[214] = 16'h9237; // Dec: -28105
    sine_rom[215] = 16'h93DD; // Dec: -27683
    sine_rom[216] = 16'h9593; // Dec: -27245
    sine_rom[217] = 16'h975A; // Dec: -26790
    sine_rom[218] = 16'h9931; // Dec: -26319
    sine_rom[219] = 16'h9B18; // Dec: -25832
    sine_rom[220] = 16'h9D0F; // Dec: -25329
    sine_rom[221] = 16'h9F15; // Dec: -24811
    sine_rom[222] = 16'hA129; // Dec: -24279
    sine_rom[223] = 16'hA34D; // Dec: -23731
    sine_rom[224] = 16'hA57E; // Dec: -23170
    sine_rom[225] = 16'hA7BE; // Dec: -22594
    sine_rom[226] = 16'hAA0B; // Dec: -22005
    sine_rom[227] = 16'hAC65; // Dec: -21403
    sine_rom[228] = 16'hAECD; // Dec: -20787
    sine_rom[229] = 16'hB141; // Dec: -20159
    sine_rom[230] = 16'hB3C1; // Dec: -19519
    sine_rom[231] = 16'hB64C; // Dec: -18868
    sine_rom[232] = 16'hB8E4; // Dec: -18204
    sine_rom[233] = 16'hBB86; // Dec: -17530
    sine_rom[234] = 16'hBE32; // Dec: -16846
    sine_rom[235] = 16'hC0E9; // Dec: -16151
    sine_rom[236] = 16'hC3AA; // Dec: -15446
    sine_rom[237] = 16'hC674; // Dec: -14732
    sine_rom[238] = 16'hC946; // Dec: -14010
    sine_rom[239] = 16'hCC21; // Dec: -13279
    sine_rom[240] = 16'hCF05; // Dec: -12539
    sine_rom[241] = 16'hD1EF; // Dec: -11793
    sine_rom[242] = 16'hD4E1; // Dec: -11039
    sine_rom[243] = 16'hD7DA; // Dec: -10278
    sine_rom[244] = 16'hDAD8; // Dec: -9512
    sine_rom[245] = 16'hDDDD; // Dec: -8739
    sine_rom[246] = 16'hE0E6; // Dec: -7962
    sine_rom[247] = 16'hE3F5; // Dec: -7179
    sine_rom[248] = 16'hE707; // Dec: -6393
    sine_rom[249] = 16'hEA1E; // Dec: -5602
    sine_rom[250] = 16'hED38; // Dec: -4808
    sine_rom[251] = 16'hF055; // Dec: -4011
    sine_rom[252] = 16'hF374; // Dec: -3212
    sine_rom[253] = 16'hF696; // Dec: -2410
    sine_rom[254] = 16'hF9B8; // Dec: -1608
    sine_rom[255] = 16'hFCDC; // Dec: -804
end

always@(posedge clk) begin
    if (reset) begin
        accumulator <= 32'b0;
        dds_out <= 32'b0; 
    end else begin
        accumulator <= accumulator + fcw;
        dds_out <= sine_rom[accumulator[31:24]]; 
    end
end
endmodule
