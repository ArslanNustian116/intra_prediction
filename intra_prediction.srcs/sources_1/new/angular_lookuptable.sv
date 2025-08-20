    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 06/17/2025 04:14:00 PM
    // Design Name: 
    // Module Name: angular_lookup_table
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
    
    
    module angular_lookup_table(
        input logic [3:0] mode,
        output logic [7:0] A,
        input logic hori_Ver
        );
        
        
    //Look Up Table implemented as a ROM
    logic [7:0] look_table_A[2:17];
     
    always_comb
    if(hori_Ver==1)
    begin
    case(mode) 
    2:A=32;
    3:A=26;
    4:A=21;
    5:A=17;
    6:A=13;
    7:A=9;
    8:A=5;
    9:A=2;
    10:A=0;
    11:A=-2;
    12:A=-5;
    13:A=-9;
    14:A=-13;
    15:A=-17;
    16:A=-21;
    17:A=-26;
    
    default : A=0;
    
    endcase    
    end
    
    else
    begin
    case(mode)
    2:A=32;
    3:A=26;
    4:A=21;
    5:A=17;
    6:A=13;
    7:A=9;
    8:A=5;
    9:A=2;
    10:A=0;
    11:A=-2;
    12:A=-5;
    13:A=-9;
    14:A=-13;
    15:A=-17;
    16:A=-21;
    17:A=-26;
    default : A=0;
    
    endcase
    end
        
       
        
        
    endmodule

